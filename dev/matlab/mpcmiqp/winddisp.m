%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wind power dispatch with battery energy storage using state-space model
% predictive control (MPC).
%
% Author:  Silvio Tarca
% Date:    August 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A single binary (dummy) variable for each time interval in the control
% horizon ensures linear complementarity -- battery charge and discharge
% control signals cannot both be different from zero at the same time.
% Assumes that reference signals over the prediction horizon are set to the 
% target baseload power calibrated to the daily load profile of the season.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

timesta = tic;  % Record start time for execution of program

m = 2;          % Length of single-period process output vector
s = 4;          % Length of single-period state vector
q = 3;          % Length of single-period control increment vector
d = 1;          % Number of binary (dummy) variables for each time interval
                % in the control horizon, w
n = 1;          % Number of time intervals in prediciton and control horizons

rofftol = 1e-04;% Round-off tolerance to account for errors arising from
                % floating point operations

delta = 1/12;   % Conversion factor from MW to MWh for given dispatch interval
                % (i.e., 5 minutes = 1/12 of an hour)
eta = 0.92;     % One-way battery charge/discharge efficiency
base = 100;     % Base (MW and MWh) for per-unit (dimensionless) quantities

% Define power and energy in terms of per unit base quantity
windcap = 1.00*base;    % Wind farm registered capacity (MW)
battcap = 0.50*base;    % Battery storage capacity (MWh)
battrt = 0.50*battcap;  % Battery rated power (MW)
% Define daily average reference signal, or set point, for power dispatched
% to the grid (MW)
refpdavg = transpose( 0.00:0.025:0.75 ) * base;
rho = size( refpdavg, 1 );

% Define matrices describing incremental state-space model
A = [ 1 delta*eta -delta/eta 0; 0 1 0 0; 0 0 1 0; 0 0 0 1 ];
B = [ delta*eta -delta/eta 0; 1 0 0; 0 1 0; 0 0 1 ];
C = [ 1 0 0 0; 0 -1 1 1 ];
[ K, L ] = wmpckl( m, s, q, d, n, A, B, C );

% Read data from input files, i.e., load profile for typical summer and 
% winter days, and unconstrained intermittent generation forecasts
loadfile = '/Users/starca/projects/firmwind/dev/data/in/load_prof_norm.dat';
dispfile = '/Users/starca/projects/firmwind/dev/data/in/dispatch_snowtwn1.csv';
[ refpdnrm, uigf ] = wmpcread( loadfile, dispfile );
%dispfile = '/Users/starca/dev/matlab/wind/data/in/dispatch_lkbonny2.csv';
%[ refpdnrm, uigfse ] = wmpcread( loadfile, dispfile );
% Registered capacity for SNOWTWN1 (mid-north) is 100 MW, and  LKBONNY2 
% (south-east) is 159 MW.  Scale combined output to 100 MW base quantity
%uigf = 50/100*uigfmn + 50/159*uigfse;
% Calculate the number of time steps in the simulation horizon
N = size( uigf,1 ) - n + 1;
fprintf( 'Load profile file is: %s\n', loadfile );
fprintf( 'Dispatch file is: %s\n', dispfile );
fprintf( 'Number of time steps in simulation horizon, N = %d\n', N );

% Define upper and lower bounds on state variables: battery state of charge 
% (SOC) e; battery charge command p_{b+}; battery discharge command p_{b-};
% and wind power generation command p_{w}
zlb = [ 0.125*battcap; 0.00*battrt; 0.00*battrt; 0.00*windcap ];
zub = [ 0.875*battcap; 0.80*battrt; 0.80*battrt; 1.00*windcap ];

% Define scalar weighting coefficient, and weighting matrices and vector
lambda = 0.0;
omega = [ 0.0; 1.0 ];
psi = [ 1.0; 1.0; 0.0 ];
[ lambda, Omega, Psi ] = wmpcwgt( m, q, d, n, lambda, omega, psi );

% Set options for MATLAB/CPLEX mixed integer quadratic program (MIQP)
%options = cplexoptimset( 'Display', 'off', 'TolFun', 1e-12, 'TolX', 1e-12 );

for r = 1:rho   % For each simulation iteration corresponding to a different
                % reference trajectory representing target baseload power
    
    fprintf( 'Set point for power dispatched to the grid: %.1f MW\n', ...
        refpdavg(r) );
    % Set wind power p_{w} equal to UIFG over the prediction horizon
    pw = uigf(1:n);
    % Define initial value of observable state variable: battery SOC e
    x0 = ( zlb(1) + zub(1) ) / 2.0;
    % Define initial values of internal state variables: battery charge 
    % command p_{b+}; battery discharge command p_{b-}; and wind power 
    % generation command p_{w}
    ulast = [ 0.00*battrt; 0.00*battrt; pw(1) ];
    % Define initial state vector:
    z0 = [ x0; ulast ];
    % Set reference signals for process outputs over the prediction horizon
    refsoc = ones( n, 1 ) * x0;
    refpd = refpdnrm(1:n) * refpdavg(r);
    ref = wmpcref( m, n, refsoc, refpd );

    % Declare output matrix used to verify simulation results.  Columns: 
    % e, p_{d}, ref[e], ref[p_{d}], p_{b+}, p_{b-}, p_{w}, w_{+}, w{-}
    Y = zeros( N, 2*m+q+d*n );
    % Initialise simulation output variables: count of dispatch intervals
    % when wind power and power dispatched equal or exceed baseload set point
    pwcnt = 0;
    pdcnt = 0;
    
    % Define quadratic term of performance index (objective function of MIQP)
    H = transpose(L)*Omega*L + lambda*Psi;
    % Set type for each variable in the argument argument vector of MIQP
    ctype = wmpctype( q, d, n );
    for k = 1:N     % For each time step in simulation

        % Define constraints on optimisation of the performance index
        [ G, h ] = wmpccstr( m, q, d, n, delta, eta, z0, pw, zlb, zub );
        % Define linear term of the performance index (obj func of MIQP)
        f = transpose(K*z0 - ref)*Omega*L;
        % Optimise performance index using quadratic programming
        [v, fval, exitflag, output] = cplexmiqp( ...
            H, f, G, h, [], [], [], [], [], [], [], ctype );
        % Check for optimization errors/ warnings
        if ( exitflag < 1 )
            fprintf( 'Error: Solver terminated with exitflag = %d ', exitflag );
            fprintf( 'at time step %d of simulation.\n', k);
            return; % Exit script
        end
        % Evaluate process outputs and control signals
        [ du, u, y, w ] = wmpceval( q, d, n, K, L, ulast, z0, v );
        
        % Populate output matrix
        for j = 1:m
            Y(k,j) = y(j);
            Y(k,m+j) = ref(j);
        end
        for j = 1:q
            Y(k,2*m+j) = u(j);
        end
        for j = 0:n-1
            Y(k,2*m+q+d*j+1) = w(d*j+1);
        end
        % Accumulate statistics
        if ( u(q) > ref(m)-rofftol )
            pwcnt = pwcnt + 1;
        end
        if ( y(m) > ref(m)-rofftol )
            pdcnt = pdcnt + 1;
        end

        % Reset variables for next simulation iteration
        x0 = y(1);
        ulast = u(1:q);
        z0 = [ x0; ulast ];
        if ( k < N )
            pw = uigf(k+1:k+n);
            refsoc = ones( n, 1 ) * x0;
            refpd = refpdnrm(k+1:k+n) * refpdavg(r);
            ref = wmpcref( m, n, refsoc, refpd );
        end
        
    end

    Upsilon = [ battcap/base zlb(1)/base zub(1)/base zub(2)/base zub(3)/base ...
        windcap/base refpdavg(r)/base N pwcnt pwcnt/N*100 pdcnt pdcnt/N*100 ];
    
    % Write simulation results to file
    yfile = sprintf('../data/baseload_snowtwn1_r%.2d.csv', r);
    dlmwrite( yfile, Y, 'precision', 8 );
    dlmwrite( '../data/baseload_snowtwn1.dat', Upsilon, ...
        'delimiter', '\t', 'precision', 8, '-append' );

end

timeelap = toc( timesta );  % Measure elapsed time for execution of program
fprintf( 'Elapsed time: %.1f seconds\n', timeelap );

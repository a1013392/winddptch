function [ ref ] = wmpcref( m, n, refsoc, refpd )
% Constructs the reference signal, or set point, vector against which the
% process output is benchmarked.  The performance index penalises the
% tracking error of the process output relative to the reference signal.

    % ref is a column vector of length m process output variables times n 
    % time periods over the prediction horizon.
    ref = zeros( m*n, 1 );
    for k = 0:n-1
        ref(k*m+1) = refsoc(k+1);
        ref(k*m+m) = refpd(k+1);
    end

return


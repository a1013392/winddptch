function [ refpdnrm, uigf ] = wmpcread( loadfile, dispfile )
% Reads files: loadfile containing normalised 30-minute load profile data; 
% and dispfile containing 5-minute dispatch data.  The former includes 48 
% time intervals for the typical summer and winter day, while the latter
% includes unconstrained intermittent generation forecasts (UIGF).  The
% function returns: refpdnrm, the normalised load (average 30-minute load 
% during the typical summer or winter day is equal to 1.0) for each
% 5-minute dispatch interval; and uigf, the unconstrained intermittent 
% generation forecast for each dispatch interval.

    % Define vector of winter months (from April to September)
    winter = [ 4 5 6 7 8 9 ];

    % Read dispatch file
    D = dlmread( dispfile, ',' );
    % Assign a daily 30-minute time interval to each dispatch record
    tmint = D(:,1);             % Dispatch intervals in format yyyymmddiii
    tau = size( tmint, 1 );     % Number of disptach intervals
    tmint = mod( tmint, 1000 ); % Daily 5-minute dispatch intervals iii in
                                % {1, 2, ..., 288}
    tmint = fix( (tmint-1)/6 ) + 1; % Convert 5-minute dispatch intervals to
                                % 30-minute time intervals in {1, 2, ..., 48}
    % Assign a season (1-summer or 2-winter) to each dispatch record
    season = D(:,1);            % Dispatch intervals in format yyyymmddiii
    season = fix( season/100000 );  % Year and month in format yyyymm
    season = mod (season, 100 );    % Month in {1, 2, ..., 12}
    season = ismember( season, winter) + 1;
    % Read normalised summer and winter daily load profiles with 30-minute
    % resolution -- skip first row (header) and first three columns (time)
    P = dlmread( loadfile, '\t', 1, 3 );
    % Define vector of normalised reference signals for power dispatched to
    % the grid
    refpdnrm = zeros( tau, 1);
    for t = 1:tau
        refpdnrm(t) = P(tmint(t),season(t));
    end
    
    % Define vector of unconstrained intermittent generation forecasts
    uigf = D(:,4);

end


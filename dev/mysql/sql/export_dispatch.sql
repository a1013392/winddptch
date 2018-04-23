/****************************************************************************** 
 * SQL script for exporting files for given DUID (dispatch project):
 * dispatch_snowtwn1.dat
 *****************************************************************************/

\! echo "USE sagrid"
USE sagrid

SET @duid = 'SNOWTWN1', @int_sta = 20151201001, @int_end = 20151231288;

\! echo "SELECT * FROM TABLE dispatch INTO OUTFILE /home/silvio/mysql/data/out/dispatch_snowtwn1.dat"
SELECT dispatch_interval, wind_power, dispatch_level, uigf, dispatch_cap
FROM dispatch
WHERE duid = @duid
AND dispatch_interval >= @int_sta
AND dispatch_interval <= @int_end
INTO OUTFILE '/home/silvio/mysql/data/out/dispatch_snowtwn1.dat'
COLUMNS TERMINATED BY '\t'
;
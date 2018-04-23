/****************************************************************************** 
 * SQL script for loading tables in sagrid database from data files
 *(dispatch project):
 * dispatch.dat
 * interval.dat
 * dispatch_unit.dat
 *****************************************************************************/

\! echo "USE sagrid"
USE sagrid


\! echo "LOAD DATA LOCAL INFILE '/home/silvio/mysql/data/in/dispatch.dat' INTO TABLE dispatch"
LOAD DATA LOCAL INFILE '/home/silvio/mysql/data/in/dispatch.dat'
INTO TABLE dispatch
COLUMNS TERMINATED BY '\t'
;

\! echo "LOAD DATA LOCAL INFILE '/home/silvio/mysql/data/in/dispatch_interval.dat' INTO TABLE dispatch_interval"
LOAD DATA LOCAL INFILE '/home/silvio/mysql/data/in/dispatch_interval.dat'
INTO TABLE dispatch_interval
COLUMNS TERMINATED BY '\t'
;



 
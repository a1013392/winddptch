/****************************************************************************** 
 * SQL script for creating tables in sagrid database (dispatch project):
 * dispatch
 * dispatch_interval
 * dispatch_unit
 *****************************************************************************/

\! echo "USE sagrid"
USE sagrid

\! echo "CREATE TABLE dispatch"
DROP TABLE IF EXISTS dispatch;
CREATE TABLE dispatch (
dispatch_interval bigint unsigned not null,
duid char(8) not null,
wind_power float not null,
dispatch_level float not null,
uigf float not null,
dispatch_cap boolean not null
);
DESCRIBE dispatch;

\! echo "CREATE TABLE dispatch_interval"
DROP TABLE IF EXISTS dispatch_interval;
CREATE TABLE dispatch_interval (
dispatch_interval bigint unsigned not null,
dispatch_date date not null,
dispatch_time time not null
);
DESCRIBE dispatch_interval;

\! echo "CREATE TABLE dispatch_unit"
DROP TABLE IF EXISTS dispatch_unit;
CREATE TABLE dispatch_unit (
duid char(8) not null,
station_name char(32),
fuel_source char(16),
units smallint unsigned,
capacity float
);
DESCRIBE dispatch_unit;

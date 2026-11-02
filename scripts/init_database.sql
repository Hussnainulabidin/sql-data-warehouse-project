
/*
Check weather the dababase exists or not, if it exists then drop the database and create a new one.
Scripts sets up the database with three schemas bronze, silver and gold.
*/

use master;
Go
if exists (select 1 from sys.databases where name='DataWarehouse')
begin
	alter database dataWarehouse set single_user with rollback immediate;
	drop database dataWarehouse;
end
Go


create database DataWarehouse;
Go
use DataWarehouse;
GO

create schema bronze;
Go
create schema silver;
Go
create schema gold;

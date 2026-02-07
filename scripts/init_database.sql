-- runinng this script will drop the entire datawarehouse database if it exists.
--create database and scripts
use master;
go
--drop and recreate the 'datawarehouse' database
if exists (select 1 from sys.databases where name = 'datawarehouse')
begin
  alter database datawarehouse set single user with rollback immediate;
  drop database datawarehouse;
end;
go
--create the datawarehouse database
create database datawarehouse;
go
use datawarehouse;
go
--create schemas
create schema bronze;
go
create schema silver;
go
create schema gold;
go

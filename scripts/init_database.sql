/*
========================================================================
Create Database and Schemas
========================================================================
Script Purpose:
	This script creates a new database named 'DataWarehouse' after checking if it already exists.
	If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
	within the database: 'bronze', 'silver', and 'gold'

WARNING:
	Running this script will drop tthe entire 'DataWarehouse' database if it exists.
	All data in the database will be permanetly deleted. Proceed with caution
	and ensure you have proper backups before running this script.
*/
-- Create Database 'DataWarehouse' 

USE master;
GO

-- Kiem tra xem da co csdl 'DataWarehouse' hay chua 
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
END;
GO 

-- Tao csdl ten la DataWarehouse
CREATE DATABASE DataWarehouse; 
GO

USE DataWarehouse; 
GO

-- Tao ra cac schema 
CREATE SCHEMA bronze; 
GO
  
CREATE SCHEMA silver; 
GO
  
CREATE SCHEMA gold; 
GO

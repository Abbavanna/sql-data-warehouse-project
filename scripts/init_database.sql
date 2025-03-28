-- Check if the Data Warehouse database already exists
IF DB_ID('datawarehouse') IS NOT NULL  
BEGIN  
    PRINT 'Warning: Database "datawarehouse" already exists. Skipping creation.';  
END  
ELSE  
BEGIN  
    -- Switch to the master database to ensure we are in the correct context
    USE master;

    -- Create the Data Warehouse database
    CREATE DATABASE datawarehouse;
    
    PRINT 'Database "datawarehouse" has been created successfully.';
END
GO

-- Switch to the Data Warehouse database
USE datawarehouse;
GO

-- Create schemas (no existence checks)
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

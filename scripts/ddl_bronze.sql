create table bronze.crm_cust_info (

cst_id int,cst_key nvarchar(50),cst_firstname nvarchar(50),
cst_lastname nvarchar(50),cst_material_status nvarchar(50), cst_gndr nvarchar(50), cst_create_Date DATE

)

create table bronze.crm_prd_info (

prd_id int,prd_key nvarchar(50),prd_nm nvarchar(50),
prd_cost int,prd_line nvarchar(50), prd_start_date date, prd_end_date DATE

)

create table bronze.crm_sales_det(

sls_ord_num nvarchar(50),sls_prd_key nvarchar(50),sls_cust_id int,
sls_order_dt date,sls_ship_Dt date, sls_due_dt date, sls_sales int, sls_quantity int, sls_price int

)

create table bronze.erp_cust_dt(

cust_cid nvarchar(50), cust_bdate date, cust_gend nvarchar(10)

)

create table bronze.erp_loc_dt(

loc_cid nvarchar(50), loc_cntry nvarchar(50)

)

create table bronze.erp_pr_cat(

pc_id nvarchar(50), pc_cat nvarchar(50), pc_subcat nvarchar(50), pc_maintenance nvarchar(50)

)


-- Modify columns individually in separate ALTER COLUMN statements
ALTER TABLE bronze.crm_sales_det
DROP COLUMN sls_order_dt, sls_ship_dt, sls_due_dt;

ALTER TABLE bronze.crm_sales_det
Add  sls_order_dt int, sls_ship_dt int , sls_due_dt int;
---------------- STORED PROCEDURE FOR BRONZE LAYER------------------

create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime
	
	begin try
		set @batch_start_time = GETDATE()
		print '==========================================================================='
		print 'Loading Bronze Layer'
		print '==========================================================================='

		print '***************************************************************************'
		print 'Loading CRM Tables'

		set @start_time = GETDATE()
		print '>> Truncating table: bronze.crm_cust_info'
		truncate table bronze.crm_cust_info
		print '>> Inserting data into table: bronze.crm_cust_info'
		bulk insert bronze.crm_cust_info 
		from 'C:\Users\pavan\OneDrive - GISMA University of Applied Sciences GmbH\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with( firstrow = 2, fieldterminator = ',', tablock)
		set @end_time = GETDATE()
		print '<<>> Load Duration '+ cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds'
		--------------------------------------------------------------------------------------------------
		set @start_time = GETDATE()
		print '>> Truncating table: bronze.crm_prd_info'
		truncate table bronze.crm_prd_info
		print '>> Inserting data into table: bronze.crm_prd_info'
		bulk insert bronze.crm_prd_info 
		from 'C:\Users\pavan\OneDrive - GISMA University of Applied Sciences GmbH\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with( firstrow = 2, fieldterminator = ',', tablock)
		set @end_time = GETDATE()
		print '<<>> Load Duration '+ cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds'
		--------------------------------------------------------------------------------------------------
		set @start_time = GETDATE()
		print '>> Truncating table: bronze.crm_sales_det'
		truncate table bronze.crm_sales_det
		print '>> Inserting data into table: bronze.crm_sales_det'
		bulk insert bronze.crm_sales_det
		from 'C:\Users\pavan\OneDrive - GISMA University of Applied Sciences GmbH\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with( firstrow = 2, fieldterminator = ',', tablock)
		set @end_time = GETDATE()
		print '<<>> Load Duration '+ cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds'
		--------------------------------------------------------------------------------------------------
		print '***************************************************************************'
		print 'Loading ERP Tables'
		set @start_time = GETDATE()
		print '>> Truncating table: bronze.erp_cust_dt'
		truncate table bronze.erp_cust_dt
		print '>> Inserting data into table: bronze.erp_cust_dt'
		bulk insert bronze.erp_cust_dt
		from 'C:\Users\pavan\OneDrive - GISMA University of Applied Sciences GmbH\Desktop\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with( firstrow = 2, fieldterminator = ',', tablock)
		set @end_time = GETDATE()
		print '<<>> Load Duration '+ cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds'
		--------------------------------------------------------------------------------------------------
		set @start_time = GETDATE()
		print '>> Truncating table: bronze.erp_loc_dt'
		truncate table bronze.erp_loc_dt
		print '>> Inserting data into table: bronze.erp_loc_dt'
		bulk insert bronze.erp_loc_dt
		from 'C:\Users\pavan\OneDrive - GISMA University of Applied Sciences GmbH\Desktop\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with( firstrow = 2, fieldterminator = ',', tablock)
		set @end_time = GETDATE()
		print '<<>> Load Duration '+ cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds'
		--------------------------------------------------------------------------------------------------
		set @start_time = GETDATE()
		print '>> Truncating table: bronze.erp_pr_cat'
		truncate table bronze.erp_pr_cat
		print '>> Inserting data into table: bronze.erp_pr_cat'
		bulk insert bronze.erp_pr_cat
		from 'C:\Users\pavan\OneDrive - GISMA University of Applied Sciences GmbH\Desktop\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with( firstrow = 2, fieldterminator = ',', tablock)
		set @end_time = GETDATE()
		print '<<>> Load Duration '+ cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds'
		set @batch_end_time = GETDATE()
		print '=============================================================================================='
		print '=============================================================================================='
		print '<<>> Load Duration for entire bronze layer '+ cast(datediff(second,@start_time,@end_time) as nvarchar)+' seconds'
		end try
		
	begin catch
		print '=============================================================================================='
		print 'Error occured during loading bronze layer'
		print 'Error message'+ error_message() 
		print 'Error number'+cast(error_number() as nvarchar)
		print '=============================================================================================='
	end catch
end

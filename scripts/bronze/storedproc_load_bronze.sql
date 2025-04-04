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

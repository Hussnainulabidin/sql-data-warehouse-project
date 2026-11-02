create or alter procedure bronze.load_bronze as 
begin
	declare @start_time datetime, @end_time datetime , @wholebatch_start_time datetime, @wholebatch_end_time datetime
	begin try
		set @wholebatch_start_time = getdate();
		print '===========================================';
		print 'Loading Bronze layer';
		print '===========================================';

		print '-------------------------------------------';
		print 'Loading CRM Tables';
		print '-------------------------------------------';

		print '>> Truncating Table: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;
		set @start_time = getdate();
		print '>> Inserting Data: bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'D:\Programming\DataEng\Data-Warehouse\01_datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print 'Load Duration: ' + cast(datediff(second , @start_time, @end_time) as nvarchar) + ' seconds'
		print '+++++++++++++++++'

		print '>> Truncating Table: bronze.crm_sales_details';
		truncate table bronze.crm_sales_details;
		set @start_time = getdate();
		print '>> Inserting Data: bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'D:\Programming\DataEng\Data-Warehouse\01_datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print 'Load Duration: ' + cast(datediff(second , @start_time, @end_time) as nvarchar) + ' seconds'
		print '+++++++++++++++++'

		print '>> Truncating Table: bronze.crm_prd_info';
		truncate table bronze.crm_prd_info;
		set @start_time = getdate();
		print '>> Inserting Data: bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from 'D:\Programming\DataEng\Data-Warehouse\01_datasets\source_crm\PRD_INFO.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print 'Load Duration: ' + cast(datediff(second , @start_time, @end_time) as nvarchar) + ' seconds'
		print '+++++++++++++++++'
	

		print '-------------------------------------------';
		print 'Loading ERP Tables';
		print '-------------------------------------------';

		print '>> Truncating Table: bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;
		set @start_time = getdate();
		print '>> Inserting Data: bronze.erp_cust_az12';
		bulk insert bronze.erp_cust_az12
		from 'D:\Programming\DataEng\Data-Warehouse\01_datasets\source_erp\CUST_AZ12.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		)
		set @end_time = getdate();
		print 'Load Duration: ' + cast(datediff(second , @start_time, @end_time) as nvarchar) + ' seconds'
		print '+++++++++++++++++'

		print '>> Truncating Table: bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101;
		set @start_time = getdate();
		print '>> Inserting Data: bronze.erp_loc_a101';
		bulk insert bronze.erp_loc_a101
		from 'D:\Programming\DataEng\Data-Warehouse\01_datasets\source_erp\LOC_A101.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		)
		set @end_time = getdate();
		print 'Load Duration: ' + cast(datediff(second , @start_time, @end_time) as nvarchar) + ' seconds'
		print '+++++++++++++++++'

		print '>> Truncating Table: ronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2;
		set @start_time = getdate();
		print '>> Inserting Data: ronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2
		from 'D:\Programming\DataEng\Data-Warehouse\01_datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print 'Load Duration: ' + cast(datediff(second , @start_time, @end_time) as nvarchar) + ' seconds'
		print '+++++++++++++++++'
		set @wholebatch_end_time = getdate();
		print 'Bronze layer Load Duration: ' + cast(datediff(second , @wholebatch_start_time, @wholebatch_end_time) as nvarchar) + ' seconds'
	end try
	begin catch
		print '===========================================';
		print 'Error Occured During loading Bronze Layer'
		print 'Error Message' + error_message();
		print 'Error Number' + cast (error_number() as nvarchar);
		print '===========================================';
	end catch
end



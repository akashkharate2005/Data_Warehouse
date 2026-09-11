use DataWarehouse;
go

-- this procedure will help to lead the data into all the schemas
create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime, @end_time datetime,@batch_start_time datetime, @batch_end_time datetime;
	begin try
		set @batch_start_time = getdate();
		print '============================';
		print 'loading the bronze layer';
		print '============================';

		print '----------------------------';
		print 'loading CRM tables';
		print '----------------------------';

		set @start_time = getdate();
		print '>> truncating table : bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;
		print 'loading data in : bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'C:\Users\khara\Desktop\COMPUTER SCIENCE\Data Warehousing Project\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock -- look into the whole table
		);
		
		set @end_time = getdate();
		print'>> load duration  ='+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
		print'>>----------------';
		select count(*) from bronze.crm_cust_info;

		--------------------------------------------------
		---------------------------------------------------

		set @start_time = getdate();
		print '>> truncating table : bronze.crm_prod_info';
		truncate table bronze.crm_prod_info;
		print '>>loading data in : bronze.crm_prod_info';
		bulk insert bronze.crm_prod_info
		from 'C:\Users\khara\Desktop\COMPUTER SCIENCE\Data Warehousing Project\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock -- look into the whole table
		);
		set @end_time = getdate();
		print'>> load duration  ='+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
		print'>>----------------';
		select count(*) from bronze.crm_prod_info;

		----------------------------------------------
		----------------------------------------------
		set @start_time = getdate();
		print '>> truncating table : bronze.crm_sales_details';
		truncate table bronze.crm_sales_details;
		print '>> loading data in : bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'C:\Users\khara\Desktop\COMPUTER SCIENCE\Data Warehousing Project\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock -- look into the whole table
		);
		set @end_time = getdate();
		print'>> load duration  ='+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
		print'>>----------------';
		select count(*) from bronze.crm_sales_details;

		----------------------------------------------
		----------------------------------------------
		print '----------------------------';
		print 'loading ERP tables';
		print '----------------------------';

		set @start_time = getdate();
		print '>> truncating table : bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101;
		print 'loading data in : bronze.erp_loc_a101';
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\khara\Desktop\COMPUTER SCIENCE\Data Warehousing Project\datasets\source_erp\LOC_A101.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock -- look into the whole table
		);
		set @end_time = getdate();
		print'>> load duration  ='+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
		print'>>----------------';
		select count(*) from bronze.erp_loc_a101;

		----------------------------------------------
		----------------------------------------------
		set @start_time = getdate();
		print '>> truncating table : bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;
		print '>> loading data in : bronze.erp_cust_az12';
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\khara\Desktop\COMPUTER SCIENCE\Data Warehousing Project\datasets\source_erp\CUST_AZ12.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock -- look into the whole table
		);
		set @end_time = getdate();
		print'>> load duration  ='+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
		print'>>----------------';

		select count(*) from bronze.erp_cust_az12;

		----------------------------------------------
		----------------------------------------------
		set @start_time = getdate();
		print '>> truncating table : bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2;
		print 'loading data in : bronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\khara\Desktop\COMPUTER SCIENCE\Data Warehousing Project\datasets\source_erp\PX_CAT_G1V2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock -- look into the whole table
		);
		set @end_time = getdate();
		print'>> load duration  ='+cast(datediff(second,@start_time,@end_time) as nvarchar)+'seconds';
		print'>>----------------';
		select count(*) from bronze.erp_px_cat_g1v2;

		set @batch_end_time = getdate();
		print'========================================='
		print'Total Load time for Bronze Layer = '+cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar)+'senconds';
		print'========================================='
	end try
	begin catch
		print'=================================================';
		print'Error message'+ERROR_MESSAGE();
		print'Error message'+cast(error_number() as nvarchar);
		print'Error message'+cast(error_state() as nvarchar);
		print'=================================================';
	end catch
end;

-- stored procedure to bulk insert data into bronze tables
-- it truncates the bronze table before loading the data

--to run the file- exec bronze.load_bronze;
create or alter procedure bronze.load_bronze as -- storig this code in broze schema as stored procedure as it will be used again and again
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
    set @batch_start_time = GETDATE();
	print '===============================';
	print 'loading bronze layer';
	print '===============================';
	print '-------------------------------';
	print 'loading crm tables';
	print '-------------------------------';

	set @start_time = GETDATE();
	print '>>truncating table: bronze.crm_cust_info';
	truncate table bronze.crm_cust_info; -- it empties the table first coz in the next step we will do bulk insert
	print '>>inserting data into: bronze.crm_cust_info';
	bulk insert bronze.crm_cust_info
	from 'D:\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	with (
	 firstrow = 2,
	 fieldterminator = ',',
	 tablock
	 );
	 set @end_time = GETDATE();
	print'>> load duration is: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
	set @start_time = GETDATE();
	print '>>truncating table: bronze.crm_prd_info';
	truncate table bronze.crm_prd_info; -- it empties the table first coz in the next step we will do bulk insert
	print '>>inserting data into: bronze.crm_prd_info';
	bulk insert bronze.crm_prd_info
	from 'D:\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	with (
	 firstrow = 2,
	 fieldterminator = ',',
	 tablock
	 );
	 
	set @end_time =GETDATE();
	print'>> load duration is: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
    
	set @start_time = GETDATE();
	print '>>truncating table: bronze.crm_sales_details';
	truncate table bronze.crm_sales_details; -- it empties the table first coz in the next step we will do bulk insert
	print '>>inserting data into: bronze.crm_sales_details';
	bulk insert bronze.crm_sales_details
	from 'D:\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	with (
	 firstrow = 2,
	 fieldterminator = ',',
	 tablock
	 );
	set @end_time =GETDATE();
	print'>> load duration is: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';

	print '-------------------------------';
	print 'loading erp tables';
	print '-------------------------------';
    
	set @start_time = GETDATE();
	print '>>truncating table: bronze.erp_CUST_AZ12';
	truncate table bronze.erp_CUST_AZ12; -- it empties the table first coz in the next step we will do bulk insert
	print '>>inserting data into: bronze.erp_CUST_AZ12';
	bulk insert bronze.erp_CUST_AZ12
	from 'D:\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	with (
	 firstrow = 2,
	 fieldterminator = ',',
	 tablock
	 );
	set @end_time =GETDATE();
	print'>> load duration is: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';


    set @start_time = GETDATE();
	print '>>truncating table: bronze.erp_LOC_A101';
	truncate table bronze.erp_LOC_A101; -- it empties the table first coz in the next step we will do bulk insert
	print '>>inserting data into: bronze.erp_LOC_A101';
	bulk insert bronze.erp_LOC_A101
	from 'D:\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	with (
	 firstrow = 2,
	 fieldterminator = ',',
	 tablock
	 );
	set @end_time =GETDATE();
	print'>> load duration is: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';

    set @start_time = GETDATE();
	print '>>truncating table: bronze.erp_PX_CAT_G1V2';
	truncate table bronze.erp_PX_CAT_G1V2; -- it empties the table first coz in the next step we will do bulk insert
	PRINT '>>inserting data into: bronze.erp_PX_CAT_G1V2'; 
	bulk insert bronze.erp_PX_CAT_G1V2
	from 'D:\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	with (
	 firstrow = 2,
	 fieldterminator = ',',
	 tablock
	 );
	set @end_time =GETDATE();
	print'>> load duration is: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';

	set @batch_end_time = GETDATE();
    print'>> total load duration is: ' + cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + 'seconds';
end

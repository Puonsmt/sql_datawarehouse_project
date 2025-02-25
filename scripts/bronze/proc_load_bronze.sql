/*
=====================================================================================
Qua trinh duoc luu tru: Tai lop Bronze (Source -> Bronze)
=====================================================================================
Muc dich cua script:
	Quy trinh luu tru nay duoc tai vao luoc do 'bronze' tu cac tep CSV ben ngoai.
	No thuc hien nhung hanh dong sau:
		- Cat bo cac bang bronze truoc khi tai du lieu 
		- Su dung lenh 'BULK INSERT' de tai du lieu tu cac tep CSV vao cac bang bronze
Tham so:
	Khong co.
	Quy trinh luu tru nay khong chap nhan bat ki tham so hoac tra ve 
	bat cu gia tri na

Vi du su dung:
	EXEC bronze.load_bronze 
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
	BEGIN TRY 
		SET @batch_start_time = GETDATE();
		PRINT '================================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================================';

		PRINT '----------------------------------------------------------------';
		PRINT 'Loading CRM Tables'
		PRINT '----------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Data Onto Table: bronze.crm_cust_info';
		-- Lam rong bang bronze.crm_cust_info
		TRUNCATE TABLE bronze.crm_cust_info;
		-- Them du lieu vao bang bronze.crm_cust_info 
		PRINT '>> Inserting Tables: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'E:\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2, 
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------'
		-- lam rong bang sau so them du lieu vao bang => qua trinh tai day du (full load) 

		SET @start_time = GETDATE();
		PRINT '>> Truncating Data Onto Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting Tables: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'E:\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2, 
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Data Onto Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Tables: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details 
		FROM 'E:\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------'

		PRINT '----------------------------------------------------------------';
		PRINT 'Loading ERP Tables'
		PRINT '----------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Data Onto Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Tables: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'E:\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Data Onto Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting Tables: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'E:\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------'

		SET @start_time = GETDATE();
		PRINT '>> Truncating Data Onto Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Tables: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'E:\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-----------------------'

		SET @batch_end_time = GETDATE();
		PRINT '================================================================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '    - Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '================================================================';

	END TRY
	BEGIN CATCH 
		PRINT '================================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message ' + ERROR_MESSAGE();
		PRINT 'Error Message ' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message ' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '================================================================';
	END CATCH 
END 

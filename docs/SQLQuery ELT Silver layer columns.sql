--EXEC silver.load_silver
/*
CREATE OR ALTER PROCEDURE silver.load_silver AS 
  BEGIN
      DECLARE @start_time DATETIME, @end_time DATETIME;
      BEGIN TRY

      PRINT '=============================';
      PRINT 'Load silver Tablas';
      PRINT '=============================';

      PRINT '=============================';
      PRINT 'Load Tablas CRM';
      PRINT '=============================';
      
  

      SET @start_time = GETDATE();
      PRINT 'Truncate & Bulk Insert';
        TRUNCATE TABLE silver.crm_cust_info;
        BULK INSERT silver.crm_cust_info
            FROM 'C:\Users\matia\OneDrive\Escritorio\Carpeta-SQL\SQL Archive\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
                WITH (
                    FIRSTROW = 2,
                    FIELDTERMINATOR = ',',
                    TABLOCK
            );
      PRINT '=============================';
      SET @end_time = GETDATE();
      PRINT '>>Load duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
      PRINT '=============================';


     SET @start_time = GETDATE();
     PRINT 'Truncate & Bulk Insert';
        TRUNCATE TABLE silver.crm_prd_info;
        BULK INSERT silver.crm_prd_info
            FROM 'C:\Users\matia\OneDrive\Escritorio\Carpeta-SQL\SQL Archive\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
              WITH (
                    FIRSTROW = 2,
                    FIELDTERMINATOR = ',',
                    TABLOCK
            );
      PRINT '=============================';
      SET @end_time = GETDATE()
      PRINT '>>Load duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
      PRINT '=============================';


     SET @start_time = GETDATE();
     PRINT 'Truncate & Bulk Insert';
        TRUNCATE TABLE silver.crm_sales_details;
        BULK INSERT silver.crm_sales_details
            FROM 'C:\Users\matia\OneDrive\Escritorio\Carpeta-SQL\SQL Archive\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
              WITH (
                    FIRSTROW = 2,
                    FIELDTERMINATOR = ',',
                    TABLOCK
            );
      PRINT '=============================';
       SET @end_time = GETDATE();
      PRINT '>>Load duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
      PRINT '=============================';
  
  
  
                                                       --- ERP ---
      PRINT '=============================';
      PRINT 'Load Tablas ERP';
      PRINT '=============================';


     SET @start_time = GETDATE();
     PRINT 'Truncate & Bulk Insert'

        TRUNCATE TABLE silver.erp_cust_az12;
        BULK INSERT silver.erp_cust_az12
            FROM 'C:\Users\matia\OneDrive\Escritorio\Carpeta-SQL\SQL Archive\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
              WITH (
                    FIRSTROW = 2,
                    FIELDTERMINATOR = ',',
                    TABLOCK
            );
      PRINT '=============================';
      SET @end_time = GETDATE();
      PRINT '>>Load duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
      PRINT '=============================';


     SET @start_time = GETDATE();
     PRINT 'Truncate & Bulk Insert'
        TRUNCATE TABLE silver.erp_loc_a101;
        BULK INSERT silver.erp_loc_a101
        FROM 'C:\Users\matia\OneDrive\Escritorio\Carpeta-SQL\SQL Archive\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
              WITH (
                    FIRSTROW = 2,
                    FIELDTERMINATOR = ',',
                    TABLOCK
            );
      PRINT '=============================';
       SET @end_time = GETDATE();
      PRINT '>>Load duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
      PRINT '=============================';


     SET @start_time = GETDATE();
     PRINT 'Truncate & Bulk Insert'

        TRUNCATE TABLE silver.erp_px_cat_g1v2;
        BULK INSERT silver.erp_px_cat_g1v2
        FROM 'C:\Users\matia\OneDrive\Escritorio\Carpeta-SQL\SQL Archive\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
          WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = ',',
                TABLOCK
            );
      PRINT '=============================';
       SET @end_time = GETDATE();
      PRINT '>>Load duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
      PRINT '=============================';


      END TRY
      BEGIN CATCH
        PRINT '=========================='
        PRINT 'ERROR LOADING silver DB'
        PRINT 'Mensaje del Error ' + ERROR_MESSAGE ();
        PRINT '=========================='
      END CATCH
      END
       */

















     
IF OBJECT_ID ('silver.crm_cust_info', 'U') IS NOT NULL 
    DROP TABLE silver.crm_cust_info;
CREATE TABLE silver.crm_cust_info(
    cst_id INT,
    cst_key NVARCHAR (50),
    cst_firstname NVARCHAR (50),
    cst_lastname NVARCHAR (50),
    cst_material_status NVARCHAR (50),
    cst_gndr NVARCHAR (50),
    cst_create_date DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID ('silver.crm_prd_info', 'U') IS NOT NULL 
    DROP TABLE silver.crm_prd_info;
CREATE TABLE silver.crm_prd_info(
    prd_info INT,
    cat_id NVARCHAR(50),
    prd_key NVARCHAR (50),
    prd_firstname NVARCHAR (50),
    prd_cost NVARCHAR (50),
    prd_line NVARCHAR (50),
    prd_start_dt DATE,
    prd_end_dt DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.crm_sales_details', 'U') IS NOT NULL 
    DROP TABLE silver.crm_sales_details;
CREATE TABLE silver.crm_sales_details(
    sls_order_num NVARCHAR (50),
    sls_prd_key NVARCHAR (50),
    sls_cust_id INT,
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.erp_cust_az12', 'U') IS NOT NULL 
    DROP TABLE silver.erp_cust_az12;
CREATE TABLE silver.erp_cust_az12 (
    cid NVARCHAR(60),
    bdate DATE,
    gen NVARCHAR (50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()

);

IF OBJECT_ID ('silver.erp_loc_a101', 'U') IS NOT NULL 
    DROP TABLE silver.erp_loc_a101;
CREATE TABLE silver.erp_loc_a101(
    cid NVARCHAR (50),
    cntry NVARCHAR (50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID ('silver.erp_px_cat_g1v2', 'U') IS NOT NULL 
    DROP TABLE silver.erp_px_cat_g1v2;
CREATE TABLE silver.erp_px_cat_g1v2(
    id NVARCHAR (50),
    cat NVARCHAR (50),
    subcat NVARCHAR (50),
    maintenance NVARCHAR (50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()

    );
    
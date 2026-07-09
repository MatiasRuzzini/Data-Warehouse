/*
--CREATE VIEW gold.dim_customers AS
SELECT 
	ROW_NUMBER () OVER (ORDER BY cst_id) AS Customer_key,
	A.cst_id AS Customer_Id ,
	A.cst_key AS Customer_Number ,
	A.cst_firstname AS Frist_Name,
	A.cst_lastname AS Last_Name,
	CASE WHEN A.cst_gndr != 'N/A' THEN B.gen
	ELSE COALESCE (B.gen, 'N/A') END AS New_Gender,
	C.cntry AS Country,
	A.cst_material_status AS Social_Status,
	B.bdate AS Birthday,
	A.cst_create_date AS Creation_date
	

FROM silver.crm_cust_info A
LEFT JOIN silver.erp_cust_az12 B
ON A.cst_key = B.cid
LEFT JOIN silver.erp_loc_a101 C
ON A.cst_key = C.cid



--CREATE VIEW gold.dim_products AS 
SELECT 
	ROW_NUMBER () OVER (ORDER BY A.prd_start_dt, A.prd_key) AS Product_key,
	
	A.prd_info AS Product_id,
	
	A.prd_key AS Product_id_Name,

	A.prd_firstname AS Product_Name,
	
	ISNULL (B.subcat, 'N/A')  AS Product_SubCategory,

	A.cat_id AS Category_id,

	ISNULL (B.cat, 'N/A') AS Product_Category,
	
	A.prd_line AS Product_line,
	
	A.prd_cost AS Product_Costs,

	A.prd_start_dt AS Product_Start_Date,

	ISNULL (B.maintenance, 'N/A') AS Maintenance

FROM silver.crm_prd_info A
LEFT JOIN silver.erp_px_cat_g1v2 B
ON A.cat_id = B.id
*/


SELECT TOP 1 * FROM gold.dim_customers;

SELECT TOP 1 * FROM  gold.dim_products;


--CREATE VIEW gold.fact_sales AS
SELECT 
	A.sls_order_num AS Sales_order_number,
	
	B.Product_id_Name,
	
	C.Customer_id,
	
	A.sls_order_dt_ AS Sales_order_date,

	A.sls_ship_dt AS Sales_shipping_date,
	
	A.sls_due_dt AS Sales_due_date,
	
	A.sls_sales AS Sales,
	
	A.sls_quantity AS Sales_quantity,
	
	A.sls_price AS Sales_Price

FROM silver.crm_sales_details A
LEFT JOIN gold.dim_products B
ON A.sls_prd_key = B.Product_id_Name
LEFT JOIN gold.dim_customers C
ON A.sls_cust_id = C.Customer_id
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

create view gold.dim_customers as 
select 
row_number() over (order by cst_id) as customer_key,
ci.cst_id as customer_id,
ci.cst_key as customer_number,
ci.cst_firstname as first_name,
ci.cst_lastname as last_name,
cl.cntry as country,
ci.cst_maratial_status as maratial_status,
case when ci.cst_gndr != 'n/a' then ci.cst_gndr
	 else coalesce(ca.gen , 'n/a')
end as gender,
ca.bdate as birth_date,
ci.cst_create_date as create_date
from [silver].[crm_cust_info] as ci
left join [silver].[erp_cust_az12] ca
on		  ci.cst_key = ca.cid
left join [silver].[erp_loc_a101] cl
on		  ci.cst_key = cl.cid 

create view gold.dim_products as
select
row_number() over (order by pi.prd_start_dt, pi.prd_key) as product_key,
pi.prd_id as product_id,
pi.prd_key as product_number,
pi.prd_nm as product_name,
pi.cat_id as category_id,
pc.cat as category,
pc.subcat as subcatergory,
pc.maintenance,
pi.prd_cost as product_cost,
pi.prd_line as product_line,
pi.prd_start_dt as product_start
from [silver].[crm_prd_info] pi
left join [silver].[erp_px_cat_g1v2] pc
on		  pi.cat_id = pc.id
where pi.prd_end_dt is null

select * from gold.dim_products
select * from gold.dim_customers

create view gold.fact_sales as 
select 
sd.sls_ord_num as order_number,
pr.product_key,
c.customer_key ,
sd.sls_order_dt as order_date,
sd.sls_ship_dt as shipping_date,
sd.sls_due_dt as due_date,
sd.sls_sales as sales,
sd.sls_quantity as qunatity,
sd.sls_price as price
from [silver].[crm_sales_details] sd
left join [gold].[dim_products] pr
on		  sd.sls_prd_key = pr.product_number
left join [gold].[dim_customers] c
on		  sd.sls_cust_id = c.customer_id

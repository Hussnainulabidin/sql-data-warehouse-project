select * from gold.dim_customers

select * from gold.dim_products

select * from gold.fact_sales

select count(*) from gold.dim_customers

select count(*) from gold.fact_sales

select *
from gold.fact_sales
where order_date is null

--Average order value per moth
select
format(fs.order_date , 'yyyy-MM') as month,
avg(fs.sales) as avg_order_value
from gold.fact_sales fs
group by format(fs.order_date , 'yyyy-MM')
order by format(fs.order_date , 'yyyy-MM') desc


--customer per month
select
format(fs.order_date , 'yyyy-MM') as month,
count(distinct fs.customer_key) as total_customers
from gold.fact_sales fs
group by format(fs.order_date , 'yyyy-MM')
order by format(fs.order_date , 'yyyy-MM') desc


--Order and Revenue per year
select
format(fs.order_date , 'yyyy') as month,
count(fs.order_number) as total_orders,
sum(fs.sales) as Revenue
from gold.fact_sales fs
where fs.order_date is not null
group by format(fs.order_date , 'yyyy')
order by format(fs.order_date , 'yyyy') desc

--Orders and Revenue per month
select
format(fs.order_date , 'yyyy-MM') as month,
count(fs.order_number) as total_orders,
sum(fs.sales) as Revenue
from gold.fact_sales fs
where fs.order_date is not null
group by format(fs.order_date , 'yyyy-MM')
order by format(fs.order_date , 'yyyy-MM') desc

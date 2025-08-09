--show all data of table--
select * from [dbo].[retail sales];

--Record Count: Determine the total number of records in the dataset--
select count(*) from [dbo].[retail sales];

--Customer Count: Find out how many unique customers are in the dataset--
select count(distinct customer_id) as customer_count from [dbo].[retail sales];

--Category Count: Identify all unique product categories in the dataset--
select count(distinct category) as category_count from [dbo].[retail sales];

--Null Value Check: Check for any null values in the dataset and delete records with missing data--
select * from [dbo].[retail sales] 
where 
      transactions_id is null or sale_date is null or sale_time is null or customer_id is null
      or gender is null or age is null or category is null or quantiy is null or price_per_unit is null
      or cogs is null or total_sale is null;
delete from [dbo].[retail sales]
where 
      transactions_id is null or sale_date is null or sale_time is null or customer_id is null
      or gender is null or age is null or category is null or quantiy is null or price_per_unit is null
      or cogs is null or total_sale is null;

      --The following SQL queries were developed to answer specific business questions--

--Write a SQL query to retrieve all columns for sales made on '2022-11-05'--
select * from [dbo].[retail sales] where sale_date = '2022-11-05';

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022--
select * from [dbo].[retail sales] 
where category like 'Clothing' and month( sale_date)='11' and year( sale_date)='2022' and quantiy >= 4 ;

--Write a SQL query to calculate the total sales (total_sale) and total órder for each category--
select category,
sum(total_sale) as net_sale,
COUNT(category) as total_orders 
from [dbo].[retail sales]
group by category;

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category--
select category,
avg(age) as avg_age 
from [dbo].[retail sales]
where category='Beauty'
group by category;

--Write a SQL query to find all transactions where the total_sale is greater than 1000.:--
select * from [dbo].[retail sales] where total_sale > 1000;

--Write a SQL query to find the total number of transactions made by each gender in each category--
select gender,category,
count (*) as total_transaction
from[dbo].[retail sales]
group by gender,category
order by gender,category;

--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:--
with t1 as(
select month(sale_date)as months,year(sale_date)as years,
avg(total_sale) as avg_sale
from [dbo].[retail sales]
group by month(sale_date),year(sale_date))

select top 2 months as m,years as y,
max(avg_sale)as the_best_month_in_year from t1
where years in (2022,2023)
group by months,years
order by max(avg_sale)desc;

--Write a SQL query to find the top 5 customers based on the highest total sales--
select top 5 customer_id ,sum(total_sale) as total_sales 
from [dbo].[retail sales]
group by customer_id
order by max(total_sale);

--Write a SQL query to find the number of unique customers who purchased items from each category--
select category , 
count(distinct customer_id)as total_customers 
from [dbo].[retail sales]
group by category;

--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)--
with hourly_sale as (select *,
case 
when datepart(hour,sale_time) < 12 then 'morning'
when datepart(hour,sale_time) between 12 and 17 then 'afternoon'
when datepart(hour,sale_time) >17 then 'evening'
end as shifts 
from [dbo].[retail sales]
)
select shifts ,
count (*) as total_order
from hourly_sale
group by shifts;
 
 ---END THE PROJECT---

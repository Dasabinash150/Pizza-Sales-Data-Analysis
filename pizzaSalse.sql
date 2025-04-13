SELECT TOP (1000) [pizza_id]
      ,[order_id]
      ,[pizza_name_id]
      ,[quantity]
      ,[order_date]
      ,[order_time]
      ,[unit_price]
      ,[total_price]
      ,[pizza_size]
      ,[pizza_category]
      ,[pizza_ingredients]
      ,[pizza_name]
  FROM [pizzaDB].[dbo].[pizza_sales]

use pizzadb;
  --1. Total Revenue:
select sum(total_price) as Total_Revenue from pizza_sales;

--2. Average Order Value

select (sum(total_price) / count(distinct order_id)) as Avg_Ord_values from pizza_sales

--3. Total Pizzas Sold
select sum(quantity) as Total_Pizza_Sold from pizza_sales;

--4. Total Orders
select count(distinct order_id) as Total_orders from pizza_sales;

--5. Average Pizzas Per Order
select cast(cast(sum(quantity) as decimal(10,2) ) / cast(count( distinct order_id) as decimal(10,2) ) as decimal(10,2) ) as Avg_pizza_per_sales
from pizza_sales;

--B. Daily Trend for Total Orders
select 
	datename(dw, order_date) as Order_day , 
	count(distinct order_id) as Total_orders
from pizza_sales
group by datename(dw, order_date);

--C. Monthly Trend for Orders
select 
	datename(mm, order_date) as Months,
	count(distinct order_id) as Total_orders
from 
	pizza_sales
group by
	datename(mm, order_date);

--D. % of Sales by Pizza Category
select 
	pizza_category,
	cast(sum(total_price)  as decimal(10,2)) as Total_Revenue,
	cast((sum(total_price) * 100) / (select sum(total_price) from pizza_sales) as decimal (10,2) ) as Percentage_sales
from 
	pizza_sales
group by 
	pizza_category;

--E. % of Sales by Pizza Size
select 
	pizza_size,
	cast(sum(total_price)  as decimal(10,2)) as Total_Revenue,
	cast((sum(total_price) * 100) / (select sum(total_price) from pizza_sales) as decimal (10,2) ) as Percentage_sales
from 
	pizza_sales
group by 
	pizza_size
order by pizza_size;

--F. Total Pizzas Sold by Pizza Category
select 
	pizza_category,
	sum(quantity) as Total_Quantity_solds
from pizza_sales
where month(order_date) = 2
group by pizza_category
order by Total_Quantity_solds desc;

--G. Top 5 Pizzas by Revenue
select top 5 pizza_name, sum(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue desc;

--H. Bottom 5 Pizzas by Revenue
select top 5 pizza_name, sum(total_price) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue asc; 

--I. Top 5 Pizzas by Quantity
select top 5 pizza_name, sum(quantity) as Total_Pizza_Sold
from pizza_sales
group by pizza_name
order by Total_Pizza_Sold asc; 



--J. Bottom 5 Pizzas by Quantity

select top 5 pizza_name, sum(quantity) as Total_Pizza_Sold
from pizza_sales
group by pizza_name
order by Total_Pizza_Sold desc; 
--K. Top 5 Pizzas by Total Orders
select top 5 pizza_name, count(distinct order_id) as Total_orders
from pizza_sales
group by pizza_name
order by Total_orders desc;

--L. Bottom 5 Pizzas by Total Orders
select top 5 pizza_name, count(distinct order_id) as Total_orders
from pizza_sales
group by pizza_name
order by Total_orders asc;
--If you want to apply the pizza_category or pizza_size filters to the above queries you can use WHERE clause. Follow some of below examples
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC;

create database Pizza_DB;

use pizza_db;

select * from pizza_sales;

ALTER TABLE pizza_sales 
MODIFY order_time TIME;

ALTER TABLE pizza_sales 
MODIFY order_date DATETIME;

-- CHECKING KPI's
-- 1. Total Revenue:
select sum(total_price) as "Total Revenue" from pizza_sales;

-- 2. Average Order Value
select sum(total_price)/count(distinct order_id) as "Average Order Value" from pizza_sales;

-- 3. Total Pizzas Sold
select sum(quantity) from pizza_sales;

-- 4. Total Orders
select count(distinct order_id) from pizza_sales;

-- 5. Average Pizzas Per Order
select sum(quantity)/count(distinct order_id) as "Average Pizzas Per Order" from pizza_sales;


-- B. Daily Trend for Total Orders
SELECT DAYNAME(order_date) AS day_name, count(distinct order_id) as "Total Orders"
FROM pizza_sales
Group by DAYNAME(order_date);

-- C. Hourly Trend for Orders
select hour(order_time) AS "hour", count(distinct order_id) as "Total Orders"
FROM pizza_sales
Group by hour(order_time);

-- D. % of Sales by Pizza Category
select pizza_category as "Pizza Category", Round(sum(total_price),2) as "Total Revenue", 
Round(sum(total_price)*100/(select sum(total_price) from pizza_sales),2) as PCT
from pizza_sales
group by pizza_category;

-- E. % of Sales by Pizza Size
select pizza_size as "Pizza Size", Round(sum(total_price),2) as "Total Revenue", 
Round(sum(total_price)*100/(select sum(total_price) from pizza_sales),2) as PCT
from pizza_sales
group by pizza_size;

-- F. Total Pizzas Sold by Pizza Category
select pizza_category,sum(quantity) as "Total Sales"
from pizza_sales
group by pizza_category;

-- G. Top 5 Best Sellers by Total Pizzas Sold
select pizza_name, sum(quantity) as "Total Pizza Sold"
from pizza_sales
group by pizza_name
order by sum(quantity) DESC
LIMIT 5;

-- H. Bottom 5 Best Sellers by Total Pizzas Sold
select pizza_name, sum(quantity) as "Total Pizza Sold"
from pizza_sales
group by pizza_name
order by sum(quantity)
LIMIT 5;

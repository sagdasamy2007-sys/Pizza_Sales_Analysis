 -- ========================================================
-- Pizza Sales Analysis - Data Querying Script
-- Tools: SQL Server (T-SQL)
-- Description: Analysis of sales performance, order trends,
--              category breakdowns, and best/worst sellers.
-- ========================================================

-- 1. Total Revenue
SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales;

-- 2. Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value 
FROM pizza_sales;

-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_Sold 
FROM pizza_sales;

-- 4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales;

-- 5. Average Pizzas Per Order
SELECT CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Average_Pizzas_Per_Order 
FROM pizza_sales;

-- 6. Daily Trend For Total Orders
SELECT DATENAME(DW, order_date) AS Order_Day, 
       COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY Total_Orders DESC;

-- 7. Hourly Trend For Total Orders
SELECT DATEPART(HOUR, order_time) AS Order_Hours, 
       COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY Total_Orders DESC;

-- 8. Percentage of Sales by Pizza Category
SELECT pizza_category, 
       SUM(total_price) AS Total_Sales,
       SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS PCT
FROM pizza_sales
GROUP BY pizza_category
ORDER BY PCT DESC;

-- 9. Percentage of Sales by Pizza Size
SELECT pizza_size, 
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;

-- 10. Total Pizzas Sold by Pizza Category
SELECT pizza_category, 
       SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Pizza_Sold DESC;

-- 11. Top 5 Best Sellers by Total Pizzas Sold
SELECT TOP 5 pizza_name, 
       SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;

-- 12. Bottom 5 Worst Sellers by Total Pizzas Sold
SELECT TOP 5 pizza_name, 
       SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC;
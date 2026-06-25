-- =================================================
-- Business Overview
-- =================================================
-- Total Orders, Customers, Quantity, Sales, Profit
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_quantity,
	ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore;

-- =================================================
-- Sales Trend Analysis
-- =================================================
-- Annual Sales Trend
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY year
ORDER BY year;

-- Monthly Sales Trend
SELECT
    DATE_TRUNC('month', order_date) AS month,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY month
ORDER BY month;

-- =================================================
-- Product Analysis
-- =================================================
-- Category Performance
SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

-- Sub-Category Performance
SELECT
    sub_category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC;

-- Top 10 Products
SELECT
	product_name AS top_products,
	category,
	ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY product_name, category
ORDER BY total_sales DESC
LIMIT 10;

-- Loss-Making Products
SELECT
	product_name AS loss_making_products,
	category,
	ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY product_name, category
HAVING ROUND(SUM(profit),2) < 0
ORDER BY total_profit ASC;

-- =================================================
-- Customer Analysis
-- =================================================
-- Top 10 Customers by Sales
SELECT
	customer_name AS top_customers,
	COUNT(DISTINCT order_id) AS total_orders,
	ROUND(SUM(sales),2) AS total_sales,
	ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 Valuable Customers
SELECT
	customer_name AS valuable_customers,
	COUNT(DISTINCT order_id) AS total_orders,
	ROUND(SUM(sales),2) AS total_sales,
	ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 10;

-- =================================================
-- Geographic Analysis
-- =================================================
-- Region Performance
SELECT
	region,
	ROUND(SUM(sales),2) AS total_sales,
	ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- State Performance
SELECT
	state,
	ROUND(SUM(sales),2) AS total_sales,
	ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY state
ORDER BY total_sales DESC;

-- Top 10 States by Profit
SELECT
	state AS top_states,
	ROUND(SUM(sales),2) AS total_sales,
	ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY state
ORDER BY total_profit DESC
LIMIT 10;

-- Loss-Making States
SELECT
	state AS loss_making_state,
	ROUND(SUM(sales),2) AS total_sales,
	ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY state
HAVING ROUND(SUM(profit),2) < 0
ORDER BY total_profit ASC;

-- =================================================
-- Profitability Analysis
-- =================================================
-- Sales & Profit by Discount Level
SELECT
    discount,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY discount
ORDER BY discount;

-- Profitability by Sub-Category
SELECT
	sub_category,
	category,
    ROUND(AVG(discount),2) AS avg_discount,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales),0) * 100,
        2
    ) AS profit_margin_pct
FROM superstore
GROUP BY sub_category, category
ORDER BY category, profit_margin_pct DESC;

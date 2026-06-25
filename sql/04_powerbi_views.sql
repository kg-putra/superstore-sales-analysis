-- =================================================
-- Business Overview
-- =================================================
-- Total Orders, Customers, Quantity, Sales, Profit
CREATE VIEW vw_business_ov AS
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
CREATE VIEW vw_annual_sales_td AS
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY year
ORDER BY year;

-- Monthly Sales Trend
CREATE VIEW vw_monthly_sales_td AS
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
CREATE VIEW vw_category_pf AS
SELECT
    category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

-- Sub-Category Performance
CREATE VIEW vw_sub_category_pf AS
SELECT
    sub_category,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC;

-- Top 10 Products
CREATE VIEW vw_top_products AS
SELECT
	product_name AS top_products,
	category,
	ROUND(SUM(sales),2) AS total_sales
FROM superstore
GROUP BY product_name, category
ORDER BY total_sales DESC
LIMIT 10;

-- Loss-Making Products
CREATE VIEW vw_loss_making_products AS
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
CREATE VIEW vw_top_customers_by_sales AS
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
CREATE VIEW vw_top_valuable_customers AS
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
CREATE VIEW vw_region_pf AS
SELECT
	region,
	ROUND(SUM(sales),2) AS total_sales,
	ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- State Performance
CREATE VIEW vw_state_pf AS
SELECT
	state,
	ROUND(SUM(sales),2) AS total_sales,
	ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY state
ORDER BY total_sales DESC;

-- Top 10 States by Profit
CREATE VIEW vw_top_states_by_profit AS
SELECT
	state AS top_states,
	ROUND(SUM(sales),2) AS total_sales,
	ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY state
ORDER BY total_profit DESC
LIMIT 10;

-- Loss-Making States
CREATE VIEW vw_loss_making_states AS
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
CREATE VIEW vw_sales_profit_by_discount_level AS
SELECT
    discount,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore
GROUP BY discount
ORDER BY discount;

-- Profitability by Sub-Category
CREATE VIEW vw_profitability_by_sub_category AS
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

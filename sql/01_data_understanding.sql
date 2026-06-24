-- Dataset Structure
SELECT *
FROM superstore
LIMIT 10;

--- Data Count
SELECT COUNT(*)
FROM superstore;

--- Data Type : to know each columns with its data type
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'superstore';

--- Date Type Validation : to check if the date reasonable
SELECT
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order,
    MIN(ship_date) AS first_ship,
    MAX(ship_date) AS last_ship
FROM superstore;

--- Missing Value Check : to check missing value by checking for correspondence of the number of rows between columns
SELECT
    COUNT(*) AS total_rows,
	COUNT(row_id) AS filled_row_id,
	COUNT(customer_id) AS filled_customer_id,
	COUNT(product_name) AS filled_product_name,
	COUNT(order_date) AS filled_order_date,
    COUNT(sales) AS filled_sales
FROM superstore;

-- Distinct Value Check : to check distinct value
SELECT
    COUNT(DISTINCT order_id) AS distinct_order,
	COUNT(DISTINCT customer_id) AS distinct_customer,
    COUNT(DISTINCT product_name) AS distinct_product
FROM superstore;

--- Duplication Check : to check duplication
SELECT
    *,
    COUNT(*)
FROM superstore
GROUP BY
    row_id,
    order_id,
    order_date,
    ship_date,
	ship_mode,
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    profit
HAVING COUNT(*) > 1;

---- Table Insight : In this table, order_id may have duplicate rows but doesn't mean it is duplicate, for further checking I use column order_ids_in_the_same_order_date to check if order_id refer to order in the same exact order_date, so we can conclude that the duplication of order_id belongs to distinguable order_id but seperated by any condition (maight be product_name)
SELECT
    order_id,
    COUNT(*) AS total_order_id,
	CASE WHEN COUNT(DISTINCT order_date) = 1 THEN 1 ELSE 0 END AS order_ids_in_the_same_order_date 
FROM superstore
GROUP BY order_id
HAVING COUNT(*) > 1;
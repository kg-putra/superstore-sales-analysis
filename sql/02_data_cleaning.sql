-- Missing Value Check: to identify missing values by comparing the total number of rows with the non-null count of selected columns.
SELECT
    COUNT(*) AS total_rows,
	COUNT(row_id) AS filled_row_id,
	COUNT(customer_id) AS filled_customer_id,
	COUNT(product_name) AS filled_product_name,
	COUNT(order_date) AS filled_order_date,
    COUNT(sales) AS filled_sales
FROM superstore;

-- Distinct Value Count: to identify the number of unique values in selected columns.
SELECT
    COUNT(DISTINCT order_id) AS distinct_order,
	COUNT(DISTINCT customer_id) AS distinct_customer,
    COUNT(DISTINCT product_name) AS distinct_product
FROM superstore;

-- Duplicate Check: to identify fully duplicated records by checking whether identical rows exist across all columns in the dataset.
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

-- Table Insight:
-- In the Superstore dataset, an order_id can appear multiple times because a single order may contain multiple products.
-- This query confirms that repeated order_id values belong to the same transaction by checking whether they share the same order_date.
SELECT
    order_id,
    COUNT(*) AS total_order_id,
	CASE WHEN COUNT(DISTINCT order_date) = 1 THEN 1 ELSE 0 END AS order_ids_in_the_same_order_date 
FROM superstore
GROUP BY order_id
HAVING COUNT(*) > 1;
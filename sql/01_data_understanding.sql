-- Dataset Structure: to understand the overall structure of the dataset by reviewing a sample of records from the table.
SELECT *
FROM superstore
LIMIT 10;

-- Data Count: to identify the total number of rows in the dataset.
-- Knowing the dataset size provides an understanding of the analysis scope and serves as a reference for subsequent data quality checks.
SELECT COUNT(*)
FROM superstore;

-- Data Type Check: to identify the data type of each column in the dataset.
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'superstore'
ORDER BY ordinal_position;

-- Date Validation: to verify that the order and shipping dates fall within a reasonable range and have been imported correctly.
-- The minimum and maximum values of order_date and ship_date indicate that the dataset covers transactions within the expected period.
-- No unreasonable date values were detected, suggesting that the date fields are suitable for time-based analysis.
SELECT
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order,
    MIN(ship_date) AS first_ship,
    MAX(ship_date) AS last_ship
FROM superstore;
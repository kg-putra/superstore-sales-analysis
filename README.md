# Superstore Sales Analysis

## Overview
This project analyzes Superstore sales data using PostgreSQL and Power BI.

## Business Objectives
- Which product categories generate the highest sales and profits?
- Which regions contribute the most to revenue?
- Which products are underperforming despite high sales?
- How do discounts affect profitability?
- What actionable insights can support business decision-making?

## Dataset
- Source: Kaggle Superstore Sales Dataset
- Original dataset file: samplesuperstore.csv
- Link: https://www.kaggle.com/datasets/himanshuuike/superstore-sales-dataset

## Tools Used
- PostgreSQL
- pgAdmin 4
- Power BI
- Git & GitHub

## Current Progress
- [x] Dataset imported into PostgreSQL
- [x] Initial data understanding
- [x] Data cleaning
- [ ] Exploratory data analysis
- [ ] Dashboard development

## Data Cleaning
Before conducting the analysis, the raw dataset obtained from Kaggle was validated and prepared for use in PostgreSQL. Several issues were identified during the import process and addressed accordingly.

### 1. Standardized Column Names
The original dataset contained column names with spaces and inconsistent formatting. The headers were modified to follow SQL naming conventions using lowercase letters and underscores.

| Original | Updated |
|-----------|-----------|
| Row ID | row_id |
| Order ID | order_id |
| Order Date | order_date |
| Ship Date | ship_date |
| Customer ID | customer_id |
| Customer Name | customer_name |
| Country/Region | country |
| State/Province | state |
| Postal Code | postal_code |
| Sub-Category | sub_category |
| Product Name | product_name |

**Reason:** Improve readability and simplify SQL querying.

### 2. Removed Invalid Delimiter Characters
During the import process, PostgreSQL returned the following error:

**pgAdmin Import Message**
```text
ERROR: extra data after last expected column
CONTEXT: COPY superstore, line 2:
"1,US-2023-103800,1/3/2023,1/7/2023,..."
```

Investigation revealed that the CSV file contained unexpected semicolon (';') characters at the end of the header and several data rows.

Before:
```csv
...,discount,profit;
...,0.8,-5.487;
```

After:
```csv
...,discount,profit
...,0.8,-5.487
```

**Reason:** Prevent PostgreSQL from interpreting the semicolon as an extra column.

### 3. Adjusted Postal Code Data Type
The 'postal_code' field was initially assumed to be numeric. However, records from Canada contained alphanumeric postal codes.

Example:
```text
M7A
C0A
```

The data type was changed from:
```sql
INTEGER
```

to:
```sql
VARCHAR(20)
```

**Reason:** Preserve postal codes from both the United States and Canada without data loss.

### 4. Validated Record Count
The original CSV file contained **10,195 lines**, including the header row.

After validation:
- Header rows: 1
- Actual transaction records: 10,194

Verification query:
```sql
SELECT COUNT(*)
FROM superstore;
```

Result:
```sql
total_rows
------------
10194
```

**Reason:** Ensure consistency between the source file and the imported dataset.

## Final Dataset
| Attribute | Value |
|-----------|-----------:|
| Source	| Kaggle Superstore Sales Dataset |
| Total Records	| 10,194 |
| Total Columns	| 21 |
| Countries	| United States, Canada |
| Database	| PostgreSQL |
| Status	| Ready for Analysis |

> **Dataset Versioning**
>To ensure reproducibility, the original Kaggle dataset was preserved in `data/raw/samplesuperstore.csv`, while the cleaned dataset used throughout this project was saved as `data/processed/samplesuperstore_processed.csv`.
-- Retail Sales Analysis - P1 
CREATE DATABASE sql_project_p1

-- Creating the tables 
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
	transactions_id	INT PRIMARY KEY,
	sale_date DATE, 
	sale_time TIME, 
	customer_id	INT, 
	gender	VARCHAR(15),
	age	INT,
	category	VARCHAR(15),
	quantiy	INT, 
	price_per_unit	FLOAT, 
	cogs	FLOAT,
	total_sale FLOAT
    );
    
SELECT * FROM RETAIL_SALES
LIMIT 5;

SELECT COUNT(*) 
FROM RETAIL_SALES


-- CHECKING NULL VALUES IF EXITS 
SELECT * FROM 
RETAIL_SALES
WHERE 
	TRANSACTIONS_ID IS NULL
    OR 
    SALE_DATE IS NULL
    OR 
    SALE_TIME IS NULL 
    OR 
    CUSTOMER_ID IS NULL
    OR 
    GENDER IS NULL
    OR 
    AGE IS NULL
    OR 
    CATEGORY IS NULL
    OR 
    QUANTIY IS NULL 
    OR 
    PRICE_PER_UNIT IS NULL
    OR 
    COGS IS NULL 
    OR 
    TOTAL_SALE IS NULL


-- NO NULL VALUE FOUND IF THERE WAS ANY 

-- DELETE FROM RETAIL_SALES
-- WHERE 
-- 	TRANSACTIONS_ID IS NULL
--     OR 
--     SALE_DATE IS NULL
--     OR 
--     SALE_TIME IS NULL 
--     OR 
--     CUSTOMER_ID IS NULL
--     OR 
--     GENDER IS NULL
--     OR 
--     AGE IS NULL
--     OR 
--     CATEGORY IS NULL
--     OR 
--     QUANTIY IS NULL 
--     OR 
--     PRICE_PER_UNIT IS NULL
--     OR 
--     COGS IS NULL 
--     OR 
--     TOTAL_SALE IS NULL


-- DATA EXPLORATION 

-- HOW MANY SALES WE HAVE
SELECT COUNT(*) 
FROM RETAIL_SALES

-- HOW MANY CUSTOMERS WE HAVE 

SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS CUSTOMER_COUNT
FROM RETAIL_SALES 

-- ALL THE CATEGORIES WE HAVE 

SELECT DISTINCT CATEGORY 
FROM RETAIL_SALES


-- DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'.  

SELECT * 
FROM RETAIL_SALES 
WHERE SALE_DATE = '2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 4 in the month of Nov-2022.  

SELECT *
FROM RETAIL_SALES 
WHERE 
	CATEGORY = 'CLOTHING' 
	AND 
	QUANTIY >= 4 
    AND 
    DATE_FORMAT(SALE_DATE, '%Y-%m') = '2022-11'


-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.  
SELECT CATEGORY, SUM(TOTAL_SALE) AS TOTAL_SALE, COUNT(*) as TOTAL_ORDERS
FROM RETAIL_SALES 
GROUP BY CATEGORY;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.  

SELECT AVG(AGE) AS AGE 
FROM RETAIL_SALES 
WHERE CATEGORY = 'BEAUTY'

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.  

SELECT *
FROM RETAIL_SALES 
WHERE TOTAL_SALE > 1000;

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.  

SELECT CATEGORY, GENDER, COUNT(TRANSACTIONS_ID)
FROM RETAIL_SALES 
GROUP BY CATEGORY, GENDER
ORDER BY CATEGORY, GENDER ASC;

-- 7. Write a SQL query to calculate the average sale for each month and find out the best-selling month in each year.  

SELECT SALE_DATE, MONTHNAME(SALE_DATE) AS MONTH_NAME, ROUND(AVG(TOTAL_SALE), 2)
FROM RETAIL_SALES 
GROUP BY  MONTH_NAME, SALE_DATE

-- 8. Write a SQL query to find the top 5 customers based on the highest total sales.  

SELECT CUSTOMER_ID, SUM(TOTAL_SALE) AS TOTAL_SALE
FROM RETAIL_SALES 
GROUP BY CUSTOMER_ID
ORDER BY TOTAL_SALE DESC
LIMIT 5;


-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.  

SELECT CATEGORY, COUNT(DISTINCT CUSTOMER_ID) AS CUSTOMER
FROM RETAIL_SALES 
GROUP BY CATEGORY

-- 10. Write a SQL query to create each shift and count the number of orders (Morning <12, Afternoon Between 12 & 17, Evening >17).  


WITH hourly_sale AS (
    SELECT *,
        CASE 
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders    
FROM hourly_sale
GROUP BY shift;


-- END OF PROJECT -- 
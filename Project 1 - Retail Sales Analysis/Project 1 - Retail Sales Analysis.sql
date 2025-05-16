-- RETAIL SALES ANALYSIS PROJECT -- P1

-- -------------------------------- --
--      CREATING A DATABASE       --
-- -------------------------------- --

CREATE DATABASE sql_project_1_retail_sales;

-- Using the Database
USE sql_project_1_retail_sales;

-- -------------------------------- --
--        CREATING A TABLE        --
-- -------------------------------- --

DROP TABLE IF EXISTS retail_sales_tb ;
CREATE TABLE retail_sales (
	transactions_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	sale_date DATE,
	sale_time time,
	customer_id INT,
	gender VARCHAR(10),
	age INT,
	category VARCHAR(25),
	quantiy INT,
	price_per_unit DECIMAL(10,2),
	cogs DECIMAL(10,2),
	total_sale DECIMAL(10,2)
) AUTO_INCREMENT = 1000;

-- Display the contents of the table we just created.
SELECT * 
FROM retail_sales;


-- -------------------------------- --
  --          DATA IMPORT         --
-- -------------------------------- --
-- Perform the data import from the csv file
-- Once we made sure that the table data has been imported successfully we can display the data.
-- Use the Select Statement to display the contentns of the table.

-- Checking all the records are impoted properly
-- We can make use of the COUNT() functions for this.

SELECT COUNT(*) 
FROM RETAIL_SALES;


-- Checking for missing values in the table.
# Following code will help you to check for a NULL value in a specific column
SELECT * 
FROM RETAIL_SALES
WHERE transactions_id IS NULL;


-- -------------------------------- --
  --         DATA CLEANING        --
-- -------------------------------- --
# Let's check for null value columns
# The COUNT() function in the MySQL will return the count of non-null values in a column.
# So if we subtract the count of all rows from the count of specific column count we will get the count of NULL values.

SELECT 
	COUNT(*) AS total_rows,
    COUNT(*) - COUNT(transactions_id) AS null_transactions_id,
    COUNT(*) - COUNT(sale_date) AS null_sale_date,
    COUNT(*) - COUNT(sale_time) AS null_sale_time,
    COUNT(*) - COUNT(customer_id) AS null_customer_id,
    COUNT(*) - COUNT(gender) AS null_gender,
    COUNT(*) - COUNT(age) AS null_age,
    COUNT(*) - COUNT(category) AS null_category,
    COUNT(*) - COUNT(quantiy) AS null_quantity,
	COUNT(*) - COUNT(price_per_unit) AS null_price_per_unit,
    COUNT(*) - COUNT(cogs) AS null_cogs,
    COUNT(*) - COUNT(total_sale) AS null_total_sale
FROM RETAIL_SALES;


# Another way to find the missing values
SELECT * 
FROM RETAIL_SALES
WHERE 
	transactions_id IS NULL
	OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantiy IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;
    
# As, there are no NULL values in the table we do not need to handle the missing values now.
# If there are any NULL values in the tables we can DELETE them if we want as per the guidelines of the organization
# We can use the following statements for it:

# DELETE FROM retail_sales WHERE transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR gender IS NULL
#								 OR age IS NULL OR category IS NULL OR quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;


-- ---------------------------------- --
  -- -- Exploratory Data Analysis -- --
-- ---------------------------------- --

-- 1. How many Sales we have?
SELECT 
	FORMAT(COUNT(*), 0) as Total_Sales
FROM retail_sales;

-- 2. How maNy UNIQUE Customers we have?
SELECT FORMAT(COUNT(DISTINCT customer_id),0) Total_Customers
FROM retail_sales;

-- 3. How many unique categories we have
SELECT FORMAT(COUNT(DISTINCT category),0) as Total_Categories
FROM retail_sales;

-- 4. Which are the Unique Categories we have?
SELECT DISTINCT category as Categories
FROM retail_sales;

-- --------------------------------------- --
 -- Data Analysis | Key Business Problems --
-- --------------------------------------- --

-- Q1. Write an SQL query to retrieve all columns for sales made on '2022-11-05'?
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

SELECT COUNT(*) as Total_Sales_on_2022_11_05
FROM retail_sales
WHERE sale_date = '2022-11-05';


-- Q2. Write an SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov 2022?
SELECT Category, SUM(quantiy) as Total_Quantity
FROM retail_sales
WHERE 
	CATEGORY = 'Clothing' AND 
    quantiy > 3 AND 
    sale_date LIKE '2022-11-__';

-- Q3. Write an SQL query to calculate the total sales for each category?
SELECT 
	Category, 
    CONCAT("$ ", FORMAT(SUM(total_sale),2)) as 'Total Sales',
    COUNT(*) as Orders
FROM retail_sales
GROUP BY category;


-- Q4. Write an SQL query to find the average age of customers who purchased items from the 'Beauty' category?
SELECT ROUND(AVG(age),2) AS 'Average Age'
FROM retail_sales
WHERE category = 'Beauty';


-- Q5. Write an SQL query to find all transactions where the total_sale is greater than 1000?
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

SELECT COUNT(*) as 'Total # of Sales > $1000'
FROM retail_sales
WHERE total_sale > 1000;

-- Q6. Write an SQL query to find the total number of transactions made by each gender in each category?
SELECT 
    Category, 
	Gender, 
    COUNT(*) AS 'Total Transactions'
FROM retail_sales
GROUP BY category, gender
ORDER BY category;


-- Q7. Write an SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT 
	Year_,
    Month_,
    Avg_Sales
FROM 
(
	SELECT 
		DATE_FORMAT(sale_date, '%Y') AS Year_, 
		DATE_FORMAT(sale_date, '%M') AS Month_, 
		CONCAT("$ ", FORMAT(AVG(total_sale),2)) as Avg_Sales,
		RANK() OVER(PARTITION BY DATE_FORMAT(sale_date, '%Y') ORDER BY AVG(total_sale) DESC) AS rank_
	FROM retail_sales
	GROUP BY 1, 2
) AS t1
WHERE rank_ = 1;


-- Q8. Write an SQL query to find the top 5 customers based on the highest total sales?
SELECT customer_id, SUM(total_sale) as 'Total Sales'
FROM retail_sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;

-- Q9. Write an SQL query to find the number of unique customers who purchased items from each category?
SELECT category, COUNT(DISTINCT customer_id) as 'Unique Customers'
FROM retail_sales
GROUP BY category;


-- Q10. Write an SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT 
	CASE 
		WHEN hour(sale_time) < 12 THEN 'Morning'
        WHEN hour(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END AS shift,
    COUNT(*) AS orders
FROM retail_sales
GROUP BY Shift;

-- End Of Project --

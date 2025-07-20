-- Previewing the data in each table
'''sql
SELECT * 
FROM customers;

SELECT * 
FROM products;

SELECT * 
FROM dates;

SELECT * 
FROM sales;
'''
-- == == == == == == == == == == == == == == == == == == == == 

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 -- -- CHECKING FOR MISSING VALUES IN EACH TABLE -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Checking for missing values in the Customers Table
'''sql
SELECT * 
FROM customers;

SELECT 
	COUNT(*) AS total_rows,
    COUNT(*) - COUNT(customerID) AS missing_customerID,
    COUNT(*) - COUNT(CustomerName) AS missing_customer_name,
    COUNT(*) - COUNT(age) AS missing_age,
    COUNT(*) - COUNT(gender) AS missing_gender,
    COUNT(*) - COUNT(region) AS missing_region
FROM customers;
'''
-- Checking for missing values in the Products Table
'''sql
SELECT * 
FROM products;

SELECT 
	COUNT(*) AS total_rows,
    COUNT(*) - COUNT(productID) AS missing_productID,
    COUNT(*) - COUNT(ProductName) as missing_product_name,
    COUNT(*) - COUNT(category) AS missing_category ,
    COUNT(*) - COUNT(unitprice) AS missing_unit_price 
FROM products;
'''
-- Checking for missing values in the Dates Table
'''sql
SELECT * 
FROM dates;

SELECT 
	COUNT(*) AS total_rows,
    COUNT(*) - COUNT(date) AS missing_date,
    COUNT(*) - COUNT(dateid) AS missing_dateID,
    COUNT(*) - COUNT(year) AS missing_year,
    COUNT(*) - COUNT(day) AS missing_day,
    COUNT(*) - COUNT(quarter) AS missing_quarter
FROM dates;
'''
-- Checking for missing values in the Sales Table
'''sql
SELECT * 
FROM sales;

SELECT 
	COUNT(*) AS total_rows,
	COUNT(*) - COUNT(saleid) AS missing_saleid,
    COUNT(*) - COUNT(dateid) AS missing_dateid,
    COUNT(*) - COUNT(customerid) AS missing_customerid,
    COUNT(*) - COUNT(productid) AS missing_productid,
    COUNT(*) - COUNT(quantity) AS missing_quantity,
    COUNT(*) - COUNT(unitprice) AS missing_unitprice,
    COUNT(*) - COUNT(discount) AS missing_discount,
    COUNT(*) - COUNT(salesamount) AS missing_salesamount
FROM sales;
'''
-- == == == == == == == == == == == == == == == == == == == == 


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 -- --  CHECKING FOR NULL VALUES IN EACH TABLE  -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Checking for NULL values in the Products Table
'''sql
SELECT * 
FROM products;

SELECT 
	COUNT(*)
FROM products 
WHERE ProductID IS NULL;

SELECT 
	COUNT(*)
FROM products 
WHERE ProductName IS NULL;

SELECT 
	COUNT(*)
FROM products 
WHERE Category IS NULL;

SELECT 
	COUNT(*)
FROM products 
WHERE UnitPrice IS NULL;

'''
-- Checking for NULL values in the Customers Table
'''sql
SELECT *
FROM customers;

SELECT COUNT(*)
FROM customers
WHERE CustomerID IS NULL;

SELECT COUNT(*)
FROM customers
WHERE CustomerName IS NULL;

SELECT COUNT(*)
FROM customers
WHERE Age IS NULL;

SELECT COUNT(*)
FROM customers
WHERE Gender IS NULL;

SELECT COUNT(*)
FROM customers
WHERE Region IS NULL;

'''
-- Checking for NULL values in the Dates Table
'''sql
SELECT *
FROM dates;

SELECT COUNT(*)
FROM dates
WHERE Date IS NULL;

SELECT COUNT(*)
FROM dates
WHERE DateID IS NULL;

SELECT COUNT(*)
FROM dates 
WHERE Year IS NULL;

SELECT COUNT(*)
FROM dates
WHERE Day IS NULL;

SELECT COUNT(*)
FROM dates
WHERE Quarter IS NULL;

'''
-- Checking for NULL values in the Sales Table
'''sql
SELECT *
FROM sales;

SELECT COUNT(*)
FROM sales
WHERE SaleID IS NULL;

SELECT COUNT(*)
FROM sales
WHERE DateID IS NULL;

SELECT COUNT(*)
FROM sales
WHERE CustomerID IS NULL;

SELECT COUNT(*)
FROM sales
WHERE ProductID IS NULL;

SELECT COUNT(*)
FROM sales
WHERE Quantity IS NULL;

SELECT COUNT(*)
FROM sales
WHERE Discount IS NULL;

SELECT COUNT(*)
FROM sales
WHERE UnitPrice IS NULL;

SELECT COUNT(*)
FROM sales
WHERE SalesAmount IS NULL;
'''
-- == == == == == == == == == == == == == == == == == == == == 


-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 -- -- CHECKING FOR DUPLICATE VALUES IN EACH TABLE -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
'''sql
SELECT *
FROM customers;
'''
-- Checking for Duplicate CustomerID
'''sql
SELECT 
	CustomerID,
    COUNT(*) AS cnt
FROM customers
GROUP BY CustomerID
HAVING COUNT(*) > 1;
'''
-- Checking for Duplicate Records
'''sql
SELECT 
	CustomerID,
    CustomerName,
    Age,
    Gender,
    Region,
    COUNT(*) AS cnt
FROM customers
GROUP BY CustomerID, CustomerName, Age, Gender, Region
HAVING COUNT(*) > 1;
'''
-- == == == == == == == == == == == == == == == == == == == == 
'''sql
SELECT *
FROM products;
'''
-- Checking for Duplicate CustomerID
'''sql
SELECT 
	ProductID,
    COUNT(*) as count
FROM products
GROUP BY ProductID
HAVING count > 1;
'''
-- Checking for Duplicate Records
'''sql
SELECT 
	ProductID,
    ProductName,
    Category,
    UnitPrice,
    COUNT(*) as count
FROM products
GROUP BY ProductID, ProductName, Category, UnitPrice
HAVING count > 1;
'''
-- == == == == == == == == == == == == == == == == == == == == 
'''sql
SELECT *
FROM dates;
'''
-- Checking for Duplicate DateID
'''sql
SELECT 
	DateID,
    COUNT(*) as cnt
FROM dates
GROUP BY DateID
HAVING cnt > 1;
'''
-- Checking for Duplicate Records
'''sql
SELECT
	date,
    dateid,
    year,
    month,
    day,
    quarter,
    COUNT(*) cnt
FROM dates
GROUP BY date, dateid, year, month, day, quarter
HAVING cnt > 1;

'''
-- == == == == == == == == == == == == == == == == == == == == 
'''sql
SELECT *
FROM sales;
'''
-- Checking for Duplicate SaleIDs
'''sql
SELECT 
	SaleID,
    COUNT(*) AS cnt
FROM sales
GROUP BY SaleID
HAVING cnt > 1;
'''
-- Checking for Duplicate's on CustomerID, ProductID and Date columns 
'''sql
SELECT
	DateID,
    CustomerID,
    ProductID,
    COUNT(*) as cnt
FROM sales
GROUP BY DateID, CustomerID, ProductID
HAVING cnt > 1;
'''
-- == == == == == == == == == == == == == == == == == == == == 

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 -- -- CHECKING FOR INVALID DATA TYPES IN EACH TABLES -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- Checking for negative or invalid values in numeric columns
'''sql
SELECT *
FROM sales
WHERE SalesAmount < 0;

SELECT *
FROM sales
WHERE UnitPrice < 0;

SELECT *
FROM sales
WHERE Discount < 0;

SELECT *
FROM sales
WHERE Quantity < 0;

SELECT *
FROM Customers
WHERE Age < 0;

SELECT *
FROM Customers
WHERE Age > 130;

SELECT *
FROM products
WHERE UnitPrice < 0;
'''
-- Checking for Outliers in Sales, Customers and Products Tables using min/max values.
'''sql
SELECT
	MAX(SalesAmount),
    MIN(SalesAmount)
FROM Sales;

SELECT
	MAX(Age),
    MIN(Age)
FROM Customers;

SELECT
	MAX(UnitPrice),
    MIN(UnitPrice)
FROM Products;
'''
-- Checking the structure and data types of each table
'''sql
DESCRIBE products;

DESCRIBE customers;

DESCRIBE dates;

DESCRIBE sales;
'''
-- ============================================================

-- -- COMMENT: Cleaning & Fixing Data Issues --

-- Observing unexpected data types:
-- 'Date' column in Dates table is stored as text
-- 'Discount' column in Sales table contains blank strings

-- Checking distinct values in Discount column
'''sql
SELECT DISTINCT Discount
FROM Sales
ORDER BY Discount;
'''
-- Replacing blank or NULL values in Discount column with 0
'''sql
UPDATE Sales
SET Discount = '0'
WHERE Discount IS NULL or TRIM(Discount) = '';
'''
-- Converting Discount column to a numeric type (FLOAT)
'''sql
ALTER TABLE sales
MODIFY COLUMN Discount FLOAT;

DESCRIBE sales;

'''
-- Fixing the 'Date' column in the Dates Table
'''sql
SELECT DISTINCT date
FROM Dates
ORDER BY Date;

SELECT *
FROM Dates
WHERE STR_TO_DATE(Date, '%Y-%m-%d') IS NULL
	OR TRIM(Date) = '';

'''
-- Converting the Date column to proper DATE format
'''sql
ALTER TABLE Dates
MODIFY COLUMN Date DATE;

DESCRIBE Dates;
'''
-- ============================================================

-- ------------------------------------------------------------
-- -- CHECKING TABLE RELATIONSHIPS AND ENFORCING KEYS --
-- ------------------------------------------------------------

-- Verifying if keys in Sales table exist in the related lookup tables
'''sql
SELECT *
FROM sales s
JOIN products p
ON s.ProductID = p.ProductID
WHERE p.ProductID IS NULL;

SELECT *
FROM sales s
JOIN customers c
ON s.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

SELECT *
FROM sales s
JOIN dates d
ON s.DateID = d.DateID
WHERE d.DateID IS NULL;

'''
-- Ensuring referential integrity by checking for unmatched keys
'''sql
SELECT * FROM sales
WHERE DateID NOT IN (SELECT DateID FROM Dates);

SELECT * FROM sales
WHERE ProductID NOT IN (SELECT ProductID FROM products);

SELECT * FROM sales
WHERE CustomerID NOT IN (SELECT CustomerID FROM Customers);

'''
-- Adding PRIMARY and FOREIGN KEY constraints
'''sql
ALTER TABLE dates
ADD PRIMARY KEY (DateID);

ALTER TABLE products
ADD PRIMARY KEY (ProductID);

ALTER TABLE customers
ADD PRIMARY KEY (CustomerID);


ALTER TABLE sales
ADD CONSTRAINT fk_sales_date
FOREIGN KEY (DateID) REFERENCES dates(DateID);

ALTER TABLE sales
ADD CONSTRAINT fk_sales_products
FOREIGN KEY (ProductID) REFERENCES products(ProductID);

ALTER TABLE sales
ADD CONSTRAINT fk_sales_customers
FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID);

'''
-- Fixing mismatch in data type before adding CustomerID FK
'''sql
ALTER TABLE sales
MODIFY COLUMN CustomerID INT;

ALTER TABLE sales
ADD CONSTRAINT fk_sales_customers
FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID);

'''
-- ============================================================

-- ------------------------------------------------------------
-- -- PERFORMING EXPLORATORY DATA ANALYSIS (EDA) --
-- ------------------------------------------------------------

-- Key Metrics

-- 1. Total Revenue
'''sql
SELECT 
	CONCAT("$ ", FORMAT(SUM(SalesAmount),2)) AS total_revenue
FROM sales;

'''
-- 2. Total Quantity Ordered
'''sql
SELECT
	FORMAT(SUM(Quantity),0) AS total_quantity_ordered
FROM sales;

'''
-- 3. Total Number of Orders
'''sql
SELECT
	COUNT(SaleID) AS total_orders
FROM sales;

'''
-- 4. Average Discount Offered
'''sql
SELECT
	ROUND(AVG(Discount),2) AS avg_discount_offered
FROM sales;

'''
-- 5. Top 5 Best-Selling Products
'''sql
SELECT 
	p.ProductName AS Product,
    CONCAT("$ ", FORMAT(SUM(s.SalesAmount),2)) as Total_Sales
FROM sales s
JOIN products p
ON s.productID = p.productID
GROUP BY p.ProductName
ORDER BY SUM(s.SalesAmount)  DESC
LIMIT 5;

'''
-- 6. Categories Generating the Highest Revenue
'''sql
SELECT 
	p.Category,
    CONCAT("$", FORMAT(SUM(SalesAmount),2)) AS Total_Revenue
FROM sales s 
JOIN products p
ON s.productID = p.productID
GROUP BY p.category
ORDER BY SUM(SalesAmount) DESC;

'''
-- 7. Monthly Revenue Trend
'''sql
SELECT
	YEAR(d.date) AS Year,
    MONTH(d.date) AS Month,
    CONCAT("$ ", FORMAT(SUM(s.SalesAmount),2)) AS Total_Revenue
FROM sales s
JOIN dates d
ON s.DateID = d.DateID
GROUP BY YEAR(d.date), MONTH(d.date)
ORDER BY MONTH(d.date);

'''
-- 8. Highest Revenue Category per Month
'''sql
SELECT
	Month,
    Category,
    Total_Revenue
FROM (
	SELECT
		DATE_FORMAT(d.date, "%Y-%m") AS Month,
		p.Category AS Category,
		CONCAT('$', FORMAT(SUM(s.salesamount),2)) AS Total_Revenue,
		ROW_NUMBER() OVER(PARTITION BY DATE_FORMAT(d.date, "%Y-%m") ORDER BY DATE_FORMAT(d.date, "%Y-%m"), SUM(s.salesamount) DESC) AS rnk
	FROM sales s
	JOIN dates d ON s.DateID = d.DateID
	JOIN products p ON s.productID = p.productID
	GROUP BY DATE_FORMAT(d.date, "%Y-%m") , p.Category
	ORDER BY Month, SUM(s.salesamount) DESC
) AS sq
WHERE rnk <= 1;

'''
-- 9. Customer Segmentation Based on Age Group
'''sql
SELECT 
		CASE
			WHEN age <= 12 THEN 'Child'
            WHEN age <= 18 THEN 'Teen'
            WHEN age <= 59 THEN 'Adult'
            ELSE 'Senior Citizen'
        END AS AgeGroup,
        COUNT(*) AS Customer_Count
FROM customers
GROUP BY AgeGroup;

'''
-- 10. Revenue by Region
'''sql
SELECT 
	c.Region,
    CONCAT("$ ", FORMAT(SUM(s.SalesAmount),2)) AS Total_Revenue
FROM sales s
JOIN customers c
ON s.CustomerID = c.CustomerID
GROUP BY c.region;

'''
-- 11. Products with Highest Average Discount
'''sql
SELECT
	p.ProductName,
    ROUND(AVG(s.Discount),2) AS Avg_Discount
FROM sales s
JOIN products p
ON s.productID = p.productID
GROUP BY p.ProductName
ORDER BY Avg_Discount DESC
LIMIT 6;

'''

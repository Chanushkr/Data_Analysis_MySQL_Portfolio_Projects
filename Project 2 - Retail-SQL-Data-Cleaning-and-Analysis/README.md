# 🧠 Data Cleaning & Exploratory Analysis Using MySQL

This project involves cleaning and exploring a **retail sales database** using **pure SQL**. The dataset contains four core tables: `Customers`, `Products`, `Dates`, and `Sales`. The project follows a structured approach to assess data quality, ensure referential integrity, and uncover meaningful business insights.

---

## 📂 Tables Used

- **customers**
- **products**
- **dates**
- **sales**

---

## 🛠️ Project Steps

### 🔍 1. Data Exploration
- Previewed all records in the 4 main tables.
- Described the structure and data types of each table.

### ❌ 2. Missing Values Check
- Identified missing and NULL values column-wise in each table.

### ♻️ 3. Duplicate Values Check
- Checked for duplicate primary keys and full-row duplicates.

### ⚠️ 4. Invalid / Outlier Data Check
- Detected negative and abnormal values in columns like `Age`, `Discount`, `SalesAmount`, and `Quantity`.
- Verified outliers using min-max checks.

### 🔧 5. Data Type Fixes
- Converted `Discount` from text to numeric after replacing blank strings.
- Updated `Date` column in `Dates` table to proper DATE type.

### 🔗 6. Relationship Check & Constraints
- Ensured every foreign key in `Sales` exists in the `Customers`, `Products`, and `Dates` tables.
- Added `PRIMARY KEY` and `FOREIGN KEY` constraints for referential integrity.
- Resolved type mismatch issues between tables.

---

## 📊 Exploratory Data Analysis (EDA)

### 🔢 Key Metrics
- **Total Revenue**
- **Total Quantity Sold**
- **Total Number of Orders**
- **Average Discount Offered**

### 🏆 Business Insights
- Top 5 Best-Selling Products
- Categories with Highest Revenue
- Monthly Revenue Trends
- Best Performing Category by Month
- Revenue by Region
- Products with Highest Average Discount
- Customer Segmentation by Age Group

---

## 💡 Sample SQL Snippet

```sql
-- Total Revenue Generated
SELECT 
    CONCAT("$ ", FORMAT(SUM(SalesAmount),2)) AS total_revenue
FROM sales;

```sql

---

## 🧼 Tools Used
**MySQL Workbench**
**SQL (Structured Query Language)**


---

## ✅ Outcomes
- This project demonstrates how to:

- Perform comprehensive data validation in SQL

- Clean and prepare data for analysis without any third-party tools

- Derive key business insights purely using SQL queries

- Set up relational integrity and ensure dataset reliability


---

## 📁 Project Files
- sales_db_cleaning_and_insights.sql – Full SQL script used in this project


---

## 📌 Author

# 🛍️ Retail Sales Analysis Project using MySQL

This project showcases how to perform **data analysis** using **MySQL** on a retail sales dataset. It includes steps from database creation, data cleaning, exploratory analysis, and solving real-world business questions using SQL queries.

---

## 📂 Project Structure

### 1. **Database & Table Setup**
- Create a new database and define the table structure.
- Add constraints like `PRIMARY KEY`, `AUTO_INCREMENT`, and `NOT NULL`.
- Set `AUTO_INCREMENT` to start from 1000.

### 2. **Data Import**
- Import data from an external file (e.g., Excel or CSV).
- Verify that data is imported correctly using `SELECT` and `COUNT()` queries.

### 3. **Data Cleaning**
- Check for `NULL` values column-wise using conditional logic and aggregate functions.
- Handle missing data appropriately based on business rules.

### 4. **Exploratory Data Analysis (EDA)**
- Total number of sales and unique customers.
- Unique product categories and their frequency.
- Daily sales and date-specific trends.

### 5. **Key Business Questions Answered**
- Sales on a specific date.
- Category-based analysis (e.g., clothing items with quantity > 3).
- Total sales and order counts by category.
- Average customer age for specific categories.
- High-value sales (e.g., above $1000).
- Gender-wise transaction breakdown by category.
- Best performing month each year.
- Top 5 customers by total spending.
- Unique customers per category.
- Time-of-day sales shift classification (Morning, Afternoon, Evening).

---

## 🛠️ Tools Used
- **MySQL 8+**
- **SQL Workbench** / Any preferred MySQL interface
- **Excel/CSV** for data import

---

## 📊 Sample Insights
- Identify **best-selling months** for each year using `RANK()` window function.
- Segment customer purchase patterns by **gender** and **category**.
- Categorize sales shifts based on transaction **hour of the day**.

---

## 📁 File Name
- `Project 1 - Retail Sales Analysis.sql` – contains all queries and logic.

---

## 🚀 How to Use
1. Clone this repository.
2. Open the SQL script in your MySQL environment.
3. Run the queries step-by-step or execute the whole script after importing the dataset.

---

## 🧠 Author's Note
This is a beginner-friendly project aimed at strengthening SQL skills for real-world business data problems. Contributions and suggestions are always welcome!


# 💰 Financial Data Analysis Using MySQL (Workbench 8.0)

This project focuses on performing comprehensive data cleaning, validation, and exploratory data analysis (EDA) on financial records using SQL. The goal is to ensure data quality, establish relational integrity, and generate valuable insights such as income statements, balance sheets, and key financial KPIs.

---

## 📊 Tools & Technologies Used

- **MySQL Workbench 8.0**
- SQL (DDL, DML, Joins, Views, Aggregations)

---

## 📂 Dataset Overview

The database consists of 5 tables:

- `accounts` – Chart of Accounts with types like Revenue, Expense, Asset, etc.
- `departments` – Departments responsible for financial transactions
- `dates` – Dimensional table with calendar date details
- `vendors_customers` – Parties involved in transactions
- `general_ledger` – Fact table storing all financial transactions

---

## ⚙️ Key Steps Performed

1. **Data Exploration**
   - Checked the structure and content of all tables.
   - Verified data types and column consistency.

2. **Missing Value Handling**
   - Identified missing and blank values across all tables.
   - Replaced blank `Description` values with `'No Description'`.

3. **Data Validation**
   - Checked for NULLs and duplicates in primary key columns.
   - Identified and flagged negative or invalid entries.

4. **Data Type Corrections**
   - Converted date strings into proper `DATE` type.
   - Updated incorrect data types for referential columns.

5. **Relational Integrity**
   - Validated foreign key relationships between `general_ledger` and lookup tables.
   - Defined appropriate PRIMARY and FOREIGN KEY constraints.

6. **EDA & KPIs**
   - Created views for `income_statement` and `balance_sheet`.
   - Calculated Revenue, Expenses, Net Income, Assets, Profit Margin, Expense Ratio.
   - Analyzed trends like Monthly Revenue and Department-wise Expenses.

---

## 📌 Sample Insights

- 💰 **Net Income**: Calculated by subtracting total expenses from total revenue.
- 📈 **Profit Margin**: Shows profitability as a percentage of revenue.
- 🏢 **Department Expenses**: Breaks down cost contribution by department.
- 📊 **Balance Sheet Composition**: Asset vs. Liability vs. Equity analysis.

---

## 📁 Folder Structure

📦Financial-Data-Analysis-MySQL
┣ 📄 README.md
┣ 📄 Financial Insights MySQL.sql

---

## 📎 How to Use

1. Open **MySQL Workbench 8.0**
2. Connect to your local server and import the `financial_data_analysis.sql` script.
3. Execute the code step-by-step to:
   - Inspect and clean data
   - Create views
   - Generate key financial metrics
4. Use the results for visualization or reporting.

---

## 🔗 Author

**Chanush KR**  
🔗 [LinkedIn](https://www.linkedin.com/in/chanush-kr)  
🌐 [Portfolio Website](https://sites.google.com/view/chanushkr/home)  
📌 [LinkedIn Post about this Project](https://www.linkedin.com/posts/chanush-kr_sql-datacleaning-financialanalysis-activity-7354370474748862464--oxt?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD0Tw64BmW6pg1qf8-1ow9qOM-2tCEyFJRw)
_Aspiring Data Scientist | SQL & Python Enthusiast_

---

> If you found this helpful, don’t forget to ⭐️ the repo and connect on LinkedIn!

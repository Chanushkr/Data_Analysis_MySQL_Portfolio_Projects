-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
			## FINANCIAL DATA ANALYSISS ##
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

## Checking the structure and data of all the core tables.
SELECT *
FROM accounts;

SELECT *
FROM departments;

SELECT *
FROM dates;

SELECT *
FROM vendors_customers;

SELECT *
FROM general_ledger;

-- Checking for missing values in the 'accounts' table
SELECT 
	COUNT(*) AS total_rows,
    COUNT(*) - COUNT(AccountID) AS missing_account_id,
    COUNT(*) - COUNT(AccountName) AS missing_account_name,
    COUNT(*) - COUNT(AccountType) AS missing_account_type
FROM accounts;

-- Checking for missing values in the 'departments' table
SELECT 
	COUNT(*) AS total_rows,
    COUNT(*) - COUNT(DepartmentID) AS missing_department_id,
    COUNT(*) - COUNT(DepartmentName) AS missing_department_name
FROM departments;

-- Checking for missing values in the 'dates' table
SELECT 
	COUNT(*) AS total_rows,
    COUNT(*) - COUNT(DateID) AS missing_date_id,
    COUNT(*) - COUNT(Year) AS missing_year,
    COUNT(*) - COUNT(Month) AS missing_month,
    COUNT(*) - COUNT(Day) AS missing_day,
    COUNT(*) - COUNT(Quarter) AS missing_quarter
FROM dates;

-- Checking for missing values in the 'vendors_customers' table
SELECT 
	COUNT(*) AS total_rows,
    COUNT(*) - COUNT(PartyID) AS missing_party_id,
    COUNT(*) - COUNT(PartyName) AS missing_party_name,
    COUNT(*) - COUNT(PartyType) AS missing_party_type
FROM vendors_customers;

-- Checking for missing values in the 'general_ledger' table
SELECT 
	COUNT(*) AS total_rows,
    COUNT(*) - COUNT(EntryID) AS missing_entry_id,
    COUNT(*) - COUNT(Date) AS missing_date,
    COUNT(*) - COUNT(AccountID) AS missing_account_id,
    COUNT(*) - COUNT(DepartmentID) AS missing_department_id,
    COUNT(*) - COUNT(PartyID) AS missing_party_id,
    COUNT(*) - COUNT(Amount) AS missing_amount,
    COUNT(*) - COUNT(Type) AS missing_type,
    COUNT(*) - COUNT(Description) AS missing_description
FROM general_ledger;

-- Checking for blank or NULL PartyID values in 'general_ledger'
SELECT 
	COUNT(PartyID) as missing_partyID
FROM general_ledger
WHERE TRIM(PartyID) = '' OR PartyID IS NULL;

-- Checking for blank or NULL Description values in 'general_ledger'
SELECT 
	COUNT(*)
FROM general_ledger
WHERE TRIM(Description) = '' OR Description IS NULL;

-- Retrieving records with empty or NULL Description
SELECT 
	*
FROM general_ledger
WHERE TRIM(Description) = '' OR Description IS NULL;

-- There are 10 records with empty Description. Replacing them with 'No Description'.
UPDATE general_ledger
SET Description = 'No Description'
WHERE TRIM(Description) = '' OR Description IS NULL;

-- Re-checking Description column to confirm replacements
SELECT 
	COUNT(*)
FROM general_ledger
WHERE TRIM(Description) = '' OR Description IS NULL;

-- Checking for NULL values in Primary Key columns of all lookup tables
SELECT 
	COUNT(*)
FROM accounts
WHERE AccountID IS NULL;

SELECT 
	COUNT(*)
FROM departments
WHERE DepartmentID IS NULL;

SELECT 
	COUNT(*)
FROM dates
WHERE DateID IS NULL;

SELECT 
	COUNT(*)
FROM vendors_customers
WHERE PartyID IS NULL;

-- Checking for duplicate IDs and records in each table

-- Duplicates in 'accounts' by full record
SELECT 
	AccountID,
    AccountName,
    AccountType,
	COUNT(*) as cnt
FROM accounts
GROUP BY AccountID, AccountName, AccountType
HAVING COUNT(*) > 1;

-- Duplicate AccountIDs only
SELECT 
	AccountID,
	COUNT(*) as cnt
FROM accounts
GROUP BY AccountID
HAVING COUNT(*) > 1;

-- Duplicate DepartmentIDs
SELECT 
	DepartmentID,
	COUNT(*) as cnt
FROM departments
GROUP BY DepartmentID
HAVING COUNT(*) > 1;

-- Duplicates in 'departments' by full record
SELECT 
	DepartmentID,
    DepartmentName,
	COUNT(*) as cnt
FROM departments
GROUP BY DepartmentID, DepartmentName
HAVING COUNT(*) > 1;

-- Duplicate DateIDs
SELECT 
	DateID,
	COUNT(*) as cnt
FROM dates
GROUP BY DateID
HAVING COUNT(*) > 1;

-- Duplicates in 'dates' by full record
SELECT 
	DateID,
    Year,
    Month,
    Day,
    Quarter,
	COUNT(*) as cnt
FROM dates
GROUP BY DateID, Year, Month, Day, Quarter
HAVING COUNT(*) > 1;

-- Duplicate PartyIDs
SELECT 
	PartyID,
	COUNT(*) as cnt
FROM vendors_customers
GROUP BY PartyID
HAVING COUNT(*) > 1;

-- Duplicates in 'vendors_customers' by full record
SELECT 
	PartyID,
    PartyName,
    PartyType,
	COUNT(*) as cnt
FROM vendors_customers
GROUP BY PartyID, PartyName, PartyType
HAVING COUNT(*) > 1;

-- Duplicate EntryIDs
SELECT 
	EntryID,
	COUNT(*) as cnt
FROM general_ledger
GROUP BY EntryID
HAVING COUNT(*) > 1;

-- Duplicates in 'general_ledger' by full record
SELECT 
	EntryID,
    Date,
    AccountID,
    DepartmentID,
    PartyID,
    Amount,
    Type,
    Description,
	COUNT(*) as cnt
FROM general_ledger
GROUP BY EntryID, Date, AccountID, DepartmentID, PartyID, Amount, Type, Description
HAVING COUNT(*) > 1;

-- Checking column data types and invalid entries

-- View table structure
DESCRIBE accounts;

DESCRIBE departments;

DESCRIBE dates;

-- Converting DateID to proper Date format
ALTER TABLE dates
MODIFY COLUMN DateID Date;

-- Checking modified structure and sample data
SELECT *
FROM dates;


DESCRIBE vendors_customers;

DESCRIBE general_ledger;

-- Converting Date and PartyID columns in 'general_ledger' to proper data types
ALTER TABLE general_ledger
MODIFY COLUMN Date Date;

ALTER TABLE general_ledger
MODIFY COLUMN PartyID int;


-- Validating if Date fields are in valid format
SELECT 
	DateID
FROM dates
WHERE STR_TO_DATE(DateID, '%Y-%m-%d') IS NOT NULL;

SELECT 
	Date
FROM general_ledger
WHERE STR_TO_DATE(Date, '%Y-%m-%d') IS NOT NULL;

-- Checking for negative values in Amount
SELECT 
	*
FROM general_ledger
WHERE Amount < 0;

-- Identifying outliers in Amount column
SELECT 
	MAX(Amount),
    MIN(Amount)
FROM general_ledger;

-- Validating referential integrity between general_ledger and lookup tables
SELECT *
FROM general_ledger
WHERE AccountID NOT IN (SELECT AccountID FROM accounts);

SELECT *
FROM general_ledger
WHERE PartyID NOT IN (SELECT PartyID FROM vendors_customers);

SELECT *
FROM general_ledger
WHERE Date NOT IN (SELECT DateID FROM dates);

SELECT *
FROM general_ledger
WHERE DepartmentID NOT IN (SELECT DepartmentID FROM departments);

-- Setting primary keys for lookup tables
ALTER TABLE accounts
ADD PRIMARY KEY (AccountID);

ALTER TABLE departments
ADD PRIMARY KEY (DepartmentID);

ALTER TABLE dates
ADD PRIMARY KEY (DateID);

ALTER TABLE vendors_customers
ADD PRIMARY KEY (PartyID);

-- Ensuring join relationships exist between general_ledger and lookup tables
SELECT *
FROM general_ledger gl
JOIN accounts a
ON gl.AccountID = a.AccountID
WHERE a.AccountID IS NULL;

SELECT *
FROM general_ledger gl
JOIN departments d
ON gl.DepartmentID = d.DepartmentID
WHERE d.DepartmentID IS NULL;

SELECT *
FROM general_ledger gl
JOIN vendors_customers vc
ON gl.PartyID = vc.PartyID
WHERE vc.PartyID IS NULL;

SELECT *
FROM general_ledger gl
JOIN dates dt
ON gl.Date = dt.DateID
WHERE dt.DateID IS NULL;

-- Creating foreign key constraints between fact table and lookup tables
ALTER TABLE general_ledger
ADD CONSTRAINT fk_accounts
FOREIGN KEY (AccountID) REFERENCES accounts(AccountID);

ALTER TABLE general_ledger
ADD CONSTRAINT fk_departments
FOREIGN KEY (DepartmentID) REFERENCES departments(DepartmentID);

ALTER TABLE general_ledger
ADD CONSTRAINT fk_vendors_customers
FOREIGN KEY (PartyID) REFERENCES vendors_customers(PartyID);

ALTER TABLE general_ledger
ADD CONSTRAINT fk_dates
FOREIGN KEY (Date) REFERENCES dates(DateID);

-- ------------------------------------------------------------
-- -- PERFORMING EXPLORATORY DATA ANALYSIS (EDA) --
-- ------------------------------------------------------------

-- Creating a view for Income Statement (Revenue and Expense transactions)
DROP VIEW IF EXISTS income_statement;
CREATE VIEW income_statement AS 
SELECT 
	gl.*,
    d.DepartmentName,
    a.AccountType
FROM general_ledger gl
JOIN accounts a
ON gl.AccountID = a.AccountID
JOIN departments d
ON gl.DepartmentID = d.DepartmentID
WHERE a.AccountType IN ('Revenue', 'Expense');


-- Creating a view for Balance Sheet (Assets, Liabilities, Equity for latest month)
DROP VIEW IF EXISTS Balance_Sheet;
CREATE VIEW Balance_Sheet AS 
SELECT 
    gl.Date,
    a.AccountType,
    gl.Amount
FROM general_ledger gl
JOIN accounts a 
ON gl.AccountID = a.AccountID
WHERE a.AccountType IN ('Asset', 'Liability', 'Equity') 
	AND DATE_FORMAT(gl.Date, '%Y-%m') = (
		SELECT DATE_FORMAT(MAX(Date), '%Y-%m') 
		FROM general_ledger gl2
		);

-- Previewing the views
SELECT *
FROM income_statement;

SELECT *
FROM Balance_Sheet;

-- Calculating key financial KPIs
SELECT 
	'Revenue' AS Label,
    concat("$", FORMAT(SUM(Amount),2)) AS Value
FROM income_statement
WHERE AccountType = 'Revenue'

UNION ALL

SELECT 
	'Expense' AS Label,
    concat("$", FORMAT(SUM(Amount),2)) AS Value
FROM income_statement
WHERE AccountType = 'Expense'

UNION ALL 

SELECT
	'Net income',
    CONCAT("$",FORMAT(SUM(CASE WHEN AccountType = 'Revenue' THEN Amount ELSE -Amount END),2))
FROM income_statement
WHERE AccountType IN ('Revenue', 'Expense')

UNION ALL

SELECT
	'Assets',
    CONCAT("$", FORMAT(SUM(Amount),2))
FROM balance_sheet
WHERE AccountType = 'Asset'

UNION ALL

SELECT
	'Profit Margin',
    CONCAT(ROUND(
		( SUM(CASE WHEN AccountType = 'Revenue' THEN Amount ELSE 0 END) - 
        SUM(CASE WHEN AccountType = 'Expense' THEN Amount ELSE 0 END) ) /
        NULLIF(SUM(CASE WHEN AccountType = 'Revenue' THEN Amount ELSE 0 END), 0),
        2
    ) * 100, '%')
FROM income_statement

UNION ALL

SELECT
	'Expense Ratio',
    CONCAT(ROUND(
		SUM(CASE WHEN AccountType = 'Expense' THEN Amount ELSE 0 END) /
        SUM(CASE WHEN AccountType = 'Revenue' THEN Amount ELSE 0 END),
        2) * 100, '%')
FROM income_statement;

-- Income vs Expense summary
SELECT 
	AccountType AS Label,
    CONCAT("$", FORMAT(SUM(Amount),2)) AS Value
FROM income_statement
GROUP BY AccountType;

-- Balance Sheet breakdown with percentage contribution
SELECT 
	AccountType AS Label,
    CONCAT("$", FORMAT(SUM(Amount),2)) AS Value,
    CONCAT(ROUND((SUM(Amount) * 100 ) / (SELECT SUM(Amount) FROM balance_sheet),1), "%") AS Percentage
FROM balance_sheet
GROUP BY AccountType;

-- Monthly Revenue Trend
SELECT 
	DATE_FORMAT(Date, "%Y-%m") AS YearMonth,
    CONCAT("$",FORMAT(SUM(Amount),0)) AS Revenue
FROM income_statement
WHERE AccountType = 'Revenue'
GROUP BY DATE_FORMAT(Date, "%Y-%m")
ORDER BY DATE_FORMAT(Date, "%Y-%m");

-- Department-wise Expense Breakdown
SELECT 
	DepartmentName AS Department,
    CONCAT("$", FORMAT(SUM(Amount),2)) AS Expenses
FROM income_statement
WHERE AccountType = 'Expense'
GROUP BY DepartmentName;

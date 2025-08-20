# 📝 PAN Number Validation Project (MySQL)

## 📌 Project Overview
This project demonstrates how to **clean and validate PAN numbers** using **MySQL Workbench 8.0**.  
The goal is to ensure that the given PAN numbers follow the standard Indian PAN format and meet specific rules beyond the basic regex pattern.

The project includes:
- **Data Cleaning**: Removing nulls, trimming spaces, and converting to uppercase.  
- **Validation Function**: A **user-defined function (UDF)** `validate_pan()` that checks if the PAN complies with defined rules.  
- **Categorization**: PAN numbers are categorized as **Valid** or **Invalid**.  
- **Summary Report**: A grouped report showing counts of valid vs invalid PANs.  

---

## ⚙️ Tools & Technologies Used
- **MySQL Workbench 8.0** – For query development and execution.  
- **SQL (MySQL 8.0)** – To write UDF, Common Table Expressions (CTEs), and Views.  

---

## 📂 Input & Output Files

### 🔹 Input
- **Pan Number Validation.sql**  
  This SQL script contains:
  - User Defined Function (`validate_pan`)  
  - Data cleaning logic using CTE and View  
  - Queries for categorizing PAN numbers as Valid/Invalid  
  - Summary report query  

### 🔹 Outputs
The results of the validation queries are saved as images for easy reference:

1. **Valid & Invalid PAN Numbers.jpeg**  
   - Displays a categorized list of PAN numbers with their status (**Valid** / **Invalid**).  
   - Preview:  
     ![Valid & Invalid PAN Numbers](Valid%20&%20Invalid%20PAN%20Numbers.jpeg)

2. **Valid PAN Numbers.jpeg**  
   - Shows only the **Valid PAN numbers** extracted from the dataset.  
   - Preview:  
     ![Valid PAN Numbers](Valid%20PAN%20Numbers.jpeg)


## 🛠️ Steps Implemented

### 1. User Defined Function – `validate_pan(p_str)`
A custom function is created to validate a PAN number.  
It checks the following rules:

1. **Length Check** – PAN must have **10 characters**.  
2. **Regex Format Check** – Must match the pattern:  
   - First 5 characters: Alphabets (A-Z)  
   - Next 4 characters: Digits (0-9)  
   - Last 1 character: Alphabet (A-Z)  
3. **Additional Rules**  
   - No **adjacent same alphabets** in the first 5 characters.  
   - No **sequential alphabets** (e.g., `ABCDE`) in the first 5 characters.  
   - No **adjacent same digits** in the numeric part.  
   - No **sequential digits** (e.g., `1234`) in the numeric part.  

---

### 2. Cleaning PAN Numbers
A **CTE** and later a **View (`cleaned_pan_numbers`)** are created to:  
- Remove duplicates.  
- Trim extra spaces.  
- Convert PAN numbers to uppercase.  
- Exclude NULL and empty values.  

---

### 3. Valid vs Invalid Categorization
Using the function `validate_pan()`, PAN numbers are categorized as:  
- ✅ **Valid PAN**  
- ❌ **Invalid PAN**  

```sql
SELECT 
    pan_number,
    CASE
        WHEN validate_pan(pan_number) = TRUE THEN 'Valid PAN'
        ELSE 'Invalid PAN'
    END AS pan_status
FROM cte_cleaned_pan;
```

### 4. Summary Report
A grouped report is generated to count valid vs invalid PAN numbers.

```sql
SELECT 
    CASE
        WHEN validate_pan(pan_number) = TRUE THEN 'Valid PAN'
        ELSE 'Invalid PAN'
    END AS pan_status,
    COUNT(*) as cnt
FROM cleaned_pan_numbers
GROUP BY pan_status;
```

### 🙏 Acknowledgments
This project was inspired by the **TechTFQ YouTube channel**, which provides excellent tutorials on SQL, data engineering, and related concepts.
Special thanks to their content for helping me understand and implement this project idea.

### Author
Chanush KR

🔗 [LinkedIn](https://www.linkedin.com/in/chanush-kr)  
🌐 [Portfolio Website](https://sites.google.com/view/chanushkr/home)  
📌 [LinkedIn Post about this Project]

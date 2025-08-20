-- Project: Clean and validate a dataset containing PAN numbers 
-- The validation is done by checking if each PAN follows the standard format and business rules.

-- Step 1: Create a User Defined Function (UDF) to validate PAN numbers
DROP FUNCTION IF EXISTS validate_pan;

DELIMITER $$
CREATE FUNCTION validate_pan(p_str VARCHAR(20))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
	DECLARE i INT;
    DECLARE ascii1 INT;
    DECLARE ascii2 INT;
    
    -- Check if the PAN number contains exactly 10 characters
    IF LENGTH(p_str) <> 10 THEN
		RETURN FALSE;
    END IF;
    
    -- Validate PAN number format: 
	-- First 5 characters → Alphabets 
	-- Next 4 characters → Digits 
	-- Last character → Alphabet
    IF p_str NOT REGEXP '^[A-Z]{5}[0-9]{4}[A-Z]{1}$' THEN
		RETURN FALSE;
    END IF;
    
    -- Rule 1: Ensure no two adjacent alphabets are the same in the first 5 characters
    SET i = 1;
    
    WHILE i < 5 DO
		IF SUBSTRING(p_str, i, 1) = SUBSTRING(p_str, i+1, 1) THEN
			RETURN FALSE;
        END IF;
        
        SET i = i + 1;
    END WHILE;

	-- Rule 2: Ensure the first 5 characters are not sequential alphabets (e.g., ABCDE)    
    SET i = 1;
    
    myloop: WHILE i < 5 DO
		SET ascii1 = ASCII(SUBSTRING(P_str, i, 1));
        SET ascii2 = ASCII(SUBSTRING(P_str, i+1, 1));
        
        IF ascii2 = ascii1 + 1 THEN
			IF i = 4 THEN
				RETURN FALSE;
            END IF;
		ELSE
			LEAVE myloop;
        END IF;
        SET i = i + 1;
    END WHILE myloop;
    
    -- Rule 3: Ensure no two adjacent digits are the same in the numeric part (next 4 characters)
    SET i = 6;
    
    WHILE i < 9 DO
		IF SUBSTRING(p_str, i, 1) = SUBSTRING(p_str, i + 1, 1) THEN
			RETURN FALSE;
        END IF;
        SET i = i + 1;
    END WHILE;

	-- Rule 4: Ensure the numeric part does not contain sequential digits (e.g., 1234)    
    SET i = 6;
    
    myloop2: WHILE i < 9 DO
		SET ascii1 = ASCII(SUBSTRING(p_str, i, 1));
        SET ascii2 = ASCII(SUBSTRING(p_str, i+1, 1));
        
        IF ascii2 = ascii1 + 1 THEN
			IF i = 8 THEN
				RETURN FALSE;
            END IF;
		ELSE
			LEAVE myloop2;
        END IF;
        
        SET i = i + 1;
    END WHILE myloop2;
    
    RETURN TRUE;
END $$
DELIMITER ;


-- Step 2: Categorize PAN numbers as Valid or Invalid using the validation function
WITH cte_cleaned_pan AS(
	SELECT DISTINCT UPPER(TRIM(pan_number)) as pan_number
    FROM pan_numbers
    WHERE 	pan_number IS NOT NULL AND
			TRIM(pan_number) <> ''
)

SELECT 
	pan_number,
    CASE
		WHEN validate_pan(pan_number) = TRUE THEN 'Valid PAN'
        ELSE 'Invalid PAN'
    END AS pan_status
FROM cte_cleaned_pan;


-- Step 3: Create a view to clean the PAN dataset 
-- (remove duplicates, trim spaces, convert to uppercase, and exclude NULL/empty values)
DROP VIEW IF EXISTS cleaned_pan_numbers ;
CREATE VIEW cleaned_pan_numbers AS
	SELECT DISTINCT UPPER(TRIM(pan_number)) as pan_number
    FROM pan_numbers
    WHERE 	pan_number IS NOT NULL AND
			TRIM(pan_number) <> '';


-- Step 4: Generate a summary report 
-- (count of Valid vs Invalid PAN numbers after applying the validation function)
SELECT 
    CASE
		WHEN validate_pan(pan_number) = TRUE THEN 'Valid PAN'
        ELSE 'Invalid PAN'
    END AS pan_status,
    COUNT(*) as cnt
FROM cleaned_pan_numbers
GROUP BY pan_status;
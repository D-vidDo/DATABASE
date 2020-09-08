set echo on
set pagesize 66
set linesize 132
spool c:/cprg250/Q4Q5.txt

-- QUESTION 4
COLUMN "Phone" FORMAT A15
COLUMN "Customer Name" FORMAT A20
COLUMN "Date Created" FORMAT A20
SELECT a.first_name || ' ' || a.surname "Customer Name",
    '(' || area_code || ')' || SUBSTR(a.phone, 1, 3) ||'-'||SUBSTR(a.phone, 4, 4) "Phone",
    b.account_type,
    TO_CHAR(b.date_created, 'FMMonth DD, YYYY') "Date Created"
FROM wgb_customer a
NATURAL JOIN wgb_account b
ORDER BY 1, 3;
CLEAR COLUMNS

-- QUESTION 5 - TRADITIONAL JOIN
COLUMN "SURNAME" FORMAT A10
COLUMN "TRANSACTION_TYPE" FORMAT A5
SELECT a.surname, d.account_description, b.balance, c.transaction_number, c.transaction_type, c.transaction_date, c.transaction_amount
FROM wgb_customer a, wgb_account b, wgb_transaction c, wgb_account_type d
WHERE a.customer_number = b.customer_number
    AND b.customer_number = c.customer_number
    AND b.account_type = d.account_type
    AND b.account_type = c.account_type
    AND d.account_description LIKE '%Interest%'
ORDER BY 4;
CLEAR COLUMNS

-- QUESTION 5 - NATURAL JOIN 
SELECT a.surname, d.account_description, b.balance, c.transaction_number, c.transaction_type, c.transaction_date, c.transaction_amount
FROM WGB_customer a
NATURAL JOIN WGB_Account b
    NATURAL JOIN WGB_ACCOUNT_TYPE d
    NATURAL JOIN WGB_TRANSACTION c
    WHERE d.account_description LIKE '%Interest%'
ORDER BY 4;

-- QUESTION 5 - JOIN ON
SELECT a.surname, d.account_description, b.balance, c.transaction_number, c.transaction_type, c.transaction_date, c.transaction_amount
FROM wgb_customer a
    JOIN wgb_account b ON (a.customer_number = b.customer_number)
    JOIN wgb_transaction c ON (b.customer_number = c.customer_number) AND (b.account_type = c.account_type)
    JOIN wgb_account_type d ON (b.account_type = d.account_type)
        AND d.account_description LIKE '%Interest%'
ORDER BY 4;

-- QUESTION 5 - JOIN USING
SELECT surname, account_description, balance, transaction_number, transaction_type, transaction_date, transaction_amount
FROM wgb_customer JOIN wgb_account USING (customer_number)
    JOIN wgb_transaction USING (account_type, customer_number)
    JOIN wgb_account_type USING (account_type) 
WHERE account_description LIKE '%Interest%'
ORDER BY 4;

spool off
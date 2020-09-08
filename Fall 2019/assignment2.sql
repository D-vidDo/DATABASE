set linesize 132
set pagesize 66
set echo ON
spool c:/cprg250/assignment2output.txt

-- QUESTION 1
COLUMN "Full Name" FORMAT A20
SELECT first_name || ' ' || surname "Full Name", customer_number, COUNT(customer_number) "# of Trans",
    CASE WHEN COUNT(customer_number) > 10 THEN 'Gold'
     WHEN COUNT(customer_number) > 6 THEN 'Silver'
     ELSE 'Bronze'
END "Level"
FROM wgb_customer NATURAL JOIN wgb_account
NATURAL JOIN wgb_transaction  
GROUP BY first_name, surname, customer_number
ORDER BY 3 DESC;
CLEAR COLUMNS
CLEAR BREAKS

-- QUESTION 2
COLUMN "Customer Name" FORMAT A20
COLUMN zip FORMAT A7
SELECT T.*, ROWNUM "Position"
FROM (SELECT (first_name || ', ' || surname) || ' ' || 
      SUBSTR(middle_name, 1, 1) || '.' "Customer Name",
        SUBSTR(postal_code, 1, 3) || ' ' || SUBSTR(postal_code, 4, 8) "Zip",
        COUNT(account_type) "# of Accts"
    FROM wgb_account a JOIN wgb_customer c USING (customer_number)
    GROUP BY first_name, surname, middle_name, postal_code, customer_number
    HAVING COUNT(account_type) > 1
    ORDER BY 3 DESC, first_name) T
WHERE rownum <= 3;
CLEAR COLUMNS
CLEAR BREAKS

-- QUESTION 3
COLUMN "Name" FORMAT A12
COLUMN "Open Date" FORMAT A17
SELECT customer_number "Cust#",
    surname || ', ' || first_name "Name",
    account_type "Type",
    TO_CHAR(date_created, 'DD MONTH YYYY') "Open Date",
    balance
FROM wgb_account NATURAL JOIN wgb_customer 
WHERE (balance) in (SELECT MAX(balance)
FROM wgb_account
WHERE account_type = '5'
    OR account_type = '2'
GROUP BY account_type)
ORDER BY 4;
CLEAR COLUMNS
CLEAR BREAKS

-- QUESTION 4
COLUMN "Name" FORMAT A11
COLUMN "Acc Name" FORMAT A22
COLUMN "Total" FORMAT $9,999.99
SELECT SUBSTR(first_name, 1, 1) || '. ' || surname "Name",
account_description "Acc Name",
    SUM(DECODE(transaction_type, 'D', -1, 'C', 1, 0) * transaction_amount) "Total"
FROM wgb_customer NATURAL JOIN wgb_account
NATURAL JOIN wgb_account_type
NATURAL JOIN wgb_transaction 
WHERE city = 'Harrison' OR city = 'Eyebrow' 
GROUP BY ROLLUP ((first_name, surname), account_description)
ORDER BY first_name;
CLEAR COLUMNS
CLEAR BREAKS

spool off
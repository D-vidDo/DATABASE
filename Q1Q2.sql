set echo on
set pagesize 66
set linesize 132
spool
c:
/cprg250/Q1Q2.txt


-- QUESTION 1
SELECT customer_number, account_type, date_created
FROM WGB_ACCOUNT
WHERE date_created LIKE '%JAN%';

-- QUESTION 2
SELECT customer_number "Cust #", account_type "Type", 'Non-Zero Balance' "Status"
FROM WGB_ACCOUNT
WHERE balance != 0
UNION
SELECT customer_number, account_type, 'Has Transactions'
FROM wgb_transaction
WHERE TRANSACTION_number != 0
ORDER BY 1;


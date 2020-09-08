set echo off
set pagesize 66
set linesize 132
spool c:/cprg250/Q3.txt
set feedback on

-- QUESTION 3
SELECT account_type
FROM wgb_account_type;

ACCEPT account_type CHAR PROMPT 'Please enter account type: ' 
ACCEPT balance CHAR PROMPT 'Please enter balance: ' 
SELECT a.first_name "First", a.surname "Last", b.account_description, c.balance
FROM wgb_customer a, wgb_account c, wgb_account_type b
WHERE a.customer_number = c.customer_number
    AND c.account_type = b.account_type
    AND b.account_type = &account_type
    AND c.balance > &balance;

spool off
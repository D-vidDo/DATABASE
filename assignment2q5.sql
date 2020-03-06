spool on
spool C:\cprg250\assignment2q5output.txt
set echo on
set linesize 100
set pagesize 44

-- QUESTION 5
COLUMN "Name" FORMAT A16
COLUMN "Cust#" FORMAT A10
COLUMN "Account Type" FORMAT A30
COLUMN "Trans #" FORMAT 999
COLUMN "Amount" FORMAT $9,999.99
BREAK ON "Name" SKIP 2 ON "Cust#" SKIP 2 ON "Account Type" ON "Acct Ttl" SKIP 3 ON "Ttl Transactions" ON REPORT
TTITLE CENTER 'Transaction Report' RIGHT 'Page: ' FORMAT 9 SQL.pno SKIP 2
REPFOOTER SKIP 1 CENTER 'For Internal Use Only'
COMPUTE SUM LABEL 'Cust Ttl' OF "Amount" ON "Name"
COMPUTE SUM LABEL 'Acct Ttl' OF "Amount" ON "Cust#"
COMPUTE COUNT LABEL 'Ttl Transaction' OF "Trans #" ON REPORT
COMPUTE SUM LABEL 'Grand Total' OF "Amount" ON REPORT
SELECT surname || ', ' || first_name "Name", customer_number || '-' || account_type "Cust#", account_description "Account Type", 
       to_char(transaction_date, 'MON/dd, YYYY') "Date", transaction_number "Trans #", DECODE(TRANSACTION_TYPE,'D',-1,'C',1,0)*TRANSACTION_AMOUNT "Amount"
FROM wgb_account NATURAL JOIN wgb_account_type 
                 NATURAL JOIN wgb_transaction 
                 NATURAL JOIN wgb_customer
ORDER BY transaction_number;
CLEAR COLUMNS
CLEAR BREAKS
SPOOL OFF
set echo on
set pagesize 66
set linesize 132
spool C:/cprg250/labmod5q2output.txt

TTITLE CENTER "Customer / Title Information" SKIP 1 -  
       CENTER "Customer Order Evaluation" SKIP 2

BTITLE CENTER "Internal Use Only"

BREAK ON name SKIP 1 -
ON pubid ON REPORT
COMPUTE SUM LABEL 'Total Cost:' OF cost ON INITCAP(name)
COMPUTE SUM LABEL 'Grand Total Cost' OF cost ON report
COLUMN name HEADING 'Publisher Name'
COLUMN pubid HEADING 'ID'
COLUMN title HEADING 'Book Title'
COLUMN cost FORMAT $999.99 HEADING 'Book Cost'
SELECT name, pubid, title, cost
FROM publisher NATURAL JOIN books
ORDER BY 1, 3;
CLEAR COLUMNS

spool off
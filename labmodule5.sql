set echo on
set pagesize 66
set linesize 132
spool C:/cprg250/labmod5q1output.txt

TTITLE CENTER "Customer / Title Information" SKIP 1 -  
       CENTER "Customer Order Evaluation" SKIP 2

BTITLE CENTER "Internal Use Only"

BREAK ON "Book Title" ON REPORT
COLUMN cost FORMAT $999.99 HEADING 'Book Cost'
SELECT
INITCAP(title) "Book Title",
INITCAP(lastname) "Last Name",
INITCAP(firstname) "First Name",
cost
FROM books NATURAL JOIN orderitems
NATURAL JOIN orders
NATURAL JOIN customers
ORDER BY title;
CLEAR COLUMNS

spool off
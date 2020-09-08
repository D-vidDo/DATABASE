set echo ON
set linesize 132
set pagesize 66
spool c:/cprg250/lab5output.txt

-- QUESTION 2
SELECT INITCAP(firstname) "First",
INITCAP(lastname) "Last",
order#,
SUM(paideach*quantity) "Order Ttl"
FROM orderitems NATURAL JOIN orders NATURAL JOIN customers
GROUP BY (firstname, lastname, order#)
ORDER BY 2, 1;

-- QUESTION 3
SELECT TO_CHAR(AVG(COUNT(UNIQUE isbn)/COUNT(UNIQUE authorid)), '9.99') "Avg"
FROM bookauthor
GROUP BY authorid;

-- QUESTION 4
SELECT INITCAP(category) "Category",
COUNT(title) "Num of Books", 
TO_CHAR(AVG(retail), '$99.99') "Average"
FROM books
GROUP BY category
HAVING COUNT(title) >= 2
ORDER BY 1;

-- QUESTION 5
SELECT INITCAP(fname) "First",
INITCAP(lname) "Last",
SUM(quantity) "# of Books"
FROM author
JOIN bookauthor USING (authorid)
JOIN books USING (isbn)
JOIN orderitems USING (isbn)
GROUP BY fname, lname
HAVING SUM(quantity) >= 10;

-- QUESTION 6 
SELECT firstname, lastname, SUM(paideach*quantity) "Value"
FROM orderitems JOIN orders USING (order#)
JOIN customers USING (customer#)
GROUP BY GROUPING SETS((firstname, lastname, order#), (firstname, lastname), ())
ORDER BY 2;

spool off
set echo on
set pagesize 66
set linesize 132
spool c:/cprg250/lab3output.txt

-- QUESTION 2 PART A
SELECT a.firstname, a.lastname, b.order#, c.item#, d.title, e.gift
FROM customers a, orders b, orderitems c, books d, promotion e
WHERE a.customer# = b.customer#
  AND b.order# = c.order#
  AND c.isbn = d.isbn
  AND d.retail BETWEEN e.minretail AND e.maxretail
ORDER BY 2, 1, 3, 4;

-- QUESTION 2 PART B
SELECT a.firstname, a.lastname, b.order#, c.item#, d.title, e.gift
FROM customers a JOIN orders b ON (a.customer# = b.customer#)
  JOIN orderitems c ON (b.order# = c.order#)
  JOIN books d ON (c.isbn = d.isbn)
  JOIN promotion e ON (e.minretail <= d.retail AND d.retail <= e.maxretail);

-- QUESTION 3 PART A - TRADITIONAL JOIN
SELECT DISTINCT firstname || ' ' || lastname "Customer Name", fname || ' ' || lname "Author Name"
FROM customers a, orders b, orderitems c, books d, bookauthor e, author f
WHERE a.customer# = b.customer#
  AND b.order# = c.order#
  AND c.isbn = d.isbn
  AND d.isbn = e.isbn
  AND e.authorid = f.authorid
ORDER BY 1;

-- QUESTION 3 PART B - NATURAL JOIN
SELECT DISTINCT firstname || ' ' || lastname "Customer Name", fname || ' ' || lname "Author Name"
FROM customers NATURAL JOIN orders
  NATURAL JOIN orderitems
  NATURAL JOIN books
  NATURAL JOIN bookauthor
  NATURAL JOIN author     
ORDER BY 1;

-- QUESTION 3 PART C - JOIN USING
SELECT DISTINCT firstname || ' ' || lastname "Customer Name", fname || ' ' || lname "Author Name"
FROM customers JOIN orders USING (customer#)
  JOIN orderitems USING (order#)
  JOIN books USING (isbn)
  JOIN bookauthor USING (isbn)
  JOIN author USING (authorid)     
ORDER BY 1;

-- QUESTION 3 PART D - JOIN ON
SELECT DISTINCT firstname || ' ' || lastname "Customer Name", fname || ' ' || lname "Author Name"
FROM customers a JOIN orders b ON (a.customer# = b.customer#)
  JOIN orderitems c ON (b.order# = c.order#)
  JOIN books d ON (c.isbn = d.isbn)
  JOIN bookauthor e ON (d.isbn = e.isbn)
  JOIN author f ON (e.authorid = f.authorid)
ORDER BY 1;

-- QUESTION 4
SELECT fname, lname, title
FROM books a, bookauthor b, author c
WHERE a.isbn(+) = b.isbn
  AND b.authorid(+) = c.authorid
ORDER BY 2;

spool off
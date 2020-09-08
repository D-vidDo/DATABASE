set echo on
set pagesize 66
set linesize 132
spool c:/cprg250/lab4output.txt


-- QUESTION 2
COLUMN "Pub Date" FORMAT A20
SELECT INITCAP(a.lname) "Surname", INITCAP(b.title) "Book Title", TO_CHAR(b.pubdate, 'FMMonth DD, YYYY') "Pub Date", b.retail-NVL(b.discount, 0) "Final Price"
FROM author a JOIN bookauthor c USING (authorid)
    JOIN books b USING (isbn)
ORDER BY 2;
CLEAR COLUMNS

-- QUESTION 3
COLUMN "Date Published" FORMAT A20
COLUMN "Review Date" FORMAT A20
SELECT INITCAP(title) "Book Title", pubdate "Date Published", ADD_MONTHS(pubdate,6) "Review Date"
FROM books
ORDER BY 1;
CLEAR COLUMNS

-- QUESTION 4
SELECT INITCAP(title) "Book Title",
    TO_CHAR(retail-NVL(discount, 0), '99.99') "Price",
    TO_CHAR(cost,'99.99') "Cost",
    TO_CHAR((((retail-NVL(discount,0))-cost)/cost*100), '9999.99') "% Profit"
FROM books
ORDER BY 4 DESC;

--QUESTION 5
SELECT INITCAP(title) "Book Title",
    TO_CHAR(((retail-cost)/cost) * 100, '999.99') "Margin",
    TO_CHAR(discount, '99.99') "Discount",
    CASE WHEN discount IS NOT NULL THEN 'Discounted, will NOT be restocked'
         WHEN ((retail-cost)/cost) * 100 >= 60 THEN 'Very High Profit'
         WHEN ((retail-cost)/cost) * 100 >= 30 THEN 'High Profit'
         WHEN ((retail-cost)/cost) * 100 >= 0 THEN 'Loss Leader'
    END AS "Pricing Structure"
    FROM books
    ORDER BY 1;

spool off
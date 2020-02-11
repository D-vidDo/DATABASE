set echo ON
set linesize 132
set pagesize 66

-- QUESTION 2 BUT WITH 32 ROWS INSTEAD OF 21
SELECT c.firstname, c.lastname, MAX(o.order#) "WOWWWWW", oi.quantity*oi.paideach "Order Ttl"
FROM customers c
JOIN orders o ON (c.customer# = o.customer#)
JOIN orderitems oi ON (o.order# = oi.order#)
WHERE o.order# = oi.order#
GROUP BY o.order#, c.firstname, c.lastname, oi.quantity*oi.paideach
ORDER BY 2,1;

-- WIP QUESTION 2
SELECT customers.firstname, customers.lastname, MAX(order#) "Order#"
FROM orders JOIN customers ON (orders.customer# = customers.customer#)
GROUP BY order#, firstname, lastname
ORDER BY 2,1;

-- WIP QUESTION 2 ORDER TOTAL
SELECT SUM(paideach) "Order Ttl"
FROM orderitems
GROUP BY order#;
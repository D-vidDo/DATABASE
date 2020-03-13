set echo ON
set linesize 132
set pagesize 66

-- QUESTION 1
INSERT INTO customers
    (customer#, lastname, firstname, email, address, city, state, zip, referred, region)
VALUES
    ('1111', 'Do', 'David', 'dave@sat.net', '1000 Luna Ave', 'Boston', 'MA', '12345', '1001', 'NE');

-- QUESTION 2
INSERT INTO orders
    (order#, customer#, orderdate, shipdate, shipstreet, shipcity, shipstate, shipcost)
VALUES
    ('1021', '1111', SYSDATE, SYSDATE + 4, '1202 Orange Ave', 'Seattle', 'WA', '3')

-- QUESTION 3
commit;

-- QUESTION 4
UPDATE books
SET discount = retail * 0.10
WHERE category = (SELECT category
FROM books
WHERE isbn = 4981341710);

-- QUESTION 5
DELETE author
WHERE authorid NOT IN (SELECT authorid
FROM bookauthor);

ROLLBACK;
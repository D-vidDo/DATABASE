set echo on
set pagesize 66
set linesize 132

-- STEP 3
DESC mm_member;

-- STEP 4
INSERT INTO mm_member
    (member_id, last, first)
VALUES
    ('0', 'Do', 'David')

-- STEP 5
UPDATE mm_member
SET credit_card = '111111111111'
WHERE member_id = '0';

-- STEP 6
DELETE FROM mm_member WHERE member_id = '0';

-- STEP 7
COMMIT;

-- STEP 8 JOIN ON
SELECT a.movie_title, b.rental_id, c.last
FROM mm_movie a
    JOIN mm_rental b ON (a.movie_id = b.movie_id)
    JOIN mm_member c ON (b.member_id = c.member_id);

-- STEP 9 TRADITIONAL JOIN
SELECT a.movie_title, b.rental_id, c.last
FROM mm_movie a, mm_rental b, mm_member c
WHERE a.movie_id = b.movie_id
    AND b.member_id = c.member_id;

-- STEP 10 CREATE TABLE
DROP TABLE my_table CASCADE CONSTRAINTS;
CREATE TABLE my_table
(
    -- table attributes
    my_number NUMBER(8,0),
    my_date DATE,
    my_string VARCHAR2(5)
);
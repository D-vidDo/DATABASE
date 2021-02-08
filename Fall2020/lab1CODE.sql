-- STEP 2
CREATE SEQUENCE seq_movie_id
START WITH 20
INCREMENT BY 5;

-- STEP 3
SELECT seq_movie_id.CURRVAL
FROM dual;
SELECT seq_movie_id.NEXTVAL
FROM dual;

-- STEP 4
SELECT seq_movie_id.NEXTVAL
FROM dual;

-- STEP 5
INSERT INTO mm_movie
    (movie_id, movie_title, movie_cat_id, movie_value, movie_qty)
VALUES
    (seq_movie_id.NEXTVAL, 'Your Name', '5', '25', '1');

-- STEP 6
CREATE VIEW vw_movie_rental AS
SELECT movie_title, rental_id, last
FROM mm_movie a
    JOIN mm_rental b ON (a.movie_id = b.movie_id)
    JOIN mm_member c ON (b.member_id = c.member_id);

-- STEP 7
SELECT * FROM vw_movie_rental;

-- STEP 8
CREATE PUBLIC SYNONYM m_type FOR mm_movie_type;
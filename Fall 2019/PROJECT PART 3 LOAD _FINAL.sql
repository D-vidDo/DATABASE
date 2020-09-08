set linesize 132
set pagesize 66
set echo ON
spool c:/cprg250/project_part_3_load.txt

-- LOAD CUSTOMER TABLE
INSERT INTO customer
VALUES ('John Smith', '43', '123 Wow Street', 'Calgary', 'T1T3R5', '134.6543', 'AX');
INSERT INTO customer
VALUES ('Anna Woe', '21', '43 Pine Street', 'Calgary', 'T2A4X4', '321.9876', 'MC');
INSERT INTO customer
VALUES ('Michael Jack', '33', '77 Hehe Road', 'Edmonton', 'S4S1D2', '333.1234', 'VS');
INSERT INTO customer
VALUES ('Cindy Cruz', '19', '9000 Penbrooke Ave', 'Calgary', 'T1P6C1', '987.6543', 'MC');
INSERT INTO customer
VALUES ('Greg Bob', '73', '144 Greene Ave', 'Toronto', 'L0S3R7', '543.8632', 'AX');

COMMIT;

-- LOAD DIRECTORS TABLE
INSERT INTO director
VALUES ('James Cameron', '111.1111');
INSERT INTO director
VALUES ('Russo Brothers', '111.2222');
INSERT INTO director
VALUES ('Christopher Nolan', '111.3333');
INSERT INTO director
VALUES ('Andrew Lau', '111.4444');
INSERT INTO director
VALUES ('The Wachowskis', '111.5555');
INSERT INTO director
VALUES ('Makoto Shinkai', '111.6666');
INSERT INTO director
VALUES ('Phyllida Lloyd','111.7777');
INSERT INTO director
VALUES ('Susan Johnson','111.8888');
INSERT INTO director
VALUES ('Michael Fimognari','111.9999');
INSERT INTO director
VALUES ('John Stevenson','222.2222');
INSERT INTO director
VALUES ('Jennifer Nelson','222.3333');
INSERT INTO director
VALUES ('Chris Buck','222.4444');
INSERT INTO director
VALUES ('John Krasinski','333.5555');
INSERT INTO director
VALUES ('Ari Aster','444.5555');
INSERT INTO director
VALUES ('Brett Ratner','123.4567');
INSERT INTO director
VALUES ('Naoko Yamada','645.2342');

COMMIT;

-- LOAD MOVIES TABLE
INSERT INTO movie
VALUES ('Titanic', '195', '1997', 'PG', 'James Cameron');
INSERT INTO movie
VALUES ('Avengers: Endgame', '181', '2019', '14a', 'Russo Brothers');
INSERT INTO movie
VALUES ('Inception', '148', '2010', '14a', 'Christopher Nolan');
INSERT INTO movie
VALUES ('Initial D', '110', '2005', 'PG', 'Andrew Lau');
INSERT INTO movie
VALUES ('The Matrix', '136', '1999', 'PG', 'The Wachowskis');
INSERT INTO movie
VALUES ('The Garden of Words', '045', '2013', 'G', 'Makoto Shinkai');
INSERT INTO movie
VALUES ('Mamma Mia!', '108', '2008', 'G', 'Phyllida Lloyd');
INSERT INTO movie
VALUES ('To All The Boys Ive Loved Before', '099', '2018', 'G', 'Susan Johnson');
INSERT INTO movie
VALUES ('To All The Boys: P.S. I Still Love You', '102', '2020', 'G', 'Michael Fimognari');
INSERT INTO movie
VALUES ('Kung Fu Panda', '095', '2008', 'G', 'John Stevenson');
INSERT INTO movie
VALUES ('Kung Fu Panda 2', '091', '2011', 'G', 'Jennifer Nelson');
INSERT INTO movie
VALUES ('Kung Fu Panda 3', '095', '2016', 'G', 'Jennifer Nelson');
INSERT INTO movie
VALUES ('Frozen', '103', '2013', 'G', 'Chris Buck');
INSERT INTO movie
VALUES ('Frozen II', '103', '2019', 'G', 'Chris Buck');
INSERT INTO movie
VALUES ('A Quiet Place', '090', '2018', 'PG', 'John Krasinski');
INSERT INTO movie
VALUES ('Hereditary', '127', '2018', 'PG', 'Ari Aster');
INSERT INTO movie
VALUES ('Rush Hour', '098', '1998', 'G', 'Brett Ratner');
INSERT INTO movie
VALUES ('Rush Hour 2', '090', '2001', 'G', 'Brett Ratner');
INSERT INTO movie
VALUES ('Rush Hour 3', '091', '2007', 'G', 'Brett Ratner');
INSERT INTO movie
VALUES ('A Silent Voice', '130', '2016', 'G', 'Naoko Yamada');

COMMIT;

-- LOAD PAYMENT TABLE
INSERT INTO payment
VALUES ('Cindy Cruz', 'MC', TO_DATE('2020-01-01', 'YYYY-MM-DD'), '6.99', '6.99', '00000001');
INSERT INTO payment
VALUES ('John Smith', 'AX', TO_DATE('2020-02-01','YYYY-MM-DD'), '0.99', '0.99', '00000002');
INSERT INTO payment
VALUES ('Anna Woe', 'MC', TO_DATE('2020-02-04', 'YYYY-MM-DD'), '3.99', '3.99', '00000003');
INSERT INTO payment
VALUES ('Greg Bob', 'AX', TO_DATE('2020-01-01', 'YYYY-MM-DD'), '6.99', '6.99', '00000004');
INSERT INTO payment
VALUES ('Michael Jack', 'VS', TO_DATE('2020-01-15', 'YYYY-MM-DD'), '0.99', '0.99', '00000005');
INSERT INTO payment
VALUES ('Cindy Cruz', 'MC', TO_DATE('2020-02-01', 'YYYY-MM-DD'), '4.99', '4.99', '00000006');
INSERT INTO payment
VALUES ('Greg Bob', 'AX', TO_DATE('2020-01-12', 'YYYY-MM-DD'), '6.99', '6.99', '00000007');
INSERT INTO payment
VALUES ('Anna Woe', 'MC', TO_DATE('2020-02-20', 'YYYY-MM-DD'), '5.99', '5.99', '00000008');
INSERT INTO payment
VALUES ('John Smith', 'AX', TO_DATE('2020-02-15', 'YYYY-MM-DD'), '3.99', '3.99', '00000009');
INSERT INTO payment
VALUES ('Cindy Cruz', 'MC', TO_DATE('2020-02-15', 'YYYY-MM-DD'), '4.99', '4.99', '00000010');
INSERT INTO payment
VALUES ('Michael Jack', 'VS', TO_DATE('2020-01-30', 'YYYY-MM-DD'), '4.99', '4.99', '00000011');
INSERT INTO payment
VALUES ('Cindy Cruz', 'MC', TO_DATE('2020-03-02', 'YYYY-MM-DD'), '1.99', '1.99', '00000012');
INSERT INTO payment
VALUES ('Greg Bob', 'AX', TO_DATE('2020-02-10', 'YYYY-MM-DD'), '5.99', '5.99', '00000013');
INSERT INTO payment
VALUES ('Anna Woe', 'MC', TO_DATE('2020-03-15', 'YYYY-MM-DD'), '1.99', '1.99', '00000014');
INSERT INTO payment
VALUES ('Michael Jack', 'VS', TO_DATE('2020-02-25', 'YYYY-MM-DD'), '0.99', '0.99', '00000015');

COMMIT;

-- LOAD RENTAL RATES TABLE
INSERT INTO rental_rates
VALUES ('A', 'HD', '6.99');
INSERT INTO rental_rates
VALUES ('A', 'SD', '5.99');
INSERT INTO rental_rates
VALUES ('B', 'HD', '4.99');
INSERT INTO rental_rates
VALUES ('B', 'SD', '3.99');
INSERT INTO rental_rates
VALUES ('C', 'HD', '1.99');
INSERT INTO rental_rates
VALUES ('C', 'SD', '0.99');

COMMIT;

-- LOAD RENTALS TABLE
INSERT INTO rental
VALUES ('00000001', 'A', 'HD', 'Cindy Cruz', 'A Silent Voice', TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2020-01-02','YYYY-MM-DD'), '4');
INSERT INTO rental
VALUES ('00000002', 'C', 'SD', 'John Smith', 'Kung Fu Panda 2', TO_DATE('2020-02-01','YYYY-MM-DD'), TO_DATE('2020-02-10','YYYY-MM-DD'), '5');
INSERT INTO rental
VALUES ('00000003', 'B', 'SD', 'Anna Woe', 'Mamma Mia!', TO_DATE('2020-02-04','YYYY-MM-DD'), TO_DATE('2020-02-14','YYYY-MM-DD'), '3');
INSERT INTO rental
VALUES ('00000004', 'A', 'HD', 'Greg Bob', 'Kung Fu Panda 2', TO_DATE('2020-01-01','YYYY-MM-DD'), TO_DATE('2020-01-10','YYYY-MM-DD'), '4');
INSERT INTO rental
VALUES ('00000005', 'C', 'SD', 'Michael Jack', 'Avengers: Endgame', TO_DATE('2020-01-15','YYYY-MM-DD'), TO_DATE('2020-1-25','YYYY-MM-DD'), '5');
INSERT INTO rental
VALUES ('00000006', 'B', 'HD', 'Cindy Cruz', 'Hereditary', TO_DATE('2020-02-01','YYYY-MM-DD'), TO_DATE('2020-02-10','YYYY-MM-DD'), '3');
INSERT INTO rental
VALUES ('00000007', 'A', 'HD', 'Greg Bob', 'All The Boys Ive Loved Before', TO_DATE('2020-01-12','YYYY-MM-DD'), TO_DATE('2020-01-22','YYYY-MM-DD'), '4');
INSERT INTO rental
VALUES ('00000008', 'A', 'SD', 'Anna Woe', 'The Matrix', TO_DATE('2020-02-20','YYYY-MM-DD'), TO_DATE('2020-03-01','YYYY-MM-DD'), '4');
INSERT INTO rental
VALUES ('00000009', 'B', 'SD', 'John Smith', 'Rush Hour 3', TO_DATE('2020-02-15','YYYY-MM-DD'), TO_DATE('2020-02-25','YYYY-MM-DD'), '5');
INSERT INTO rental
VALUES ('00000010', 'B', 'HD', 'Cindy Cruz', 'The Garden of Words', TO_DATE('2020-02-15','YYYY-MM-DD'), TO_DATE('2020-02-25','YYYY-MM-DD'), '5');
INSERT INTO rental
VALUES ('00000011', 'B', 'HD', 'Michael Jack', 'Rush Hour 3', TO_DATE('2020-01-30','YYYY-MM-DD'), TO_DATE('2020-02-10','YYYY-MM-DD'), '5');
INSERT INTO rental
VALUES ('00000012', 'C', 'HD', 'Cindy Cruz', 'Initial D', TO_DATE('2020-03-02','YYYY-MM-DD'), TO_DATE('2020-03-12','YYYY-MM-DD'), '2');
INSERT INTO rental
VALUES ('00000013', 'A', 'SD', 'Greg Bob', 'Titanic', TO_DATE('2020-02-10','YYYY-MM-DD'), TO_DATE('2020-02-20','YYYY-MM-DD'), '3');
INSERT INTO rental
VALUES ('00000014', 'C', 'HD', 'Anna Woe', 'The Matrix', TO_DATE('2020-03-15','YYYY-MM-DD'), TO_DATE('2020-03-19','YYYY-MM-DD'), '4');
INSERT INTO rental
VALUES ('00000015', 'C', 'SD', 'Michael Jack', 'Titanic', TO_DATE('2020-02-25','YYYY-MM-DD'), TO_DATE('2020-03-02','YYYY-MM-DD'), '3');

COMMIT;

-- LOAD REFUNDS TABLE
INSERT INTO refund
VALUES ('00000001', '0.99', 'Michael Jack', TO_DATE('2020-03-02','YYYY-MM-DD'));
INSERT INTO refund
VALUES ('00000002', '1.99', 'Cindy Cruz', TO_DATE('2020-03-12','YYYY-MM-DD'));

COMMIT;

-- LOAD CATEGORIES TABLE
INSERT INTO category
VALUES ('Titanic', 'Drama');
INSERT INTO category
VALUES ('Avengers: Endgame', 'Action');
INSERT INTO category
VALUES ('Inception', 'Thriller');
INSERT INTO category
VALUES ('Initial D', 'Sports');
INSERT INTO category
VALUES ('The Matrix', 'Action');
INSERT INTO category
VALUES ('The Garden of Words', 'Animation');
INSERT INTO category
VALUES ('Mamma Mia!', 'Musical');
INSERT INTO category
VALUES ('To All The Boys Ive Loved Before', 'Romance');
INSERT INTO category
VALUES ('To All The Boys: P.S. I Still Love You', 'Romance');
INSERT INTO category
VALUES ('Kung Fu Panda', 'Animation');
INSERT INTO category
VALUES ('Kung Fu Panda 2', 'Animation');
INSERT INTO category
VALUES ('Kung Fu Panda 3', 'Animation');
INSERT INTO category
VALUES ('Frozen', 'Family');
INSERT INTO category
VALUES ('Frozen II', 'Family');
INSERT INTO category
VALUES ('A Quiet Place', 'Horror');
INSERT INTO category
VALUES ('Hereditary', 'Horror');
INSERT INTO category
VALUES ('Rush Hour', 'Comedy');
INSERT INTO category
VALUES ('Rush Hour 2', 'Comedy');
INSERT INTO category
VALUES ('Rush Hour 3', 'Comedy');
INSERT INTO category
VALUES ('A Silent Voice', 'Animation');

COMMIT;

spool off
set linesize 132
set pagesize 66
set echo ON
spool c:/cprg250/project_part_3_create.txt

DROP TABLE refund
CASCADE CONSTRAINTS;
DROP TABLE customer
CASCADE CONSTRAINTS;
DROP TABLE refund_transactions
CASCADE CONSTRAINTS;
DROP TABLE director
CASCADE CONSTRAINTS;
DROP TABLE movie
CASCADE CONSTRAINTS;
DROP TABLE movie_rented
CASCADE CONSTRAINTS;
DROP TABLE listing
CASCADE CONSTRAINTS;
DROP TABLE category
CASCADE CONSTRAINTS;
DROP TABLE payment
CASCADE CONSTRAINTS;
DROP TABLE rental_rates
CASCADE CONSTRAINTS;
DROP TABLE rental
CASCADE CONSTRAINTS;


CREATE TABLE refund
(
    ref_transactionNum NUMBER(8,0) CONSTRAINT ref_transacNum_NN NOT NULL,
    refund_amount NUMBER(6,2) CONSTRAINT refund_NN NOT NULL,
    cus_name VARCHAR2(30) CONSTRAINT cus_name_NN NOT NULL,
    refund_date DATE CONSTRAINT refund_date_NN NOT NULL,
    CONSTRAINT refund_ref_transactionNum_pk PRIMARY KEY (ref_transactionNum)
);

CREATE TABLE customer
(
    cus_name VARCHAR2(30),
    age NUMBER(2,0),
    street VARCHAR2(30),
    city VARCHAR2(30),
    postalCode CHAR(6),
    cus_phone CHAR(8),
    creditCard CHAR(2),
    CONSTRAINT customer_cus_name_pk PRIMARY KEY (cus_name)
);

ALTER TABLE customer
MODIFY
(street NOT NULL)
MODIFY
(city NOT NULL)
MODIFY
(postalcode NOT NULL)
MODIFY
(creditCard NOT NULL);


CREATE TABLE refund_transactions
(
    ref_transactionNum NUMBER(8,0),
    cus_name VARCHAR2(30),
    CONSTRAINT refund_transactions_pk PRIMARY KEY (ref_transactionNum, cus_name),
    CONSTRAINT refund_transactions_ref_transactionNum_fk FOREIGN KEY (ref_transactionNum)
        REFERENCES refund (ref_transactionNum),
    CONSTRAINT refund_transactions_cus_name_fk FOREIGN KEY (cus_name)
        REFERENCES customer (cus_name)
);

    CREATE TABLE director
    (
        dir_name VARCHAR2(30),
        CONSTRAINT director_dir_name_pk PRIMARY KEY (dir_name),
        dir_phone CHAR(8)
    );

CREATE TABLE movie
(
    title VARCHAR2(50),
    CONSTRAINT movie_title_pk PRIMARY KEY (title),
    duration NUMBER(3,0) CONSTRAINT duration_CK CHECK (duration > 0),
    year_released CHAR(4),
    ageBased_ratings CHAR(3),
    CONSTRAINT movie_ageBased_ratings_ck
    CHECK (ageBased_ratings IN ('G', 'PG', '14a', '18a', 'R')),
    directorOfMovie VARCHAR2(30),
    CONSTRAINT movie_directorOfMovie_fk FOREIGN KEY (directorOfMovie)
    REFERENCES director (dir_name)
);

    ALTER TABLE movie
MODIFY
    (duration NOT NULL)
MODIFY
    (ageBased_ratings NOT NULL);

    CREATE TABLE movie_rented
    (
        cus_name VARCHAR2(30),
        title VARCHAR2(50)
    );

    ALTER TABLE movie_rented
ADD CONSTRAINT movie_rented_pk PRIMARY KEY (cus_name, title)
    ADD CONSTRAINT movie_rented_cus_name_fk FOREIGN KEY
    (cus_name) REFERENCES customer
    (cus_name)
    ADD CONSTRAINT movie_rented_title_fk FOREIGN KEY
    (title) REFERENCES movie
    (title);


    CREATE TABLE listing
    (
        title VARCHAR2(30),
        description VARCHAR2(20),
        CONSTRAINT listing_pk PRIMARY KEY (title, description)
    );


    CREATE TABLE category
    (
        title VARCHAR(50),
        genre VARCHAR2(30)
    );

    ALTER TABLE category
ADD CONSTRAINT category_pk PRIMARY KEY (title, genre)
    ADD CONSTRAINT category_title_fk FOREIGN KEY (title) REFERENCES movie (title);

    CREATE TABLE payment
    (
        cus_name VARCHAR2(30),
        creditCard CHAR(2),
        paymentDate DATE,
        amountPaid NUMBER(6,2),
        cost NUMBER(6,2),
        pay_transactionNum NUMBER(8,0),
        CONSTRAINT payment_pay_transactionNum_pk PRIMARY KEY (pay_transactionNum),
        CONSTRAINT payment_cus_name_fk FOREIGN KEY (cus_name)
        REFERENCES customer (cus_name),
        CONSTRAINT payment_creditCard_ck
        CHECK (creditCard IN ('AX', 'MC', 'VS'))
    );

    ALTER TABLE payment
MODIFY
    (creditCard NOT NULL)
MODIFY
    (paymentDate NOT NULL)
MODIFY
    (amountPaid NOT NULL)

    CREATE TABLE rental_rates
    (
        rental_class CHAR(1),
        rental_format CHAR(2)CONSTRAINT rentalr_format_NN NOT NULL,
        price NUMBER(6,2),
        CONSTRAINT rental_rates_pk PRIMARY KEY (rental_class, rental_format)
    );

    CREATE TABLE rental
    (
        pay_transactionNum NUMBER(8,0),
        rental_class CHAR(1),
        format CHAR(2),
        cus_name VARCHAR2(30),
        title VARCHAR2(30),
        startDate DATE,
        endDate DATE,
        starRating NUMBER(1,0),
        CONSTRAINT rental_pay_transactionNum_pk PRIMARY KEY (pay_transactionNum),
        CONSTRAINT rental_pay_transactionNum_fk FOREIGN KEY (pay_transactionNum) REFERENCES payment (pay_transactionNum),
        CONSTRAINT rental_class_fk FOREIGN KEY (rental_class, format) REFERENCES rental_rates (rental_class, rental_format)
    );

    ALTER TABLE rental
ADD CONSTRAINT rental_starRating_CK CHECK (starRating between 1 and 5);

spool off
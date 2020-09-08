DROP TABLE refund CASCADE CONSTRAINTS;
DROP TABLE refund_transactions CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE movie_rented CASCADE CONSTRAINTS;
DROP TABLE movie CASCADE CONSTRAINTS;
DROP TABLE director CASCADE CONSTRAINTS;
DROP TABLE listing CASCADE CONSTRAINTS;
DROP TABLE category CASCADE CONSTRAINTS;
DROP TABLE payment CASCADE CONSTRAINTS;
DROP TABLE rental CASCADE CONSTRAINTS;
DROP TABLE rental_rates CASCADE CONSTRAINTS;

-- REFUND TABLE
CREATE TABLE refund
(
    -- create table attributes
    ref_transactionNum NUMBER(8,0),
    refund_amount NUMBER(6,2),
    cus_name VARCHAR2(30),
    refund_date DATE,
    -- ref_transactionNum PRIMARY KEY
    CONSTRAINT refund_ref_transactionNum_pk PRIMARY KEY (ref_transactionNum)
);

-- CUSTOMER TABLE
CREATE TABLE customer
(
    -- create table attributes
    cus_name VARCHAR2(30),
    age NUMBER(2,0),
    street VARCHAR2(30),
    city VARCHAR2(30),
    postalCode CHAR(6),
    cus_phone CHAR(8),
    creditCard CHAR(2),
    -- cus_name PRIMARY KEY
    CONSTRAINT customer_cus_name_pk PRIMARY KEY (cus_name),
    -- creditCard CHECK FOR AX, MC, VS
    CONSTRAINT customer_creditCard_ck
        CHECK (creditCard IN ('AX', 'MC', 'VS')),
    -- postalCode CHECK
    CONSTRAINT customer_postalCode_ck
        CHECK (REGEXP_LIKE(postalCode,'L9L9L9')),
    -- cus_phone CHECK
    CONSTRAINT customer_cus_phone_ck
        CHECK (REGEXP_LIKE(cus_phone,'999.9999'))
);

-- REFUND_TRANSACTIONS TABLE
CREATE TABLE refund_transactions
(
    -- create table attributes
    ref_transactionNum NUMBER(8,0),
    cus_name VARCHAR2(30),
    -- ref_transactionNum, cus_name PRIMARY KEY
    CONSTRAINT refund_transactions_pk PRIMARY KEY (ref_transactionNum, cus_name),
    -- ref_transactionNum FOREIGN KEY || references refund table
    CONSTRAINT refund_transactions_ref_transactionNum_fk FOREIGN KEY (ref_transactionNum)
        REFERENCES refund (ref_transactionNum),
    -- cus_name FOREIGN KEY || references customer table
    CONSTRAINT refund_transactions_cus_name_fk FOREIGN KEY (cus_name)
        REFERENCES customer (cus_name)
);

-- DIRECTOR TABLE
CREATE TABLE director
(
    -- create table attributes
    dir_name VARCHAR2(30),
    dir_phone CHAR(8),
    -- dir_name PRIMARY KEY
    CONSTRAINT director_dir_name_pk PRIMARY KEY (dir_name),
    -- dir_phone CHECK
    CONSTRAINT director_dir_phone_ck
        CHECK (REGEXP_LIKE(dir_phone, '999.9999'))
);

-- MOVIE TABLE
CREATE TABLE movie
(
    -- create table attributes
    title VARCHAR2(50),
    duration NUMBER(3,0)(duration > 0),
    year_released DATE,
    ageBased_ratings CHAR(3),
    directorOfMovie VARCHAR2(30),
    -- title PRIMARY KEY
    CONSTRAINT movie_title_pk PRIMARY KEY (title),
    -- director FOREIGN KEY
    CONSTRAINT movie_directorOfMovie_fk FOREIGN KEY (directorOfMovie)
        REFERENCES director (dir_name),
    -- age rating CHECK
    CONSTRAINT movie_ageBased_ratings_ck
        CHECK (ageBased_ratings IN ('G', 'PG', '14a', '18a', 'R'))
);

-- MOVIE_RENTED TABLE
CREATE TABLE movie_rented
(
    -- create table attributes
    cus_name VARCHAR2(30),
    title VARCHAR2(50),
    -- cus_name, title PRIMARY KEY
    CONSTRAINT movie_rented_pk PRIMARY KEY (cus_name, title),
    -- cus_name FOREIGN KEY
    CONSTRAINT movie_rented_cus_name_fk FOREIGN KEY (cus_name)
        REFERENCES customer (cus_name),
    -- title FOREIGN KEY
    CONSTRAINT movie_rented_title_fk FOREIGN KEY (title)
        REFERENCES movie (title)
)




-- LISTING TABLE
CREATE TABLE listing
(
    -- create table attributes
    title VARCHAR2(30),
    description VARCHAR2(20),
    -- title, description PRIMARY KEY
    CONSTRAINT listing_pk PRIMARY KEY (title, description)
);

-- CATEGORY TABLE
CREATE TABLE category
(
    -- create table attributes
    title VARCHAR(50),
    genre VARCHAR2(30),
    -- title, genre PRIMARY KEY
    CONSTRAINT category_pk PRIMARY KEY (title, genre),
    -- title FOREIGN KEY
    CONSTRAINT category_title_fk FOREIGN KEY (title)
        REFERENCES movie (title)
);

-- PAYMENT TABLE
CREATE TABLE payment
(
    -- create table attributes
    cus_name VARCHAR2(30),
    creditCard CHAR(2),
    paymentDate DATE,
    amountPaid NUMBER(6,2),
    cost NUMBER(6,2),
    pay_transactionNum NUMBER(8,0),
    -- pay_transactionNum PRIMARY KEY
    CONSTRAINT payment_pay_transactionNum_pk PRIMARY KEY (pay_transactionNum),
    -- cus_name FOREIGN KEY
    CONSTRAINT payment_cus_name_fk FOREIGN KEY (cus_name)
        REFERENCES customer (cus_name),
    -- cost FOREIGN KEY (?)
    CONSTRAINT payment_cost_fk FOREIGN KEY (cost)
        REFERENCES ?????? (??????)
);


-- RENTAL RATES TABLE
CREATE TABLE rental_rates
(
    -- create table attributes
    rental_class CHAR(1),
    format CHAR(2),
    price NUMBER(6,2),
    -- rental class, format PRIMARY KEY
    CONSTRAINT rental_rates_pk PRIMARY KEY (rental_class, format),
    -- price FOREIGN KEY
    CONSTRAINT rental_rates_price_fk FOREIGN KEY (price)
        REFERENCES ????? (?????)
    -- format CHECK
    CONSTRAINT rental_rates_format_ck
        CHECK (format IN ('SD', 'HD'))
);

-- RENTAL TABLE
CREATE TABLE rental
(
    -- create table attributes
    pay_transactionNum NUMBER(8,0),
    rental_class CHAR(1),
    format CHAR(2),
    cus_name VARCHAR2(30),
    title VARCHAR2(30),
    startDate DATE,
    endDate DATE,
    starRating NUMBER(1,0),
    -- pay_transactionNum PRIMARY KEY
    CONSTRAINT rental_pay_transactionNum_pk PRIMARY KEY (pay_transactionNum),
    -- pay_transactionNum FOREIGN KEY
    CONSTRAINT rental_pay_transactionNum_fk FOREIGN KEY (pay_transactionNum)
        REFERENCES payment (pay_transactionNum),
    -- rental class FOREIGN KEY
    CONSTRAINT rental_rental_class_fk FOREIGN KEY (rental_class)
        REFERENCES rental_rates (rental_class),
    -- format FOREIGN KEY
    CONSTRAINT rental_format_fk FOREIGN KEY (format)
        REFERENCES rental_rates (format)
);

COMMIT;
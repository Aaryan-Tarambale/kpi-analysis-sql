-- ================================================
-- NexMart Retail Analytics — Database Schema
-- PostgreSQL
-- ================================================

CREATE TABLE customer (
    customer_id   VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment       VARCHAR(50),
    age           INT,
    country       VARCHAR(50),
    city          VARCHAR(50),
    state         VARCHAR(50),
    postal_code   VARCHAR(10),
    region        VARCHAR(20)
);

CREATE TABLE product (
    product_id    VARCHAR(20) PRIMARY KEY,
    category      VARCHAR(50),
    sub_category  VARCHAR(50),
    product_name  VARCHAR(200)
);

CREATE TABLE sales (
    order_line    INT,
    order_id      VARCHAR(20),
    order_date    DATE,
    ship_date     DATE,
    ship_mode     VARCHAR(50),
    customer_id   VARCHAR(20) REFERENCES customer(customer_id),
    product_id    VARCHAR(20) REFERENCES product(product_id),
    sales         NUMERIC(10,4),
    quantity      INT,
    discount      NUMERIC(4,2),
    profit        NUMERIC(10,4)
);
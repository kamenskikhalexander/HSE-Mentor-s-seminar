--Создание таблицы заказов и наполнение ее данными
CREATE TABLE orders (
    order_id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    order_date TIMESTAMP NOT NULL,
    total_amount DECIMAL(20,2) NOT NULL,
    payment_status VARCHAR(20)
);

ALTER TABLE orders 
ADD INDEX idx_payment_status (payment_status) TYPE set(100) GRANULARITY 1;

ALTER TABLE orders 
ADD INDEX idx_order_date (order_date) TYPE minmax GRANULARITY 4;

INSERT INTO orders (order_id, user_id, order_date, total_amount, payment_status)
VALUES 
    (1001, 10, '2023-03-01 10:00:00', 1200.0, 'paid'),
    (1002, 11, '2023-03-01 10:05:00', 999.5, 'pending'),
    (1003, 10, '2023-03-01 10:10:00', 0.0, 'cancelled'),
    (1004, 12, '2023-03-01 11:00:00', 1450.0, 'paid'),
    (1005, 10, '2023-03-01 12:00:00', 500.0, 'paid'),
    (1006, 13, '2023-03-02 09:00:00', 2100.0, 'paid'),
    (1007, 14, '2023-03-02 09:30:00', 300.0, 'pending'),
    (1008, 15, '2023-03-02 10:00:00', 450.0, 'paid'),
    (1009, 10, '2023-03-02 10:15:00', 1000.0, 'pending'),
    (1010, 11, '2023-03-02 11:00:00', 799.0, 'paid'),
    (1011, 12, '2023-03-02 12:00:00', 120.0, 'cancelled'),
    (1012, 13, '2023-03-03 08:00:00', 2000.0, 'paid'),
    (1013, 15, '2023-03-03 09:00:00', 450.0, 'paid'),
    (1014, 15, '2023-03-03 09:30:00', 899.99, 'paid'),
    (1015, 14, '2023-03-03 10:00:00', 1350.0, 'paid'),
    (1016, 10, '2023-03-03 11:00:00', 750.0, 'pending');


--Создание таблицы товаров и наполнение ее данными
CREATE TABLE order_items (
    item_id BIGINT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_name VARCHAR(20) NOT NULL,
    product_price DECIMAL(20,2) NOT NULL DEFAULT(0),
    quantity INT
);

ALTER TABLE order_items
ADD INDEX idx_product_name (product_name) TYPE set(1000) GRANULARITY 1;

INSERT INTO order_items (item_id, order_id, product_name, product_price, quantity)
VALUES 
    (1, 1001, 'Smartphone', 600.0, 2),
    (2, 1002, 'Laptop', 999.5, 1),
    (3, 1004, 'Monitor', 300.0, 2),
    (4, 1004, 'Keyboard', 50.0, 1),
    (5, 1007, 'Mouse', 25.0, 2),
    (6, 1010, 'Laptop', 799.0, 1),
    (7, 1019, 'Laptop', 1100.0, 2),
    (8, 1020, 'Speaker', 185.5, 3),
    (9, 1009, 'Tablet', 500.0, 2),
    (10, 1011, 'PhoneCase', 20.0, 3),
    (11, 1012, 'GamingConsole', 650.0, 3),
    (12, 1013, 'Book', 15.0, 10),
    (13, 1014, 'Smartwatch', 300.0, 1),
    (14, 1015, 'Monitor', 300.0, 2),
    (15, 1015, 'Keyboard', 50.0, 1),
    (16, 1016, 'Camera', 250.0, 2);


--Агрегации

--1
SELECT payment_status, COUNT(order_id) as cnt_order, SUM(total_amount) as sum_amount, AVG(total_amount) as average_amount
FROM orders
GROUP BY payment_status;

--2
SELECT payment_status, COUNT(item_id) as cnt_items, SUM(total_amount) as total_sum, ROUND(AVG(product_price) ,2) as average_price
FROM orders o
JOIN order_items i ON i.order_id = o.order_id
GROUP BY payment_status;

--3
SELECT cast(order_date as date) AS "date", COUNT(order_id) as orders_by_date, SUM(total_amount) as amount_by_date
FROM orders
GROUP BY "date";

--4
SELECT user_id, COUNT(order_id) as orders_by_user
FROM orders
GROUP BY user_id
ORDER BY orders_by_user DESC
LIMIT 3;

SELECT user_id, SUM(total_amount) as amount_by_user
FROM orders
GROUP BY user_id
ORDER BY amount_by_user DESC
LIMIT 3;

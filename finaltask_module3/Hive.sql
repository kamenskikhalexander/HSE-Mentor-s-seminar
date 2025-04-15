--Создание таблицы логов и наполнение ее данными
CREATE TABLE logs_text (
    log_id BIGINT,
    transaction_id BIGINT,
    category VARCHAR(20),
    comment STRING,
    log_timestamp TIMESTAMP
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
TBLPROPERTIES (
    'skip.header.line.count'='1' 
);


LOAD DATA INPATH 's3a://hadoop-bucket-1/logs_v2.txt' 
INTO TABLE logs_text;


CREATE TABLE logs (
    log_id BIGINT,
    transaction_id BIGINT,
    category VARCHAR(20),
    comment STRING,
    log_timestamp TIMESTAMP
)
STORED AS ORC;


INSERT INTO TABLE logs
SELECT * FROM logs_text;


--Создание таблицы транзакций и наполнение ее данными
DROP TABLE transactions_csv
DROP TABLE transactions

CREATE TABLE transactions_csv (
    transaction_id BIGINT,
    user_id BIGINT,
    amount DECIMAL(20,2),
    currency VARCHAR(3),
    transaction_date TIMESTAMP,
    is_fraud INT
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES (
    'skip.header.line.count'='1' 
);


LOAD DATA INPATH 's3a://hadoop-bucket-1/transactions_v2.csv' 
INTO TABLE transactions_csv;


CREATE TABLE transactions (
    transaction_id BIGINT,
    user_id BIGINT,
    amount DECIMAL(20,2),
    currency VARCHAR(3),
    transaction_date TIMESTAMP,
    is_fraud BOOLEAN
)
STORED AS ORC;


INSERT INTO TABLE transactions
SELECT * FROM transactions_csv;


--Агрегации
SELECT currency, SUM(amount) as total_amount
FROM transactions
WHERE currency IN ('USD','EUR','RUB') 
GROUP BY currency
ORDER BY total_amount DESC

SELECT is_fraud ,count(*) as cnt, SUM(amount) as total_amount, AVG(amount) as average_amount
FROM transactions
GROUP BY is_fraud

SELECT cast(transaction_date as date) AS transaction_date,count(*) as cnt, SUM(amount) as total_amount, AVG(amount) as average_amount
FROM transactions
GROUP BY cast(transaction_date as date)

SELECT EXTRACT(MONTH FROM transaction_date) AS month,count(*) as cnt, SUM(amount) as total_amount, AVG(amount) as average_amount
FROM transactions
GROUP BY EXTRACT(MONTH FROM transaction_date)

SELECT t.transaction_id,count(log_id) as cnt
FROM transactions t
JOIN logs l on l.transaction_id = t.transaction_id 
GROUP BY t.transaction_id

SELECT category,count(distinct t.transaction_id) as cnt_category
FROM transactions t
JOIN logs l on l.transaction_id = t.transaction_id 
GROUP BY category
ORDER BY cnt_category Desc











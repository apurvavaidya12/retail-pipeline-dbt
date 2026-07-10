
--Till now only 3 files are uploaded into S3 bucket 
SELECT COUNT(*) FROM RAW.ORDERS;  -- count = 77343 for 3 files 2 remaining

SELECT COUNT(*) FROM GOLD.FACT_ORDER_ITEMS; -- count = 87549 for 3 files 2 remaining

SELECT MAX(order_purchase_timestamp)
FROM RAW.ORDERS;    --- max timestamp till 3 files is 2018-05-14 17:50:03.000


-------Uploaded batch_4 file to S3-------

SELECT COUNT(*) FROM RAW.ORDERS; -- count = 88392 for 2 files 1 remaining, snowpipe auto fetch data from s3 

SELECT COUNT(*)FROM orders_stream; -- count is 22098 beacause data from batch_3 & batch_4 is present as each file has 11049

-----RAN Github_Actions workflow now , checking if dbt run automatically -----------------

SELECT COUNT(*) FROM GOLD.FACT_ORDER_ITEMS; -- count = 100221 for 4 files 1 remaining

SELECT MAX(order_purchase_timestamp)
FROM GOLD.FACT_ORDER_ITEMS;    --- max timestamp till 4 files is 2018-07-12 05:34:34.000

SELECT MAX(order_purchase_timestamp)
FROM RAW.ORDERS;               --- max timestamp till 4 files is 2018-07-12 05:34:34.000

--- Both raw and gold tables max timestap is same it means pipeline worked successfully
------success------



-------Uploaded batch_5 file to S3------- (Last_file)

SELECT COUNT(*) FROM RAW.ORDERS; -- count = 99441

SELECT COUNT(*)FROM orders_stream; -- count is 33147 beacause data from batch_3,4 & batch_5 

-----RAN Github_Actions workflow now , checking if dbt run automatically -----------------

SELECT COUNT(*) FROM GOLD.FACT_ORDER_ITEMS; -- count = 112568

SELECT MAX(order_purchase_timestamp)
FROM GOLD.FACT_ORDER_ITEMS;    --- max timestamp is 2018-10-17 17:30:18.000

SELECT MAX(order_purchase_timestamp)
FROM RAW.ORDERS;               --- max timestamp is 2018-10-17 17:30:18.000

--- Both raw and gold tables max timestap is same it means pipeline worked successfully
------success------
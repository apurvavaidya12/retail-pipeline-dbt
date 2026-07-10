CREATE OR REPLACE PIPE orders_pipe
AUTO_INGEST = TRUE
AS
COPY INTO raw.orders
FROM @orders_stage/orders/
FILE_FORMAT = (FORMAT_NAME = raw.csv_standard_format);


show pipes;

SELECT SYSTEM$PIPE_STATUS('orders_pipe');

SELECT COUNT(*) FROM RAW.ORDERS; --BEFORE COUNT 33147

-- NOW UPLOADING BATCH-2 FILE IN S3 AND THEN CHECK 

SELECT COUNT(*) FROM RAW.ORDERS; --AFTER 66294

SELECT COUNT(*) FROM GOLD.FACT_ORDER_ITEMS;

--But pipeline is only half completed still gold layer silver layer don't know raw.orders has been updated we need to implement streams & tasks for WITH



SELECT *
FROM TABLE(
    INFORMATION_SCHEMA.COPY_HISTORY(
        TABLE_NAME=>'RAW.ORDERS',
        START_TIME=>DATEADD('hour',-1,CURRENT_TIMESTAMP())
    )
);
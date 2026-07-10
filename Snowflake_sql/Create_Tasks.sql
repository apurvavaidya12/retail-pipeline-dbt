-- Creating a sample tasks for understanding

CREATE OR REPLACE TASK orders_task_demo
WAREHOUSE = retail_wh
SCHEDULE = '1 MINUTE'
AS
SELECT CURRENT_TIMESTAMP;

--Enabling the stream
ALTER TASK orders_task_demo RESUME;

SHOW TASKS;

SELECT *
FROM TABLE(
    INFORMATION_SCHEMA.TASK_HISTORY(
        TASK_NAME => 'ORDERS_TASK_DEMO'
    )
);

ALTER TASK orders_task_demo SUSPEND;

--Actual tasks start here

CREATE OR REPLACE TASK orders_stream_task
WAREHOUSE = retail_wh
WHEN SYSTEM$STREAM_HAS_DATA('orders_stream')
AS
SELECT COUNT(*)
FROM orders_stream;

--Enabling the stream
ALTER TASK orders_stream_task RESUME;
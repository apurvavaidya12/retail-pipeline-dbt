USE DATABASE retail_pipeline;

USE SCHEMA raw;


--Create RAW Table

CREATE OR REPLACE TABLE raw.orders (
    order_id                        STRING,
    customer_id                     STRING,
    order_status                    STRING,
    order_purchase_timestamp        TIMESTAMP_NTZ,
    order_approved_at               TIMESTAMP_NTZ,
    order_delivered_carrier_date    TIMESTAMP_NTZ,
    order_delivered_customer_date   TIMESTAMP_NTZ,
    order_estimated_delivery_date   TIMESTAMP_NTZ
);


-- Creating a CSV FILE_FORMAT OBJECT

CREATE OR REPLACE FILE FORMAT raw.csv_standard_format
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
    NULL_IF = ('', 'NULL')
    EMPTY_FIELD_AS_NULL = TRUE
    COMPRESSION = 'AUTO';

--Copy data from S3 bucket to RAW Table

COPY INTO raw.orders
FROM @orders_stage/orders/
FILE_FORMAT = (FORMAT_NAME = 'raw.csv_standard_format');


-- check if data loaded correctly or not 

SELECT COUNT(*) FROM raw.orders;
SELECT * FROM raw.orders LIMIT 10;


---LOADING olist_order_items_dataset.csv

USE SCHEMA raw;

CREATE OR REPLACE TABLE raw.order_items (
    order_id                STRING,
    order_item_id           NUMBER,
    product_id              STRING,
    seller_id               STRING,
    shipping_limit_date     TIMESTAMP_NTZ,
    price                   NUMBER(10,2),
    freight_value           NUMBER(10,2)
);

LIST @orders_stage;

COPY INTO raw.order_items
FROM @orders_stage/order_items/
FILE_FORMAT = (FORMAT_NAME = 'raw.csv_standard_format');

SELECT COUNT(*) FROM raw.order_items;
SELECT * FROM raw.order_items LIMIT 10;

---LOADING olist_customers_dataset.csv

USE SCHEMA raw;

CREATE OR REPLACE TABLE raw.customers (
    customer_id                STRING,
    customer_unique_id         STRING,
    customer_zip_code_prefix   STRING,
    customer_city              STRING,
    customer_state             STRING
);

LIST @orders_stage;

COPY INTO raw.customers
FROM @orders_stage/customers/
FILE_FORMAT = (FORMAT_NAME = 'raw.csv_standard_format');

SELECT COUNT(*) FROM raw.customers;
SELECT * FROM raw.customers LIMIT 10;

---LOADING olist_products_dataset.csv

USE SCHEMA raw;

CREATE OR REPLACE TABLE raw.products (
    product_id                     STRING,
    product_category_name          STRING,
    product_name_lenght            NUMBER,
    product_description_lenght     NUMBER,
    product_photos_qty             NUMBER,
    product_weight_g               NUMBER,
    product_length_cm              NUMBER,
    product_height_cm              NUMBER,
    product_width_cm               NUMBER
);

LIST @orders_stage;

COPY INTO raw.products
FROM @orders_stage/products/   
FILE_FORMAT = (FORMAT_NAME = 'raw.csv_standard_format');

SELECT COUNT(*) FROM raw.products;
SELECT * FROM raw.products LIMIT 10;


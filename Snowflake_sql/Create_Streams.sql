CREATE OR REPLACE STREAM orders_stream
ON TABLE raw.orders;

SHOW STREAMS;

SELECT count(*) FROM orders_stream;
SELECT CURRENT_ROLE();

USE SCHEMA retail_pipeline.raw;

---Storage integration mentod failed so suing the direct way
-- Replace with your own AWS credentials
CREATE OR REPLACE STAGE orders_stage
  URL = 's3://retail-pipeline-apurva/'
  CREDENTIALS = (AWS_KEY_ID = '<AWS_ACCESS_KEY>' AWS_SECRET_KEY = '<AWS_SECRET_ACCESS_KEY>');

LIST @orders_stage;



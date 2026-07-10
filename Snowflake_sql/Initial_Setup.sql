-- 1. Create a warehouse (the compute engine)
CREATE WAREHOUSE retail_wh
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE;

  -- 2. Create a database
CREATE DATABASE retail_pipeline;


-- 3. Create schemas Bronze/Silver/Gold layers
USE DATABASE retail_pipeline;

CREATE SCHEMA raw;      -- Bronze
CREATE SCHEMA silver;   -- cleaned
CREATE SCHEMA gold;     -- star schema / marts
CREATE SCHEMA IF NOT EXISTS REFERENCE;   -- for seeds csv data dbt

-- 4. Set session context
USE WAREHOUSE retail_wh;
USE DATABASE retail_pipeline;
USE SCHEMA raw;
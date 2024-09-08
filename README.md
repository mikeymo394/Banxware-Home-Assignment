SETTING UP ENVIRONMENT
1. This procedure outlines the steps to complete the given home assignment. As the first step of setting up the environment was already given. A ‘www.snowflake.com’ account was created.  A database named ‘home_assignment’ was also created on the Snowflake account.
2. Open a command prompt. Go to Search in Start menu and find Command Prompt.
3. Once the Command Prompt is opened, type ‘pip install dbt-snowflake’ to install dbt (Data Built Tool) and Press Enter.
4. Verify the installing of dbt by running or typing ‘dbt --version’ into the Command Prompt.
5. The configuration given was used to create the ‘profiles.yml’ using the text document or Notepad. The content of the ‘profile.yml’ file is as follows to fit the Snowflake system:
   
   dbt_banxware_assignment:
  outputs:
    dev:
      type: SNOWFLAKE
      threads: 4
      account: <your_snowflake_account_details>
      database: <snowflake_database_name>
      user: <login-name>
      password: <yourpassword>
      schema: <your_snowflake_schema_name>
      warehouse: <compute_wh>
      role: <snowflake_role>
  target: dev
7. Using the ‘cd’ command, navigate to the 'dbt_banxware_assignment folder' and test the connection using the command ‘dbt debug’. Output is shown below with a successful connection and ‘All Check Passed!’ prompt.

2. DATA INGESTION
Load the two CSV Files (`sales.csv` and `customers.csv`) given in the data folder into Snowflake. The `sales.csv` and `customers.csv` files was placed inside the `seeds/` directory. A ‘dbt_project.yml’ file was created to define the seed files in the ‘dbt_banxware_assgnment’ folder. Details is given as follow:

name: dbt_banxware_assignment
version: '1.0.0'
config-version: 2

profile: dbt_banxware_assignment

model-paths: ["models"]
analysis-paths: ["analyses"]
test-paths: ["tests"]
seed-paths: ["seeds"]
macro-paths: ["macros"]
snapshot-paths: ["snapshots"]

target-path: "target"
clean-targets:
- "target"
- "dbt_packages"
Use the command `dbt seed` to Ingest CSV Files into the Snowflake account.

3. DATA TRANSFORMATION
The `transformed_sales_data.sql` file was created in the model folder with a text document. Details of the sql script used to create the file is given as:

with sales as (
    select 
        order_id,
        order_date,
        customer_id,
        product_id,
        product_name,
        quantity,
        price,
        order_status,
        -- Cast order_date to DATE
        cast(order_date as date) as order_date_casted,
        -- Extract year, month, day from the casted date
        extract(year from cast(order_date as date)) as order_year,
        extract(month from cast(order_date as date)) as order_month,
        extract(day from cast(order_date as date)) as order_day,
        -- Calculate total sales amount
        quantity * price as total_sales_amount
    from {{ ref('sales') }}
)

select * from sales

Run the model with the Command Prompt ‘dbt run’. 

4. DATA ANALYSIS
In answering the questions in the given task, the following sql scripts was saved in a queries folder in the dbt_banxware_assignment.
Question 1: Top 5 Products by Total Sales Amount in 2023
select 
    product_id, 
    sum(total_sales_amount) as total_sales
from RAW.transformed_sales_data
where order_year = 2023
group by product_id
order by total_sales desc
limit 5;
Saved as `Q1_top_5_products_total_sales_2023`.

Question 2: Top 5 Customers by Total Sales Amount in 2023
select 
    customer_id, 
    sum(total_sales_amount) as total_sales
from RAW.transformed_sales_data
where order_year = 2023
group by customer_id
order by total_sales desc
limit 5;

Saved as `Q2_names_top_5_customers_total_sales_2023`.

Question 3: Average Order Value for Each Month in 2023
select 
    order_month, 
    avg(total_sales_amount) as avg_order_value
from RAW.transformed_sales_data
where order_year = 2023
group by order_month
order by order_month;

Saved as `Q3_average_order_value_month_2023`.

Question 4: Customer with Highest Order Volume in October 2023
select 
    customer_id, 
    count(order_id) as order_count
from RAW.transformed_sales_data
where order_year = 2023
and order_month = 10
group by customer_id
order by order_count desc
limit 1;

Saved as ` Q4_customer_highest_order_volume_october_2023`.






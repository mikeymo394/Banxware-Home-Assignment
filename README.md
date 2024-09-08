1. **SETTING UP ENVIRONMENT**

This procedure outlines the steps to complete the given home assignment. As the first step of setting up the environment was already given. A ‘[www.snowflake.com](http://www.snowflake.com)’ account with username was created.  A database named ‘home_assignment’ was also created on the Snowflake account.

Open a command prompt. Go to Search in Start menu and find Command Prompt.

Once the Command Prompt is opened, type _‘pip install dbt-snowflake’_ to install _dbt_ (Data Built Tool) and Press Enter.

Verify the installing of _dbt_ by running or typing _‘dbt --version’_ into the Command Prompt.

The configuration given was used to create the _‘profiles.yml’_ using the text document or Notepad. The content of the _‘profile.yml’_ file is as follows to fit the Snowflake system:

_dbt_banxware_assignment:_

_outputs:_

_dev:_

_type: snowflake_

_threads: 4_

_account: <your_snowflake_account_details>_

_database: <snowflake_database_name>_  -in this project was 'home_assignment'.

_user: <login-name>_

_password: <yourpassword>_

_schema: <your_snowflake_schema_name>_

_warehouse: COMPUTE_WH –Obtained from Snowflake system_

_role: ACCOUNTADMIN –Obtained from Snowflake system_

_target: dev_

Using the _‘cd’_ command, navigate to the _'dbt_banxware_assignment'_ folder and test the connection using the command _‘dbt debug’._ Output is shown below with a successful connection and _‘All Check Passed!’_ prompt.

**2\. DATA INGESTION**

Load the two CSV Files (\`sales.csv\` and \`customers.csv\`) given in the data folder into Snowflake. The \`sales.csv\` and \`customers.csv\` files was placed inside the \`seeds/\` directory. A ‘dbt_project.yml’ file was created to define the seed files in the ‘dbt_banxware_assgnment’ folder. Details is given as follow:

_name: dbt_banxware_assignment_

_version: '1.0.0'_

_config-version: 2_

_profile: dbt_banxware_assignment_

_model-paths: \["models"\]_

_analysis-paths: \["analyses"\]_

_test-paths: \["tests"\]_

_seed-paths: \["seeds"\]_

_macro-paths: \["macros"\]_

_snapshot-paths: \["snapshots"\]_

_target-path: "target"_

_clean-targets:_

_\- "target"_

_\- "dbt_packages"_

Use the command \`dbt seed\` to Ingest CSV Files into the Snowflake account.

**3\. DATA TRANSFORMATION**

The _\`transformed_sales_data.sql_\` file was created in the model folder with a text document. Details of the model used to create the file is given as:

_with sales as (_

_select_

_order_id,_

_order_date,_

_customer_id,_

_product_id,_

_product_name,_

_quantity,_

_price,_

_order_status,_

_\-- Cast order_date to DATE_

_cast(order_date as date) as order_date_casted,_

_\-- Extract year, month, day from the casted date_

_extract(year from cast(order_date as date)) as order_year,_

_extract(month from cast(order_date as date)) as order_month,_

_extract(day from cast(order_date as date)) as order_day,_

_\-- Calculate total sales amount_

_quantity \* price as total_sales_amount_

_from {{ ref('sales') }}_

_)_

_select \* from sales_

Run the model with the Command Prompt _‘dbt run’._

**4\. DATA ANALYSIS**

In answering the questions in the given task, the following sql scripts was saved in a _queries_ folder in the _dbt_banxware_assignment_ folder.

**_Question 1: Top 5 Products by Total Sales Amount in 2023_**

_select_

_product_id,_

_sum(total_sales_amount) as total_sales_

_from RAW.transformed_sales_data_

_where order_year = 2023_

_group by product_id_

_order by total_sales desc_

_limit 5;_

Saved as \`Q1_top_5_products_total_sales_2023\`.

**_Question 2: Top 5 Customers by Total Sales Amount in 2023_**

_select_

_customer_id,_

_sum(total_sales_amount) as total_sales_

_from RAW.transformed_sales_data_

_where order_year = 2023_

_group by customer_id_

_order by total_sales desc_

_limit 5;_

Saved as \`Q2_names_top_5_customers_total_sales_2023\`.

**_Question 3: Average Order Value for Each Month in 2023_**

_select_

_order_month,_

_avg(total_sales_amount) as avg_order_value_

_from RAW.transformed_sales_data_

_where order_year = 2023_

_group by order_month_

_order by order_month;_

Saved as \`Q3_average_order_value_month_2023\`.

**_Question 4: Customer with Highest Order Volume in October 2023_**

_select_

_customer_id,_

_count(order_id) as order_count_

_from RAW.transformed_sales_data_

_where order_year = 2023_

_and order_month = 10_

_group by customer_id_

_order by order_count desc_

_limit 1;_

Saved as \` Q4_customer_highest_order_volume_october_2023\`.

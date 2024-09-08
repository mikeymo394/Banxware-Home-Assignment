
  create or replace   view home_assignment.RAW.Q1_top_5_products_total_sales_2023
  
   as (
    select 
    product_id, 
    sum(total_sales_amount) as total_sales
from home_assignment.RAW.transformed_sales_data
where order_year = 2023
group by product_id
order by total_sales desc
limit 5;
  );


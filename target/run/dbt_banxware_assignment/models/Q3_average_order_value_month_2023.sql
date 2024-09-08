
  create or replace   view home_assignment.RAW.Q3_average_order_value_month_2023
  
   as (
    select 
    order_month, 
    avg(total_sales_amount) as avg_order_value
from home_assignment.RAW.transformed_sales_data
where order_year = 2023
group by order_month
order by order_month;
  );


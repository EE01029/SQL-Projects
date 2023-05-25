         --Analyzing Motor Cycle parts sales


create table sales(order_number varchar, date date,warehouse varchar,client_type varchar,product_line varchar, quantity int,unit_price float,total float,payment varchar,payment_fee float);
copy sales(order_number,date,warehouse,client_type,product_line,quantity,unit_price,total,payment,payment_fee)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\sales.csv' delimiter ',' csv header;

--Exploring the data
select *
from sales;

--Net revenue generated across the product lines, segregating by date and warehouse
select distinct yr.product_line, yr.month, wrhouse.ware_house,wrhouse.net_revenue
from (select product_line, case when extract(month from date) ='6' then 'June' 
						  when extract(month from date)='7' then 'July' 
						  when extract(month from date)='8' then 'August'
					end as month
from sales) as yr
join (select sum.product_line as product_line, ware_house.warehouse as ware_house, sum.net_revenue as net_revenue
from (select product_line, sum(total) as net_revenue
from sales
group by product_line) as sum
join (select product_line, warehouse
from sales
order by warehouse) as ware_house on sum.product_line=ware_house.product_line) as wrhouse on wrhouse.product_line=yr.product_line
order by wrhouse.ware_house;

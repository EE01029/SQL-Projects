--Creating table and inserting data into the International_Debt table
create table international_debt(
country_name varchar, country_code varchar, indicator_name varchar, indicator_code varchar, debt float); 

COPY international_debt(country_name, country_code, indicator_name, indicator_code, debt)
FROM 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\international_debt.csv' DELIMITER ',' CSV HEADER;

/* -------------------------------------------------------------------------------------------------------------------------------------*/

--The World Bank's International Debt data
select distinct *
from international_debt;

--Finding the number of distinct countries
select distinct country_name
from international_debt
order by country_name; /*There are 124 countries*/

--Finding out the distinct debt indicators
select distinct indicator_name
from international_debt;

--Totalling the amount of debt owned by countries
select country_name, sum(debt) as total_amount_USD
from international_debt
group by country_name
order by country_name;

--Country with highest debt (in descending order)
select country_name, sum(debt) as total_amount_USD
from international_debt
group by country_name
order by total_amount_USD desc
limit 1;
/* COUNTRY WITH HIGHEST DEBT - CHINA */

--Average amount of debt across indicators
select indicator_name, avg(debt) as avg_debt_indicators
from international_debt
group by indicator_name
order by indicator_name;

--The Highest amount of principal repayments
select distinct indicator_name, sum(debt) as amount_of_repayments
from international_debt
where indicator_code in ('DT.AMT.DLXF.CD','DT.AMT.DPNG.CD')
group by indicator_name
order by amount_of_repayments desc
limit 1;
/* The highest amount of principle repayments is done on external debt, long term*/


--Most common debt indicator(s)
select indicator_name, count(indicator_name)
from international_debt
group by indicator_name
order by count(indicator_name) desc
limit 6; /*There are six most common debt indicators*/

--Country with their total debts(in desc order)
select country_name, sum(debt) as total_amount_USD
from international_debt
group by country_name
order by total_amount_USD desc;

					   


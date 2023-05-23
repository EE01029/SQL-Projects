           --What and Where are the World's Oldest Businesses--

--Create table 'businesses'
create table businesses(business varchar, year_founded int, category_code varchar, country_code varchar)
copy businesses(business, year_founded, category_code, country_code)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\businesses.csv' delimiter ',' csv header;

--Create table 'categories'
create table categories(category_code varchar, category varchar);
copy categories(category_code, category)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\categories.csv' delimiter ',' csv header

--Create table 'country_code'
create table country_code(country_code varchar, country varchar,  continent varchar);
copy country_code(country_code, country,  continent)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\countries.csv' delimiter ',' csv header		   
		   
/*--------------------------------------------------------------------------------------------------------------------------*/


--The oldest business in the world
select business, year_founded
from businesses
order by year_founded
limit 1;

--How many businesses were founded before 1000
select count(year_founded) as businesses_before_1000
from businesses
where year_founded<1000;

--Which businesses were founded before 1000
select business, year_founded
from businesses
where year_founded<1000
order by year_founded;

--Exploring the categories
select *
from categories;

--Counting the categories
select count(category) as number_of_categories
from categories;

--Oldest business by continent
select businesses.business,oldest_by_continent.continent,oldest_by_continent.year_founded
from businesses
join (select country_code.continent as continent,min(businesses.year_founded) as year_founded
from businesses
join country_code on businesses.country_code=country_code.country_code
group by country_code.continent
order by continent asc) as oldest_by_continent on businesses.year_founded=oldest_by_continent.year_founded
order by oldest_by_continent.continent;

--Joining everything for further analysis
/*Joining businesses and categories table*/
select *
from businesses
full join categories on businesses.category_code=categories.category_code;

/*joining all the tables*/
select *
from (select *
from businesses
full join categories on businesses.category_code=categories.category_code) as businesses_categories
full join country_code on businesses_categories.country_code=country_code.country_code;

--Counting categories by continent
select country_code.continent,count(businesses_categories.category) as number_of_categories_in_a_continent
from (select *
from businesses
full join categories on businesses.category_code=categories.category_code) as businesses_categories
full join country_code on businesses_categories.country_code=country_code.country_code
group by country_code.continent;

--Filtering counts by continent and category
select country_code.continent, businesses_categories.category, count(businesses_categories.category) OVER(PARTITION BY country_code.continent)
from (select *
from businesses
full join categories on businesses.category_code=categories.category_code) as businesses_categories
full join country_code on businesses_categories.country_code=country_code.country_code

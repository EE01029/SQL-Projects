                          --Analyzing American Baby Name Trends



--Creating the table 'USA_Baby_Names'
create table usa_baby_names(year int, first_name varchar, sex varchar, num int);

copy usa_baby_names(year, first_name, sex, num)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\usa_baby_names.csv' delimiter ',' header csv;

         
/*-------------------------------------------------------------------------------------------------------------------------------------------*/

--The most years at number one
select usa_baby_names.first_name,count(usa_baby_names.first_name)
from usa_baby_names
join (select year, max(num) as num
from usa_baby_names
group by year
order by year) as yr on yr.num=usa_baby_names.num
group by usa_baby_names.first_name
order by count(usa_baby_names.first_name) desc
limit 2;

--Top Male names over the years
select usa_baby_names.first_name,usa_baby_names.year
from usa_baby_names
join (select year, max(num) as num
from usa_baby_names
group by year
order by year) as yr on yr.num=usa_baby_names.num
where sex = 'M';

--Many males with same name
select first_name,sum(num) as num
from usa_baby_names
where sex='M'
group by first_name
order by first_name;

--The Olivia Expansion
select *
from usa_baby_names
where first_name='Olivia';

--Picking a baby name
--Picking a male baby name in recent years
select first_name, num as num_in_2020
from usa_baby_names
where year>2019 and sex='M'
order by num desc;

--Picking a female baby name in recent years
select first_name, num as num_in_2020
from usa_baby_names
where year>2019 and sex='M'
order by num desc;



--Top Ranked Females since 1920
select usa_baby_names.first_name,usa_baby_names.year
from usa_baby_names
join (select year, max(num) as num
from usa_baby_names
group by year
order by year) as yr on yr.num=usa_baby_names.num
where sex = 'F';

--Timeless or Trendy
select first_name,case when count(year)>80 then 'Classic'
when count(year)>50 and count(year)<=80 then 'Semi-classic'
when count(year)>20 and count(year)<=50 then 'Semi-trendy'
else 'Trendy' end as timeless_or_trendy
from usa_baby_names
group by first_name
order by first_name;

--Classic American Names
select first_name
from usa_baby_names
group by first_name
having count(year)>80
order by first_name;

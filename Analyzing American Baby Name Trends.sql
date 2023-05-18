--Creating the table 'USA_Baby_Names'
create table usa_baby_names(year int, first_name varchar, sex varchar, num int);

copy usa_baby_names(year, first_name, sex, num)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\usa_baby_names.csv' delimiter ',' header csv;

--Classic American Names 
--Male
select distinct first_name
from usa_baby_names
where sex='M'
order by first_name;

--Female
select distinct first_name
from usa_baby_names
where sex='F'
order by first_name;

--Timeless or Trendy -> MALE category
select usa_baby_names.first_name as trending_names
from usa_baby_names
join (select year, max(num) as max_num
	 from usa_baby_names
	  where sex='M'
	  group by year
	  order by year) as num_table on usa_baby_names.num=num_table.max_num
group by usa_baby_names.first_name
order by count(usa_baby_names.first_name) desc;


--Timeless or Trendy -> FEMALE category
select usa_baby_names.first_name as trending_names
from usa_baby_names
join (select year, max(num) as max_num
	 from usa_baby_names
	  where sex='F'
	  group by year
	  order by year) as num_table on usa_baby_names.num=num_table.max_num
group by usa_baby_names.first_name
order by count(usa_baby_names.first_name) desc;

--Top-Ranked female names since 1920
select usa_baby_names.first_name as top_ranked_female, num_table.year
from usa_baby_names
join (select year, max(num) as max_num
	 from usa_baby_names
	  where sex='F'
	  group by year
	  order by year) as num_table on usa_baby_names.num=num_table.max_num;

--Picking a baby name 
--Male
select usa_baby_names.first_name as most_probable_name, num_table.year
from usa_baby_names
join (select year, max(num) as max_num
	 from usa_baby_names
	  where sex='M'
	  group by year
	  order by year) as num_table on usa_baby_names.num=num_table.max_num
order by year desc;

--Female
select usa_baby_names.first_name as most_probable_name, num_table.year
from usa_baby_names
join (select year, max(num) as max_num
	 from usa_baby_names
	  where sex='F'
	  group by year
	  order by year) as num_table on usa_baby_names.num=num_table.max_num
order by year desc;

--The Olivia Expanision
select year, first_name, num, sex
from usa_baby_names
where first_name='Olivia';

--Many males with same name
select first_name, sum(num) as frequency
from usa_baby_names
where sex='M'
group by first_name
order by frequency desc;

--Top male names over the years
select usa_baby_names.first_name, num_table.year
from usa_baby_names
join (select year, max(num) as max_num
	 from usa_baby_names
	  where sex='M'
	  group by year
	  order by year) as num_table on usa_baby_names.num=num_table.max_num;

--The most years at number one -> MALE category
select usa_baby_names.first_name,count(usa_baby_names.first_name) as numberoftimes
from usa_baby_names
join (select year, max(num) as max_num
	 from usa_baby_names
	  where sex='M'
	  group by year
	  order by year) as num_table on usa_baby_names.num=num_table.max_num
group by usa_baby_names.first_name
order by count(usa_baby_names.first_name) desc
limit 1;

--The most years at number one -> FEMALE category
select usa_baby_names.first_name,count(usa_baby_names.first_name) as numberoftimes
from usa_baby_names
join (select year, max(num) as max_num
	 from usa_baby_names
	  where sex='F'
	  group by year
	  order by year) as num_table on usa_baby_names.num=num_table.max_num
group by usa_baby_names.first_name
order by count(usa_baby_names.first_name) desc
limit 1;






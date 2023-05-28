            --Analyzing NYC Public Schools Test Result Score

--Inspecting the data
select *
from schools;

--Finding missing values
select *
from schools
where percent_tested is null; 

--Schools by building code
select school_name, building_code
from schools
order by building_code;

--Best School for math
select school_name, average_math
from schools
order by average_math desc
limit 1;

--Lowest reading score
select min(average_reading) as lowest_reading_score
from schools;

--Best writing school
select school_name, average_writing
from schools
order by average_writing desc
limit 1;

--Top 10 Schools
select school_name,percent_tested
from schools
order by percent_tested desc
limit 10;

--Ranking boroughs
select distinct borough, avg(percent_tested) as avg_percent_tested
from schools
group by borough
order by avg(percent_tested) desc;

--Brooklyn Numbers
select *
from schools
where borough='Brooklyn'
					 
			



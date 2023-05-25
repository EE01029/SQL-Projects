                --Analyzing Unicorn Companies


create table companies(company_id int, company varchar, city varchar, country varchar, continent varchar);
copy companies(company_id, company, city, country, continent)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\companies.csv' delimiter ',' csv header;

create table dates(company_id int, date_joined date, year_founded int);
copy dates(company_id,date_joined,year_founded)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\dates.csv' delimiter ',' csv header;

create table funding(company_id int, valuation bigint, funding bigint, select_investors varchar);
copy funding(company_id, valuation, funding, select_investors)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\funding.csv' delimiter ',' csv header;

create table industries(company_id int, industry varchar);
copy industries(company_id, industry)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\industries.csv' delimiter ',' csv header;

/*-------------------------------------------------------------------------------------------------------*/

--Unicorn companies: Companies-->Private Startup with a valuation of more than 1 billion dollars
--Query to return all the unicorn companies
select companies.company, funding.valuation
from companies
join funding on companies.company_id = funding.company_id
where valuation>1000000000
order by funding.valuation;

--Which industry is having the Highest average valuation
select industries.industry, avg(funding.valuation) as Average_Valuation
from industries
join funding on industries.company_id=funding.company_id
group by industries.industry
order by Average_Valuation desc
limit 1;

--Unicorns which have been produced anually between 2019 and 2021
select comp.company, yr.years
from (select companies.company_id as company_id, companies.company, funding.valuation
from companies
join funding on companies.company_id = funding.company_id
where valuation>1000000000
order by funding.valuation) as comp
join (select company_id,extract( year from date_joined) as years
from dates
where extract( year from date_joined) in (2019,2020,2021)) as yr 
on yr.company_id= comp.company_id
order by yr.years;

--Number of Unicorn companies that have been produced anually from 2019 to 2021
select yr.years,count(comp.company) as number_of_unicorn_companies
from (select companies.company_id as company_id, companies.company, funding.valuation
from companies
join funding on companies.company_id = funding.company_id
where valuation>1000000000
order by funding.valuation) as comp
join (select company_id,extract( year from date_joined) as years
from dates
where extract( year from date_joined) in (2019,2020,2021)) as yr 
on yr.company_id= comp.company_id
group by yr.years;
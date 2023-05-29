      --When Was the Golden Age of Video Games

create table game_reviews(Name varchar, Critic_Score float, User_Score float);
copy game_reviews(Name, Critic_Score, User_Score)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\game_reviews (1).csv' delimiter ',' csv header;

create table game_sales(Name varchar, Platform varchar, Publisher varchar,Developer varchar, Total_Shipped float, Year int);  
copy game_sales(Name,Platform,Publisher,Developer,Total_Shipped,Year)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\game_sales (1).csv' delimiter ',' csv header;

create table top_critic_scores(year int, avg_critic_score float);
copy top_critic_scores(year, avg_critic_score)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\top_critic_scores (1).csv' delimiter ',' csv header;

create table top_critic_scors_more_than_four_games(year int, num_games int, avg_critic_score float);
copy top_critic_scors_more_than_four_games(year, num_games , avg_critic_score)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\top_critic_scores_more_than_four_games (1).csv' delimiter ',' csv header;

create table top_user_scores_more_than_four_games(year int, num_games int, avg_user_score float);
copy top_user_scores_more_than_four_games(year, num_games, avg_user_score)
from 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PostgreSQL 15\top_user_scores_more_than_four_games (1).csv' delimiter ',' csv header;


/*---------------------------------------------------------------------------------------------------------------------------------------------------------------*/


--The ten best-selling video games
select game_reviews.name, game_sales.total_shipped
from game_reviews
join game_sales on game_reviews.name=game_sales.name
order by total_shipped desc
limit 10;

--Missing review scores
select *
from game_reviews
where critic_score is null or user_score is null;

--Years that video game critics loved
select game_sales.year,avg(game_reviews.critic_score)
from game_reviews
join game_sales on game_reviews.name=game_sales.name
group by game_sales.year
having avg(game_reviews.critic_score)>9
order by year;

--Was 1982 really that great?
select avg(critic_score) as critic_score, avg(user_score) as user_score
from game_reviews;

select game_sales.year,avg(game_reviews.critic_score) as avg_critic_score, avg(game_reviews.user_score) as avg_user_score
from game_reviews
join game_sales on game_reviews.name=game_sales.name
where game_sales.year='1982'
group by game_sales.year;
/*In Year 1982, average critic score for 1982 is greater than average critic score for all years.Hence, we can say that 1982 was really great for video games */

--Years that dropped off the critic's favourite list
select game_sales.year,avg(game_reviews.critic_score)
from game_reviews
join game_sales on game_reviews.name=game_sales.name
group by game_sales.year
having avg(game_reviews.critic_score)<8
order by year;


--Years video games players loved
select game_sales.year,avg(game_reviews.user_score)
from game_reviews
join game_sales on game_reviews.name=game_sales.name
group by game_sales.year
having avg(game_reviews.user_score)>9
order by game_sales.year desc; 

--Years that both players and critics loved
select game_sales.year, avg(game_reviews.critic_score), avg(game_reviews.user_score)
from game_reviews
join game_sales on game_reviews.name=game_sales.name
group by game_sales.year
having avg(game_reviews.user_score)>9 and avg(game_reviews.critic_score)>9
order by game_sales.year desc;

--Sales in the best video games year
select game_sales.year, sum(game_sales.total_shipped) as sales
from (select game_sales.year as year, avg(game_reviews.critic_score), avg(game_reviews.user_score)
from game_reviews
join game_sales on game_reviews.name=game_sales.name
group by game_sales.year
having avg(game_reviews.user_score)>9 and avg(game_reviews.critic_score)>9
order by game_sales.year desc) as yr
join game_sales on yr.year=game_sales.year
group by game_sales.year
order by game_sales.year;




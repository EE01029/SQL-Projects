           --Optimizing Online Sports Retail Revenue

--Counting missing values
select count(product_id) as number_of_missing_values
from brands
where brand is null;  

--Deleting the missing values
delete from brands
where brand is null;

--Nike vs Addidas pricing
select brands.brand, avg(finance.listing_price) as avg_listing_price, max(finance.listing_price) as max_listing_price, min(finance.listing_price) as min_listing_price
from brands
join finance on brands.product_id=finance.product_id
group by brands.brand;

--Labelling Price Ranges
select finance.product_id,brands.brand, finance.listing_price, case when finance.listing_price<100 then 'Budget'
when finance.listing_price>=100 and finance.listing_price<=400 then 'Average'
when finance.listing_price>500 then 'Expensive' end as label
from brands
join finance on brands.product_id=finance.product_id;

--Average discount by brand
select brands.brand, avg(finance.discount)
from brands
join finance on brands.product_id=finance.product_id
group by brands.brand;

--Correlation between revenue and reviews
select finance.product_id,finance.revenue, reviews.rating, reviews.reviews
from reviews
join finance on finance.product_id=reviews.productid
order by finance.revenue desc, reviews.rating desc;


--Ratings and Reviews by product description length
select brands.brand, rev_mon.rating, rev_mon.reviews, rev_mon.mon as month
from (select reviews.productid as product_id,reviews.rating as rating, reviews.reviews as reviews,extract(month from traffic.last_visited) as month, case when extract(month from traffic.last_visited) =1 then 'January'
when extract(month from traffic.last_visited)='2' then 'February'
when extract(month from traffic.last_visited)='3' then 'March'
when extract(month from traffic.last_visited)='4' then 'April'
when extract(month from traffic.last_visited)='5' then 'May'
when extract(month from traffic.last_visited)='6' then 'June'
when extract(month from traffic.last_visited)='7' then 'July'
when extract(month from traffic.last_visited)='8' then 'August'
when extract(month from traffic.last_visited)='9' then 'September'
when extract(month from traffic.last_visited)='10' then 'October'
when extract(month from traffic.last_visited)='11' then 'November'
when extract(month from traffic.last_visited)='12' then 'December'
end as mon
from traffic
join reviews on traffic.product_id=reviews.productid) as rev_mon
join brands on brands.product_id=rev_mon.product_id;

--Footwear product performance
select footwear.product_name,finance.revenue
from (select *
from info
where description like '%shoe%' or description like '%slipper%' or description like '%trainer' or description like '%foot%' or description like '%sneaker%') as footwear
join finance on finance.product_id=footwear.product_id;


--Clothing product performance
select footwear.product_name,finance.revenue
from (select *
from info
where description not like '%shoe%' and description not like '%slipper%' and description not like '%trainer' and description not like '%foot%' and description not like '%sneaker%') as footwear
join finance on finance.product_id=footwear.product_id
where footwear.product_name not like '%Shoes%' and footwear.product_name not like '%Slippers' and footwear.product_name not like '%Flip-Flops%' and footwear.product_name not like '%Cleats%' and footwear.product_name not like '%Slides%' and footwear.product_name not like '%Sandals%' and footwear.product_name not like '%SHOES%' and footwear.product_name not like '%Boots%' and footwear.product_name not like '%Flip Flops%' and footwear.product_name not like '%BOOTS%'
and footwear.product_name not like '%CLEATS%' and footwear.product_name not like '%shoes';







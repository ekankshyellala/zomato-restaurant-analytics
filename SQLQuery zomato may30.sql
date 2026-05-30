create database zomatodata

use zomatodata

select * from zomato_cleaned

select name as 'Restaurant_Name',Round(rate,2) as 'Rating' from zomato_cleaned
order by 'Rating' desc


select Top 10 name as 'Restaurant_Name',Round(rate,2) as 'Rating' from zomato_cleaned
order by 'Rating' desc


select Top 10 name as 'Restaurant_Name',count(*) as 'Record' from zomato_cleaned
group by name
order by count(*) desc

update	zomato_cleaned
set rate = Round(rate,1)



select * from zomato_cleaned

select online_order,round(AVG(rate),2) as 'Avg rating' from zomato_cleaned
group by online_order
order by AVG(rate) desc

select name,sum(votes) as 'Tot Votes', Avg(rate) as 'Avg Rating'  from zomato_cleaned
group by name
order by sum(votes) desc, Avg(rate) desc


select listed_in_type as 'Type',count(*) as 'Res Count',Avg(approx_cost_for_two_people) as 'Avg cost per 2 person' from zomato_cleaned
group by listed_in_type
order by count(*),Avg(approx_cost_for_two_people) desc


select case 
when approx_cost_for_two_people < 300 then 'Budget'
when approx_cost_for_two_people BETWEEN 300 and 600 then 'Mid_Range'
else 'Premium'
end as 'Restaurent Segment',count(*) as 'Res count',Round(Avg(rate),2) as 'Avg Rating' from zomato_cleaned
group by 
case when approx_cost_for_two_people < 300 then 'Budget'
when approx_cost_for_two_people BETWEEN 300 and 600 then 'Mid_Range'
else 'Premium'
end
order by 'Avg Rating'  desc



with ranks as(
select listed_in_type,name,rate,RANK()over(partition by listed_in_type order by rate desc) as 'Restaurant_Rank'  from zomato_cleaned
)
select listed_in_type,name as 'Restaurant Name',Restaurant_Rank as 'Rank',rate as 'Rating' from ranks
where Restaurant_Rank <3 

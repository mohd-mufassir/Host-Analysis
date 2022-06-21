---1.Acceptance rate of hosts
select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category, acceptence as acceptance_rate, sum(acceptance_rate) as counts 
from(select host_is_superhost , case 
when host_acceptance_rate <= 20 then '0-20'
when host_acceptance_rate >= 21 and host_acceptance_rate <= 40 then '21-40'
when host_acceptance_rate >= 41 and host_acceptance_rate <= 60 then '41-60'
when host_acceptance_rate >= 61 and host_acceptance_rate <= 80 then '61-80'
when host_acceptance_rate >= 81 and host_acceptance_rate <= 100 then '81-100'
end as acceptence
, count(host_acceptance_rate) as acceptance_rate
from host_thessaloniki_df
group by host_is_superhost, host_acceptance_rate
having host_acceptance_rate > 0) as m 
group by host_is_superhost ,acceptence
order by host_is_superhost;

--Avg
select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category , round(Avg(host_acceptance_rate),2) as acceptance_rate
from host_thessaloniki_df
group by host_is_superhost;

---2.Response rate of hosts
select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category, response as response_rate, sum(response_rate) as counts 
from(select host_is_superhost , case 
when host_response_rate <= 20 then '0-20'
when host_response_rate >= 21 and host_response_rate <= 40 then '21-40'
when host_response_rate >= 41 and host_response_rate <= 60 then '41-60'
when host_response_rate >= 61 and host_response_rate <= 80 then '61-80'
when host_response_rate >= 81 and host_response_rate <= 100 then '81-100'
end as response
, count(host_response_rate) as response_rate
from host_thessaloniki_df
group by host_is_superhost, host_response_rate
having host_response_rate > 0) as m 
group by host_is_superhost ,response
order by host_is_superhost;

--Avg
select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category, round(Avg(host_response_rate),2) as response_rate
from host_thessaloniki_df
group by host_is_superhost;

---3.Acceptance rate based on response time of hosts
select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category, host_response_time as response_time, round(avg(host_acceptance_rate),2) as acceptance_rate
from host_thessaloniki_df
group by host_is_superhost, host_response_time
having count(host_response_time)>1
order by host_is_superhost;

---4.Listings under hosts which are instant bookable or not
select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category, instant_bookable, count(instant_bookable) as count_of_listings
from host_thessaloniki_df as h
join listing_thessaloniki_df as l
on h.host_id = l.host_id
group by host_is_superhost, instant_bookable;

---5.Count of hosts that has profile pic
select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category, host_has_profile_pic, count(host_has_profile_pic) as count 
from host_thessaloniki_df
group by host_is_superhost, host_has_profile_pic;

---6.Count of hosts whose identity is verified
select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category, host_identity_verified, count(host_identity_verified) as count 
from host_thessaloniki_df
group by host_is_superhost, host_identity_verified;

---7.Review score rating of listings which is under hosts
select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category, round(avg(review_scores_rating),2) as review_score_rating
from host_thessaloniki_df as h
join listing_thessaloniki_df as l
on h.host_id = l.host_id
group by host_is_superhost;

---8.Average no. of booking per month
select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category, (avg(counts)/10) as avg_bookings_per_month
from(select host_is_superhost, month(date) as months, count(date) as counts
from host_thessaloniki_df as h
join listing_thessaloniki_df as l
on h.host_id = l.host_id
join review_thessaloniki_df as r
on l.id = r.listing_id
group by host_is_superhost, month(date)) as m
group by host_is_superhost;


---9.comments varies for hosts
select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category, h.host_id, l.name, r.reviewer_name, r.comments
from host_thessaloniki_df as h
join listing_thessaloniki_df as l
on h.host_id = l.host_id
join review_thessaloniki_df as r
on l.id = r.listing_id
where r.comments like '%behaviour%'
group by h.host_is_superhost, h.host_id,l.name, r.reviewer_name, r.comments
order by host_is_superhost


---10.size of properties
select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category, l.property_type, count(l.property_type) as counts
from host_thessaloniki_df as h
join listing_thessaloniki_df as l
on h.host_id = l.host_id
group by h.host_is_superhost, l.property_type
having count(l.property_type) > 1
order by host_is_superhost, count(l.property_type)


---11.Counts of comments by keyword
select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category, sum(counts) as Comments_mentioned_Excellent_Keyword 
from(select host_is_superhost, count(r.comments) as counts
from host_thessaloniki_df as h
join listing_thessaloniki_df as l
on h.host_id = l.host_id
join review_thessaloniki_df as r
on l.id = r.listing_id
where r.comments like '%Excellent%'
group by h.host_is_superhost, h.host_id,l.name, r.reviewer_name, r.comments) as m
group by host_is_superhost;

select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category, sum(counts) as Comments_mentioned_Filthy_Keyword 
from(select host_is_superhost, count(r.comments) as counts
from host_thessaloniki_df as h
join listing_thessaloniki_df as l
on h.host_id = l.host_id
join review_thessaloniki_df as r
on l.id = r.listing_id
where r.comments like '%Filthy%'
group by h.host_is_superhost, h.host_id,l.name, r.reviewer_name, r.comments) as m
group by host_is_superhost;

select case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category, sum(counts) as Comments_mentioned_GoodHost_Keyword 
from(select host_is_superhost, count(r.comments) as counts
from host_thessaloniki_df as h
join listing_thessaloniki_df as l
on h.host_id = l.host_id
join review_thessaloniki_df as r
on l.id = r.listing_id
where r.comments like '%Good host%'
group by h.host_is_superhost, h.host_id,l.name, r.reviewer_name, r.comments) as m
group by host_is_superhost;


select top 5 case 
when host_is_superhost = 0 then 'Other Host'
when host_is_superhost = 1 then 'Super Host' end as Host_Category,l.name as listing_name, r.reviewer_name, r.comments, r.date
from host_thessaloniki_df as h
join listing_thessaloniki_df as l
on h.host_id = l.host_id
join review_thessaloniki_df as r
on l.id = r.listing_id
where r.comments like '%filthy%'
group by h.host_is_superhost,l.name, r.reviewer_name, r.comments, r.date
having host_is_superhost = 0
order by h.host_is_superhost asc

-----------------------2)1
select * 
from host_athens_df as h
join listing_athens_df as l
on h.host_id = l.host_id
join df_athens_availability as a
on l.id = a.listing_id

---for athens
select case 
when h.host_is_superhost = 0 then 'Other Host'
else 'Super Host'
end as host_is_superhost, round(avg(a.price),2) as Avg_Price_of_Listings
from host_athens_df as h
join listing_athens_df as l
on h.host_id = l.host_id
join df_athens_availability as a 
on l.id = a.listing_id
where host_is_superhost>=0 and year(a.date) = 2022
group by host_is_superhost;

select case 
when h.host_is_superhost = 0 then 'Other Host'
else 'Super Host'
end as host_is_superhost, 
case when a.available = 0 then 'Not Available'
else 'Availale'
end as Availability, 
count(a.available) as Available_listings
from host_athens_df as h
join listing_athens_df as l
on h.host_id = l.host_id
join df_athens_availability as a 
on l.id = a.listing_id
where host_is_superhost>=0 and year(a.date) = 2022
group by host_is_superhost, a.available
order by host_is_superhost;


select locations, round(avg(price),2) as Avg_Price_of_Listings
from 
(select h.host_id, a.price, a.date, case 
when h.host_location like '%athens%' then 'Local_host' 
else 'Other_Location_Host'
end as locations
from host_athens_df as h
join listing_athens_df as l
on h.host_id = l.host_id
join df_athens_availability as a 
on l.id = a.listing_id) as a
where year(a.date) = 2022
group by locations

select Host_location, case 
when a.available = 0 then 'Not Available' 
when a.available = 1 then 'Available' 
end as Availability, count(a.available) as Available_Listings
from 
(select h.host_id,  a.available, a.date, case 
when h.host_location like '%athens%' then 'Local_host' 
else 'Other_Location_Host'
end as Host_location
from host_athens_df as h
join listing_athens_df as l
on h.host_id = l.host_id
join df_athens_availability as a 
on l.id = a.listing_id) as a
where year(a.date) = 2022
group by Host_location, a.available
order by Host_location desc;

---for thessaloniki
select case 
when h.host_is_superhost = 0 then 'Other Host'
else 'Super Host'
end as host_is_superhost, round(avg(a.price),2) as Avg_Price_of_Listings
from host_thessaloniki_df as h
join listing_thessaloniki_df as l
on h.host_id = l.host_id
join df_thessaloniki_availability as a 
on l.id = a.listing_id
where host_is_superhost>=0 and year(a.date) = 2022
group by host_is_superhost;

select case 
when h.host_is_superhost = 0 then 'Other Host'
else 'Super Host'
end as host_is_superhost,
case when a.available = 0 then 'Not Available'
else 'Availale'
end as Availability,count(a.available) as Available_Listings
from host_thessaloniki_df as h
join listing_thessaloniki_df as l
on h.host_id = l.host_id
join df_thessaloniki_availability as a 
on l.id = a.listing_id
where host_is_superhost>=0 and year(a.date) = 2022
group by host_is_superhost,a.available
order by h.host_is_superhost;


select locations, round(avg(price),2) as Avg_Price_of_Listings
from 
(select h.host_id, a.price, a.available, a.date, case 
when h.host_location like '%thessaloniki%' then 'Local_host' 
else 'Other_Location_Host'
end as locations
from host_thessaloniki_df as h
join listing_thessaloniki_df as l
on h.host_id = l.host_id
join df_thessaloniki_availability as a 
on l.id = a.listing_id) as a
where year(a.date) = 2022
group by locations

select Host_location, case
when a.available = 0 then 'Not Available'
when a.available = 1 then 'Available'
end as Availability,
count(available) as Available_Listings
from 
(select h.host_id, a.price, a.available, a.date, case 
when h.host_location like '%thessaloniki%' then 'Local_host' 
else 'Other_Location_Host'
end as Host_location
from host_thessaloniki_df as h
join listing_thessaloniki_df as l
on h.host_id = l.host_id
join df_thessaloniki_availability as a 
on l.id = a.listing_id) as a
where year(a.date) = 2022
group by Host_location, a.available
order by Host_location desc;


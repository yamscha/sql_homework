use sakila;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, 
-- films starting with the letters `K` and `Q` have also soared in popularity. 
-- Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English. 

 select * from film;
 select * from language;
 
 select title from film where title like 'K%';
 
-- select title 
-- from film fi
-- where title like '%K'
 -- (select name from language lan where name='English');
 -- on lan.language_id = fi.language_id;
 
select fi.title,lan.name
from film as fi 
inner join(select name from language where name = 'English' ) lan 
on lan.language_id = fi.language_id
where fi.title like 'Q%' or fi.title like 'K%';

-- 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
   select * from film_actor;
   select * from film;
   
select actor_id,first_name from actor where actor_id in
(select film_id from film where title = 'Alone Trip');

select * from film_actor where film_id in
(select film_id from film where title = 'Alone Trip');

select *from actor;

-- 7c. You want to run an email marketing campaign in Canada, 
-- for which you will need the names and email addresses of all Canadian customers. 
-- Use joins to retrieve this information.

 select name from customer_list where country = 'Canada';
 select * from customer ;
 select * from country;
 select * from address;
 select * from city;
 
 select cus.first_name,cus.last_name,cus.email, ad.address_id,co.country
 from customer as cus
 inner join address as ad
 on cus.address_id = ad.address_id
 inner join city as ci 
 on ad.city_id = ci.city_id
 inner join country as co
 on ci.country_id = co.country_id
 where co.country ='Canada';
 
 -- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
 -- Identify all movies categorized as famiy films.

 select * from film_category;
 select * from film;
 select * from category;
 
 select fi.title,fica.category_id,ca.name
 from film as fi
 inner join film_category as fica
 on fi.film_id = fica.film_id
 inner join category as ca
 on fica.category_id = ca.category_id
 where ca.name = 'Family';
 
-- 7e. Display the most frequently rented movies in descending order
select  * from rental;
select * from inventory;
select * from film;

select customer_id from rental where rental_id = 6901;
select film_id from inventory where inventory_id = 1551; 
 
 select fi.title,inv.mycount,inv.inventory_id,inv.film_id
 from film as fi
 inner join(select inventory_id, film_id,count(film_id) as mycount from inventory group by film_id )as inv 
 on fi.film_id = inv.film_id
 -- inner join rental as re
 -- on inv.inventory_id = re.inventory_id
 order by inv.mycount desc;
 
-- 7f. Write a query to display how much business, in dollars, each store brought in.
select *from store;
select * from payment;
select * from rental;

select st.store_id,pay.total 
from store as st
inner join (select staff_id,amount, sum(amount) total from payment group by staff_id) pay
on pay.staff_id = st.manager_staff_id;

-- 7g. Write a query to display for each store its store ID, city, and country.
select *from store;
select * from city;
select * from country;
select * from address;

select st.store_id,ad.city_id
from store as st
inner join (select city_id from address) ad
on st.address_id = ad.address_id;

select store.store_id, city.city,country.country 
from store
inner join address on store.address_id= address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id;

-- 7h. List the top five genres in gross revenue in descending order.
-- (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
select * from category;
select * from film_category;
select * from inventory;
select * from payment;
select * from rental;

select re.customer_id, sum(amount),inv.inventory_id,fc.film_id ,cat.name
from rental as re
inner join payment as pay
on re.customer_id = pay.customer_id
inner join inventory as inv on re.inventory_id = inv.inventory_id
inner join film_category as fc on inv.film_id = fc.film_id
inner join category as cat on fc.category_id = cat.category_id
group by cat.category_id;

-- 8a. to create a view
create view revenue_gross as 
select cat.name, sum(amount) as gross
from payment p
join rental r
on (r.customer_id = p.customer_id)
join inventory as inv 
on (r.inventory_id = inv.inventory_id)
join film_category as fc 
on (inv.film_id = fc.film_id)
join category as cat 
on (fc.category_id = cat.category_id)
group by cat.category_id;

-- 8b. How would you display the view that you created in 8a?
select name,gross from revenue_gross where gross>=125000.00;

-- 8c.DROP VIEW revenue_gross;
drop view revenue_gross;
use sakila;

show tables;

select *from actor;

 -- 1a. Display the first and last names of all actors from the table `actor`. 

select first_name , last_name from actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`. 
select concat(first_name,' ',last_name) as ActorName from actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name,
-- "Joe." What is one query would you use to obtain this information?
select actor_id,first_name ,last_name from actor where first_name = 'Joe' ;

-- 2b. Find all actors whose last name contain the letters `GEN`:
select first_name, last_name from actor where last_name like '%GEN';

-- 2c. Find all actors whose last names contain the letters `LI`. 
-- This time, order the rows by last name and first name, in that order:
select first_name, last_name from actor where last_name like '%LI';

-- 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: 
-- Afghanistan, Bangladesh, and China:
select country_id, country from country where country IN ('Afghanistan', 'Bangladesh', 'China'); 



select * from country;

--  3a. Add a `middle_name` column to the table `actor`. 
-- Position it between `first_name` and `last_name`. Hint: you will need to specify the data type.

select * from actor;

ALTER table ACTOR
ADD middle_name varchar(40);  

alter table actor 
drop column middle_name;

ALTER table actor 
add column middle_name BLOB after first_name;

-- 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it? 
show create table address;
select * from address;

--  6a. Use `JOIN` to display the first and last names, as well as the address, 
--  of each staff member. Use the tables `staff` and `address`:

select * from staff;

select staff.first_name,staff.last_name, address.address
from staff 
inner join address on staff.address_id = address.address_id;

 -- 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. 
 -- Use tables `staff` and `payment`.
 select * from payment;

select st.first_name,st.last_name, st.staff_id, pay.mysum
from staff as st
inner join ( select staff_id,sum(amount) as mysum from payment group by staff_id) pay
ON pay.staff_id = st.staff_id;

-- 6c. List each film and the number of actors who are listed for that film. 
-- Use tables `film_actor` and `film`. Use inner join.
select * from film;
select * from film_actor;

select fi.title, fa.film_id,fa.numberof_actors
from film as fi
inner join (select film_id, count(actor_id) as numberof_actors from film_actor group by film_id) fa
on fi.film_id = fa.film_id;

select film.title,film.film_id,film_actor.actor_id
from film
inner join film_actor on film.film_id = film_actor.film_id; 

-- 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?

select * from inventory;

-- select inv.mycount
-- from inventory
-- inner join (select count(film_id) as mycount where film_id = 439 from inventory) inv
  
-- FIRST WAY 
select title,film_id from film where title = 'Hunchback Impossible' ;

select count(inventory_id)
from inventory 
where film_id = 439;

-- SECOND WAY
select count(inventory_id)
from inventory  
inner join film 
on film.film_id = inventory.film_id
where title = 'Hunchback Impossible';

-- 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. 
-- List the customers alphabetically by last name:
 select * from payment;
 select * from customer;
 
 select cus.first_name,cus.last_name,pay.total_paid
 from customer as cus
 inner join (select customer_id,sum(amount) as total_paid from payment group by customer_id) pay
 on cus.customer_id = pay.customer_id
 order by cus.last_name asc;
 
 
 
 
 
 
 
 
  	
/***************************************/
/*SECTION 2: SQL statement Fundamentals*/
/***************************************/

/*Basic Select statements */
SELECT * FROM actor;
SELECT first_name, last_name FROM actor;
SELECT actor_id FROM actor;
SELECT first_name, last_name,email
FROM customer;

/*select distinct */
SELECT * FROM film;
SELECT DISTINCT release_year FROM film;
SELECT DISTINCT rental_rate FROM film;
/*challenging question: we want to know the types of ratings movies can get in the United States and which ones we have in our database*/
SELECT DISTINCT rating FROM film;

/*SELECT WHERE*/

SELECT last_name, first_name
FROM customer
WHERE first_name ='Jamie' AND last_name = 'Rice';

SELECT customer_id,amount,payment_date
FROM payment
WHERE amount <=1 OR amount >=8;

SELECT * FROM payment
WHERE amount = 7.99;

SELECT email FROM customer
WHERE first_name = 'Nancy' AND last_name = 'Thomas';

SELECT description FROM film
WHERE title = 'Outlaw Hanky';

SELECT phone From address
WHERE address = '259 Ipoh Drive';


/*COUNT
it doesn't consider NULL values in the column*/
SELECT * FROM payment;
SELECT COUNT(*) FROM payment;
SELECT COUNT(DISTINCT (amount) ) FROM payment;

/*LIMIT
it allows you to limit the number of rows you get back after a query*/
SELECT * FROM customer
LIMIT 5;


/*ORDER BY
default is ASC*/

SELECT first_name,last_name
FROM customer
ORDER BY first_name ASC;

SELECT first_name,last_name
FROM customer
ORDER BY last_name DESC;

/*order by multiple columns*/
SELECT first_name,last_name
FROM customer
ORDER BY first_name ASC, 
last_name DESC;

/*only allow in the postgre sql, select fisrt name but order by lastname */
SELECT first_name
FROM customer
ORDER BY last_name ASC;


SELECT customer_id,amount  FROM payment
ORDER BY amount DESC
LIMIT 10;

SELECT film_id,title,release_year FROM film
ORDER BY film_id ASC
LIMIT 5;

/*between
when value>=low and value<=high, return true*/

SELECT customer_id, amount FROM payment
WHERE amount BETWEEN 8 AND 9;

SELECT customer_id, amount FROM payment
WHERE amount NOT BETWEEN 8 AND 9;

SELECT amount, payment_date FROM payment
WHERE payment_date BETWEEN '2007-02-07' AND '2007-02-15';

/*IN statement*/
SELECT customer_id, rental_id, return_date FROM rental
WHERE customer_id IN (1,2)
ORDER BY return_date DESC

SELECT customer_id, rental_id, return_date 
FROM rental
WHERE customer_id NOT IN (1,2)
ORDER BY return_date DESC

SELECT * FROM payment
WHERE amount IN(7.99,8.99);

/*Like Statement
% for matching any sequence of characters
_ for matching any single character
LIKE operator is case-sensitive
ILIKE in postgres is case-insensitive*/

SELECT first_name,last_name
FROM customer
WHERE first_name LIKE 'Jen%';

SELECT first_name,last_name
FROM customer
WHERE first_name LIKE '%y';

SELECT first_name,last_name
FROM customer
WHERE first_name LIKE '%er%';

SELECT first_name,last_name
FROM customer
WHERE first_name LIKE '_her%';

SELECT first_name,last_name
FROM customer
WHERE first_name NOT LIKE 'Jen%';

SELECT first_name,last_name
FROM customer
WHERE first_name ILIKE 'BAR%';

/*challenge: how many payment transactions were greater than $5*/
SELECT COUNT(amount) FROM payment
WHERE amount>5;

/*challenge: how many actors have a first name that starts with the letter P?*/
SELECT COUNT(*) FROM actor
WHERE first_name LIKE 'P%';

/*challenge: How many unique districts are our customers from*/
SELECT COUNT(DISTINCT (district)) FROM address;

SELECT DISTINCT (district) FROM address;

/*challenge: How many films have a rating of R and a replacement cost between $5 and $15?*/
SELECT COUNT(*) FROM film
WHERE rating = 'R'
AND replacement_cost between 5 and 15;

/*challenge: How many films have the word Truman somewhere in the title?*/
SELECT COUNT(*) FROM film
WHERE title LIKE '%Truman%';

/***************************************/
/******SECTION 3: GROUP BY statement****/
/***************************************/

/*MIN MAX SUM and AVG aggregate functions*/
SELECT ROUND(AVG (amount),2) FROM payment;

SELECT MIN (amount) FROM payment;

SELECT COUNT(amount)FROM payment
WHERE amount=0.0;

SELECT SUM(amount) FROM payment;

/*Group by*/
SELECT customer_id 
FROM payment
GROUP BY customer_id; /*this will return distic customer_id)*/

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id;

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

SELECT staff_id, COUNT(payment_id)
FROM payment
GROUP BY staff_id

SELECT staff_id, COUNT(*)
FROM payment
GROUP BY staff_id

SELECT rating, COUNT(rating) FROM film
GROUP BY rating;

SELECT rental_duration, COUNT(rental_duration)
FROM film
GROUP BY rental_duration;

SELECT rating, AVG(rental_rate)
FROM film
GROUP BY rating;

/*challenge: 
We have two staff members with staff IDs 1 and 2. We want to give a bonus to the staff member that handled the most payments.
How many payments did each staff member handle? And how much was the total amount processed by each staff.*/
SELECT staff_id, SUM(amount), COUNT(amount) FROM payment
GROUP BY staff_id;

SELECT rating,AVG(replacement_cost) 
FROM film
GROUP BY rating;

SELECT customer_id, SUM(amount)
From payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;

/*Having
sets conditions after group by*/

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM (amount) > 200;

SELECT store_id, COUNT(customer_id)
FROM customer
GROUP BY store_id
HAVING COUNT(customer_id) > 300;

SELECT rating,AVG(rental_rate) FROM film
WHERE rating IN ('R','G','PG')
GROUP BY rating
HAVING AVG(rental_rate)<3;

SELECT customer_id, COUNT(amount)
FROM payment
GROUP BY customer_id
HAVING COUNT(amount)>=40;

SELECT rating,AVG(rental_duration)
FROM film
GROUP BY rating
HAVING AVG(Rental_duration)>5;


/*Return the customer IDs of customers who have spent at least $110 with the staff member who has an ID of 2.*/
SELECT customer_id, SUM(amount)
FROM payment
WHERE staff_id =2
GROUP BY customer_id
HAVING SUM(amount)>110;

/*How many films begin with the letter J?*/

SELECT COUNT(*) FROM film
WHERE title LIKE 'J%';

/*What customer has the highest customer ID number whose name starts with an 'E' and has an address ID lower than 500?*/
SELECT customer_id,first_name,last_name FROM customer
WHERE first_name LIKE 'E%' 
AND address_id <500
ORDER BY customer_id DESC
LIMIT 1;

/***************************************/
/**********SECTION 5: JOINS*************/
/***************************************/

/*AS statement*/
SELECT payment_id AS my_payment_column
FROM payment;

SELECT customer_id, SUM(amount) AS total_spent 
FROM payment
GROUP BY customer_id;

/*Inner Join*/
SELECT customer.customer_id, 
first_name,
last_name,
email,
amount,
payment_date
FROM customer
INNER JOIN payment ON payment.customer_id =customer.customer_id
WHERE customer.customer_id = 2
ORDER BY first_name;

SELECT payment_id,amount,first_name,last_name
FROM payment
INNER JOIN staff ON payment.staff_id = staff.staff_id;
/*you can just use JOIN instead of INNER JOIN to do the JOIN*/

SELECT title, COUNT(title) AS copies_at_store1 FROM inventory
INNER JOIN film ON inventory.film_id = film.film_id
WHERE store_id = 1
GROUP BY title
ORDER BY title

SELECT film.title, language.name AS movie_langugae
FROM film
INNER JOIN language ON language.language_id = film.language_id;


SELECT film.title, language.name AS movie_langugae
FROM film
JOIN language ON language.language_id = film.language_id;

SELECT title, name AS movie_langugae
FROM film
INNER JOIN language AS lan ON lan.language_id = film.language_id;

/*remove "AS" also works, but you need to add a space*/
SELECT title, name  movie_langugae
FROM film
INNER JOIN language  lan ON lan.language_id = film.language_id;

/*LEFT OUTER JOIN*/
SELECT film.film_id, film.title, inventory_id
FROM film
LEFT OUTER JOIN inventory on inventory.film_id = film.film_id;

SELECT film.film_id, film.title, inventory_id
FROM film
LEFT OUTER JOIN inventory on inventory.film_id = film.film_id
WHERE inventory.film_id is NULL
ORDER BY film.film_id;

/*another method*/
SELECT film.film_id, film.title, inventory_id
FROM film
LEFT OUTER JOIN inventory on inventory.film_id = film.film_id
WHERE inventory_id is NULL
ORDER BY film.title;

/*UNION 
1--both queries must return the same number of columns
2--The corresponding columns in the queries must have compatible data types
3--The Union operator removes all duplicate rows unless the UNION ALL is used
use case: when you want to combine all the rows of one table and all the rows from another table*/


/****************************************/
/*****SECTION 6:Advanced SQL Commands****/
/***************************************/

/*Extract Function*/
SELECT customer_id, extract(day from payment_date) AS day
FROM payment;

SELECT SUM(amount) AS total, extract(month from payment_date) AS month
FROM payment
GROUP BY month
ORDER BY total DESC;

/*Mathematical Functions*/

SELECT customer_id + rental_id AS new_id 
FROM payment;

SELECT round(AVG(amount),2)
FROM payment;

/*String Function and Operator*/
SELECT first_name || ' ' ||last_name AS full_name
FROM customer;

SELECT first_name,char_length(first_name)
FROM customer;

SELECT first_name,upper(first_name)
FROM customer;

/*subquery*/
/*two query*/
SELECT AVG(rental_rate) FROM film;

SELECT title,rental_rate
FROM film
WHERE rental_rate > 2.98

/*one step query*/
SELECT film_id,title,rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate)FROM film);

SELECT inventory.film_id
FROM rental
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
WHERE
return_date BETWEEN '2005-05-29' AND '2005-05-30';


SELECT film_id,title
FROM film
WHERE film_id IN
(SELECT inventory.film_id
FROM rental
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
WHERE
return_date BETWEEN '2005-05-29' AND '2005-05-30');

/*Self Join*/

SELECT a.customer_id, a.first_name, a.last_name, b.customer_id,b.first_name,b.last_name
FROM customer AS a, customer AS b
WHERE a.first_name = b.last_name;

/*Another way to write self join*/
SELECT a.customer_id, a.first_name, a.last_name, b.customer_id,b.first_name,b.last_name
FROM customer AS a
JOIN customer AS b
ON a.first_name = b.last_name
ORDER BY a.customer_id;

SELECT a.customer_id, a.first_name, a.last_name, b.customer_id,b.first_name,b.last_name
FROM customer AS a
LEFT JOIN customer AS b
ON a.first_name = b.last_name
ORDER BY a.customer_id;

/****************************************/
/*****SECTION 7:Assessment Test 2*******/
/***************************************/
SELECT * FROM cd.bookings;



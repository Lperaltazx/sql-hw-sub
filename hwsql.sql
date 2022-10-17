-- 1. List all customers who live in Texas (use JOINs)
SELECT customer_id, first_name, last_name
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name

SELECT payment_id, first_name, last_name
FROM payment
LEFT JOIN customer
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries)

SELECT customer.first_name, customer.last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
    GROUP BY customer_id
	HAVING SUM(amount) >= 175
	);

-- 4. List all customers that live in Nepal (use the city table)

SELECT customer.customer_id, customer.first_name, customer.last_name, 
country.country
FROM customer
JOIN address
ON address.address_id = customer.address_id
JOIN city
ON city.city_id = address.city_id
JOIN country
ON country.country_id = city.country_id
WHERE country.country = 'Nepal';

-- 5. Which staff member had the most transactions?

SELECT staff.staff_id, staff.first_name, staff.last_name, COUNT(payment_id)
FROM staff
JOIN payment
ON payment.staff_id = staff.staff_id
GROUP BY staff.staff_id
HAVING COUNT(payment_id) = (
	select MAX(count_id) as highest_count
	from (
		select staff_id, count(payment_id) as count_id
		from payment
		group by staff_id
	) t )

-- 6. How many movies of each rating are there?

SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

SELECT customer.first_name, customer.last_name
FROM customer
JOIN payment
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99
GROUP BY customer.customer_id

-- 8. How many free rentals did our stores give away?

SELECT COUNT(payment.amount)
FROM payment
WHERE amount = 0.00;
USE sakila

-- 1. In the table actor, which are the actors whose last names are not repeated? For example if you would sort the data in 
-- the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. 
-- These three actors have the same last name. So we do not want to include this last name in our output. 
-- Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.

SELECT last_name  FROM actor
GROUP BY last_name
HAVING (COUNT(last_name) = 1)
ORDER BY last_name;

-- 2. Which last names appear more than once? We would use the same logic as in the previous question but this time we 
-- want to include the last names of the actors where the last name was present more than once

SELECT last_name  FROM actor
GROUP BY last_name
HAVING (COUNT(last_name) > 1)
ORDER BY last_name;

-- 3. Using the rental table, find out how many rentals were processed by each employee.

SELECT staff_id, COUNT(rental_id) AS num_of_rentals FROM rental
GROUP BY staff_id;

-- 4. Using the film table, find out how many films were released each year.

SELECT release_year, COUNT(film_id) AS num_of_films FROM film
GROUP BY release_year;

-- 5. Using the film table, find out for each rating how many films were there.

SELECT rating, COUNT(film_id) AS num_of_films FROM film
GROUP BY rating;

-- 6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places

SELECT rating, round(AVG(length),2) AS mean_duration FROM film
GROUP BY rating;

-- 7. Which kind of movies (rating) have a mean duration of more than two hours?

SELECT rating, round(AVG(length),2) AS mean_duration FROM film
GROUP BY rating
HAVING mean_duration > 120;

-- 8. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select 
-- the columns title, length, and the rank.

SELECT title, length, rank() OVER (PARTITION BY length ORDER BY title) as "rank"
FROM film
WHERE (length <> 0) AND (length IS NOT NULL);

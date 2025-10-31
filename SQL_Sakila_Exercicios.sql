USE sakila;
-- 1. Liste todos os filmes que já foram alugados.
SELECT DISTINCT film.film_id, film.title FROM rental 
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film on inventory.film_id = film.film_id;
-- 2. Quantos filmes foram alugados e não foram devolvidos.
SELECT COUNT(*) FROM rental
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film on inventory.film_id = film.film_id
WHERE rental.return_date IS NULL;
-- 3. Quais atores têm o primeiro nome ‘Helen’.
SELECT * FROM actor WHERE first_name = 'Helen';
-- 4. Quais atores têm o sobrenome ‘Fawcett’.
SELECT * FROM actor WHERE last_name = 'Fawcett';
-- 5. Lista de todos os filmes.
SELECT * FROM film ORDER BY film.title;
-- 6. Quantos sobrenomes de atores distintos existem.
SELECT last_name,COUNT(last_name) AS same_last_name FROM actor GROUP BY last_name; 
-- 7. Quais sobrenomes não se repetem (utilize count e having).
SELECT last_name,COUNT(last_name) FROM actor GROUP BY last_name HAVING COUNT(last_name) = 1; 
-- 8. Quais sobrenomes aparecem mais de uma vez (utilize count e having).
SELECT last_name,COUNT(last_name) FROM actor GROUP BY last_name HAVING COUNT(last_name) > 1; 
-- 9. Qual ator apareceu mais em filmes (count e limit).
SELECT actor.first_name, COUNT(film.film_id) FROM film 
INNER JOIN film_actor ON film.film_id=film_actor.film_id
INNER JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY actor.actor_id ORDER BY COUNT(film.film_id) DESC LIMIT 1;
-- 10. Qual é o tempo médio de exibição de todos os filmes.
SELECT AVG(length) FROM film;
-- 11. Qual o tempo médio de exibição dos filmes por categoria.
SELECT category.name,AVG(film.length) FROM film 
INNER JOIN film_category ON film_category.film_id = film.film_id
INNER JOIN category ON category.category_id = film_category.category_id
GROUP BY category.name ORDER BY category.name;
-- 12. Lista o título de todos os filmes.
SELECT film.title FROM film;
-- 13. Lista de filmes com duração menor do que 60 minutos (campo length).
SELECT film.title, length FROM film WHERE length < 60;
-- 14. Lista dos clientes inativos (Campo active).
SELECT first_name AS clientes_inativos FROM customer WHERE active = 0;
-- 15. Lista dos clientes ativos e respetivos endereços.
SELECT first_name AS clientes_ativos, address.address FROM customer 
INNER JOIN address ON address.address_id = customer.address_id
WHERE active = 1
GROUP BY customer.first_name ORDER BY customer.first_name;
-- 16. Lista dos nomes dos clientes residentes no Canada.
SELECT customer.first_name, country.country FROM customer 
INNER JOIN address ON address.address_id = customer.address_id
INNER JOIN city ON city.city_id = address.city_id
INNER JOIN country ON country.country_id = city.country_id
WHERE country.country = 'Canada'
GROUP BY customer.first_name ORDER BY customer.first_name;
-- 17. Número de clientes ativos por país.
SELECT COUNT(customer.first_name), country.country FROM customer 
INNER JOIN address ON address.address_id = customer.address_id
INNER JOIN city ON city.city_id = address.city_id
INNER JOIN country ON country.country_id = city.country_id
WHERE active = 1
GROUP BY country.country ORDER BY country.country;
-- 18. Relação de filmes e atores que atuaram no mesmo filme.
SELECT film.title, actor.first_name FROM film
INNER JOIN film_actor ON film_actor.film_id = film.film_id
INNER JOIN actor ON actor.actor_id = film_actor.actor_id;
-- 19. Relação de filmes e atores que atuaram no mesmo filme ordenada por filme.
SELECT film.title, actor.first_name FROM film
INNER JOIN film_actor ON film_actor.film_id = film.film_id
INNER JOIN actor ON actor.actor_id = film_actor.actor_id
ORDER BY film.title;
-- 20. Relação de filmes e atores que atuaram no mesmo filme ordenada por ator.
SELECT film.title, actor.first_name FROM film
INNER JOIN film_actor ON film_actor.film_id = film.film_id
INNER JOIN actor ON actor.actor_id = film_actor.actor_id
ORDER BY actor.first_name;
-- 21. Relação de filmes com participação de um ator específico (ex: last_name=Chase).
SELECT film.title, actor.first_name, actor.last_name FROM film
INNER JOIN film_actor ON film_actor.film_id = film.film_id
INNER JOIN actor ON actor.actor_id = film_actor.actor_id
WHERE actor.last_name = "Chase"
ORDER BY film.title;
-- 22. Quantidade total de filmes.
SELECT COUNT(film.title) FROM film;
-- 23. Duração média dos filmes (length).
SELECT AVG(film.length) FROM film;
-- 24. Lista de filmes por categoria.
SELECT category.name, film.title FROM film 
INNER JOIN film_category ON film_category.film_id = film.film_id
INNER JOIN category ON category.category_id = film_category.category_id
ORDER BY category.name;
-- 25. Quantidade de filmes por categoria.
SELECT category.name,COUNT(film.film_id) FROM film 
INNER JOIN film_category ON film_category.film_id = film.film_id
INNER JOIN category ON category.category_id = film_category.category_id
GROUP BY category.name ORDER BY category.name;
-- 26. Duração média dos filmes por categoria.
SELECT category.name, AVG(film.length) FROM film 
INNER JOIN film_category ON film_category.film_id = film.film_id
INNER JOIN category ON category.category_id = film_category.category_id
GROUP BY category.name ORDER BY category.name;
-- 27. Quantidade de filmes por categoria das categorias com menos de 60 filmes.
SELECT category.name,COUNT(film.film_id) FROM film 
INNER JOIN film_category ON film_category.film_id = film.film_id
INNER JOIN category ON category.category_id = film_category.category_id
GROUP BY category.name HAVING COUNT(film.film_id) < 60 ORDER BY category.name;
-- 28. Duração média dos filmes por categoria das categorias com mais de 50 filmes. 
SELECT category.name, AVG(film.length) FROM film 
INNER JOIN film_category ON film_category.film_id = film.film_id
INNER JOIN category ON category.category_id = film_category.category_id
GROUP BY category.name HAVING COUNT(category.name) > 50 ORDER BY category.name;
-- 29. Quantidade de filmes alugados por cliente.
SELECT customer.first_name,COUNT(rental_id) FROM payment 
INNER JOIN customer ON customer.customer_id = payment.customer_id
GROUP BY customer.first_name ORDER BY customer.first_name;
-- 30. Quantidade de filmes alugados por cliente em ordem decrescente de quantidade de filmes alugados.
SELECT customer.first_name,COUNT(rental_id) FROM payment 
INNER JOIN customer ON customer.customer_id = payment.customer_id
GROUP BY customer.first_name ORDER BY COUNT(rental_id) DESC;
-- 31. Relação de nomes dos clientes que possuem um filme alugado no momento.
SELECT customer.first_name,rental.return_date FROM customer 
INNER JOIN rental ON customer.customer_id = rental.customer_id
WHERE rental.return_date IS NULL
ORDER BY customer.first_name;
-- 32. Relação de nomes dos clientes que não possuem um filme alugado no momento. 
SELECT customer.first_name,rental.return_date FROM customer 
INNER JOIN rental ON customer.customer_id = rental.customer_id
WHERE rental.return_date IS NOT NULL
ORDER BY customer.first_name;
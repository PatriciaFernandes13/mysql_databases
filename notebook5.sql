USE sakila;
SELECT * FROM country;
SELECT UCASE(country) FROM country; -- coloca todos os paises em letra maiuscula
SELECT COUNT(*) FROM customer; -- PARA CONTAR O NUMERO DE CLIENTES
SELECT * FROM inventory;
-- conta os filmes e mostra id e titulo do filme
SELECT inventory.film_id, film.title, COUNT(inventory.film_id) FROM inventory INNER JOIN film on inventory.film_id=film.film_id GROUP BY inventory.film_id;
	-- ordenar por contagem de filmes em stock
SELECT inventory.film_id, film.title, COUNT(inventory.film_id) FROM inventory INNER JOIN film on inventory.film_id=film.film_id GROUP BY inventory.film_id ORDER BY COUNT(inventory.film_id);

SELECT amount, CEIL(amount), FLOOR(amount) FROM payment; -- ceil arredonda a cima e floor a baixo

-- listar quanto fatura um funcionario
SELECT SUM(payment.amount), CONCAT(staff.first_name," ",staff.last_name) FROM payment INNER JOIN staff ON payment.staff_id=staff.staff_id GROUP BY staff.staff_id, store_id;

-- saber quantos filmes foram alugados (pagos) por cliente
SELECT CONCAT(customer.first_name," ",customer.last_name), COUNT(rental_id) FROM payment INNER JOIN customer ON payment.customer_id=customer.customer_id GROUP BY payment.customer_id;
	-- qual a soma e a media dos alugueres
SELECT CONCAT(customer.first_name," ",customer.last_name), COUNT(rental_id), SUM(payment.amount), AVG(payment.amount) FROM payment INNER JOIN customer ON payment.customer_id=customer.customer_id GROUP BY payment.customer_id;

-- ADICIONAR UM dia 
SELECT payment_date, ADDDATE(payment_date,1) FROM payment;
-- ADICIONAR um periodo de tempo
SELECT payment_date, ADDTIME(payment_date,"1:10:30") FROM payment;
-- cALCULA DIFERENÇA ENTRE 2 DATAS em dias
SELECT payment_date, DATEDIFF(payment_date,"2025-10-16") FROM payment;
SELECT payment_date, DATEDIFF(payment_date,CURDATE()) FROM payment; -- CURDATE = DATA ATUAL
SELECT payment_date, DATE_FORMAT(payment_date,"%m") FROM payment; -- FORMATO DA DATA %m mes com numero %M mes por extenso
SELECT payment_date, DATE_FORMAT(payment_date,"%d") FROM payment; -- FORMATO DA DATA dia
SELECT payment_date, DATE_FORMAT(payment_date,"%Y") FROM payment; -- FORMATO DA DATA ano
SELECT payment_date, DATE_FORMAT(payment_date,"%d de %M de %Y") FROM payment; -- FORMATO DA DATA ano

-- DAYOFWEEK
SELECT payment_date, DAYOFWEEK(payment_date) FROM payment; -- Mostra os valores do dia da semana (Domingo tem o valor 1)
-- DAYOFYEAR (vai buscar o dia do ano)
SELECT payment_date, DAYOFYEAR(payment_date) FROM payment;
-- WEEKOFYEAR (vai buscar a semana do ano)
SELECT payment_date, WEEKOFYEAR(payment_date) FROM payment;
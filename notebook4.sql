USE employees;
SELECT employees.first_name, employees.gender, titles.title
	FROM employees INNER JOIN titles ON employees.emp_no=titles.emp_no;
    
 -- Salario de cada trabalhador
 SELECT employees.first_name, salaries.salary, salaries.to_date
	FROM employees INNER JOIN salaries ON employees.emp_no=salaries.emp_no
    WHERE salaries.to_date='9999-01-01';

USE sakila;
SELECT address_id, address, CHAR_LENGTH(postal_code) FROM address;  -- MOSTRA O Nº DE CARACTERES DO CODIGO POSTAL
SELECT address_id, address, postal_code FROM address WHERE CHAR_LENGHT(postal_code) <> 5;  -- MOSTRA os CODIGOs POSTAL que não tem 5 caracteres

-- CONCAT
SELECT CONCAT(first_name, ' ', last_name) FROM actor; -- tem de ter ' ' para dar espaço entre os nomes

-- INSTR
SELECT first_name, INSTR(first_name, 'e') AS "Posição do 1º e" FROM actor; -- 

-- LCASE e UCASE
SELECT LCASE(first_name) FROM actor; -- Apresenta os nomes em letra minúscula
SELECT UCASE(first_name) FROM actor; -- Apresenta os nomes em letra maiúscula

-- LEFT
SELECT LEFT(first_name, 5) FROM actor; -- Apresenta as primeiras 5 letras do nome
SELECT address_id, last_update FROM address;
SELECT address_id, LEFT(last_update, 10) FROM address;
SELECT address_id, LEFT(last_update, 10) AS 'Data' FROM address; -- Extrai 10 caracteres a partir da esquerda
SELECT address_id, LEFT(last_update, 10) AS 'Data' FROM address WHERE address_id>150;
 
-- REPLACE
SELECT first_name, last_name FROM customer WHERE last_name='smith';
SELECT first_name, REPLACE(first_name, 'MARY', 'Maria'), last_name FROM customer WHERE last_name='smith'; -- Troca o nome Mary - Maria (TENHO DE ESCREVER O NOME ANTERIOR COM MAIÚSCULAS)

-- RIGHT
SELECT first_name, RIGHT(first_name, 3) FROM actor; -- Extrai 3 caracteres a partir da direita
 
-- SUBSTR
SELECT first_name, SUBSTR(first_name, 2, 3) FROM actor; -- Extrai string a partir de 2 índices - início e fim (2 - a partir do segundo caracter; 3 - nº de caracteres (3))
 
-- Extrair a primeira palavra do título dos filmes
	-- 1. Procurar a posição do espaço
SELECT title, INSTR(title, ' ') FROM film; -- Extrai os caracteres da primeira palavra mais o espaço
    -- 2. Selecionar apenas o primeiro nome do título do filme
SELECT LEFT(title, INSTR(title, ' ')-1) FROM film; -- Extrai apenas a primeira palavra 
		-- (-1 porque o ' ' atibui o espaço, ou seja um caracter a mais. Por isso, se eu pedisse para mostrar os filmes com nome 'Academy' não iria aparecer nada
		-- Teria de escrever 'Academy ' (o com o espaço no fim). Assim com o -1, remove o espaço
-- Retornar a última palavra do título do filme
SELECT RIGHT(title, CHAR_LENGTH(title)-INSTR(title, ' ')) FROM film; -- Extrai a última palavra do título SE SÓ TIVER 2 PALAVRAS OU MOSTRAR A PARTIR DA 2ª PALAVRA
    -- Tem de se fazer substituição do numero de caracteres do titulo completo e a primeira palavra mais o espaço ' '
    
SELECT country_id, UCASE(country) FROM countries;
    
-- Contar filmes agrupados por rental_duration
SELECT rental_duration, COUNT(rental_duration) FROM film GROUP BY rental_duration;

-- Listar o nome do filme e a categoria
SELECT film.title, category.name FROM film 
	INNER JOIN film_category ON film.film_id=film_category.film_id
	INNER JOIN category ON film_category.category_id=category.category_id;
-- Quantos filmes existem de cada categoria?
SELECT category.name, COUNT(film.film_id) FROM film 
	INNER JOIN film_category ON film.film_id=film_category.film_id
	INNER JOIN category ON film_category.category_id=category.category_id
    GROUP BY category.name;
-- Listar filmes de animação que começam por 'Z'
SELECT film.title, category.name FROM film
	INNER JOIN film_category ON film.film_id=film_category.film_id
	INNER JOIN category ON film_category.category_id=category.category_id
    WHERE category.name='Animation' AND title LIKE 'Z%';
-- Litar filmes e respetivos atores
SELECT film.title, actor.first_name FROM film
	INNER JOIN film_actor ON film.film_id=film_actor.film_id
	INNER JOIN actor ON film_actor.actor_id=actor.actor_id
    ORDER BY film.title;
-- Quantos atores tem cada filme
SELECT film.title, COUNT(actor.first_name) FROM film
	INNER JOIN film_actor ON film.film_id=film_actor.film_id
	INNER JOIN actor ON film_actor.actor_id=actor.actor_id
    GROUP BY film.title;
-- Quantos filmes tem cada ator
SELECT film.title, COUNT(actor.first_name) FROM film
	INNER JOIN film_actor ON film.film_id=film_actor.film_id
	INNER JOIN actor ON film_actor.actor_id=actor.actor_id
    GROUP BY actor.first_name;
-- Média de duração dos filmes por categria
SELECT AVG(film.length), FORMAT(AVG(film.length), 2), category.name FROM film
		INNER JOIN film_category ON film.film_id=film_category.film_id
		INNER JOIN category ON  film_category.category_id=category.category_id GROUP BY category.name;
 -- Quanto é que cada uma das pessoas faturou
SELECT CONCAT(staff.first_name, ' ', staff.last_name), SUM(payment.amount) FROM staff
	INNER JOIN payment ON staff.staff_id=payment.staff_id GROUP BY staff.staff_id;    
-- Média
SELECT CONCAT(staff.first_name, ' ', staff.last_name), SUM(payment.amount) AS Total, AVG(payment.amount) FROM staff
	INNER JOIN payment ON staff.staff_id=payment.staff_id GROUP BY staff.staff_id;

USE employees

SELECT * FROM department;

SELECT COUNT(*) FROM departments;

SELECT * FROM employees;

-- Selecionar os colaboradores a partir do numero 10009
SELECT * FROM employees WHERE emp_no >10009;

-- Selecionar os colaboradores que nasceram após 01-01-1960
SELECT * FROM employees WHERE birth_date > '1960-01-01';

-- Saber quantos colaboradores nasceram após 01-01-1960
SELECT COUNT(*) FROM employees WHERE birth_date > '1960-01-01';


SELECT * FROM salaries;
-- selecionar salários atuais
SELECT * FROM salaries WHERE to_date='9999-01-01';
-- média dos salaríos atuais
SELECT AVG(salary) FROM salaries WHERE to_date='9999-01-01';
-- média dos salaríos em 1987
SELECT AVG(salary) FROM salaries WHERE from_date >= '1987-01-01' AND FROM_date >= '1987-12-31';
-- maior salario atual
SELECT MAX(salary) FROM salaries WHERE to_date = '9999-01-01';
-- selecionar salários entre 12500 e 17500
SELECT * FROM salaries WHERE salary BETWEEN 12500 and 17500;


SELECT * FROM employees;
-- selecionar colaboradores com sobrenome Faccelo
SELECT * FROM employees WHERE last_name = 'Facello';
-- selecionar colaboradores com sobrenome a começar por 'F'
SELECT * FROM emplyees WHERE last_name LIKE 'F%';
-- selecionar colaboradores com sobrenome a terminar por 'I'
SELECT * FROM emplyees WHERE last_name LIKE '%i';
-- selecionar colaboradores com sobrenome com a letra 'K'
SELECT * FROM emplyees WHERE last_name LIKE '%k%';
-- selecionar colaboradores com sobrenome Faccelo e Peak
SELECT * FROM employees WHERE last_name = ('Facello', 'Peak');
-- selecionar colaboradores com sobrenome Faccelo e Peak do sexo femenino e nasceu no ano 1962
SELECT * FROM employees WHERE last_name = ('Facello', 'Peak') AND gender='F' AND birth_date BETWEEN '1962-01-01' AND '1962-12-31';
-- alterou o nome das colunas
SELECT first_name AS Primeiro_nome, birth_date as Data_Nascimento FROM employees;
-- conta quantas pessoas tem o sobrenome 'Peak'
SELECT COUNT(last_name) FROM employees WHERE last_name = 'Peak';


SELECT * FROM titles;
-- selecionar os colaboradores com a palavra engeneer no title
SELECT * FROM titles WHERE title LIKE '%Engineer%';
-- selecionar os colaboradores atuais com a palavra engeneer no title
SELECT * FROM titles WHERE title LIKE '%Engineer%' AND to_date = '9999-01-01';


-- UTILIZAR O GROUP BY
SELECT gender AS 'genero', COUNT(gender) AS 'contagem' FROM employees GROUP BY gender; -- tabela com os tipos de genero e o numero de cada genero
-- contar o nº de colaboradores agrupados por sobrenome
SELECT last_name AS Sobrenome, COUNT(last_name) AS Contagem FROM employees GROUP BY lastname;
-- contar o nº de colaboradores cujo sobrenome comece com 'K' e agrupados por sobrenome
SELECT last_name AS Sobrenome, COUNT(last_name) AS Contagem FROM employees WHERE last_name LIKE 'K%' GROUP BY lastname;
-- contar o nº de colaboradores cujo sobrenome comece tenha a segunda letra 'k' e a quarta 'a' ' e agrupados por sobrenome
SELECT last_name AS Sobrenome, COUNT(last_name) AS Contagem FROM employees WHERE last_name LIKE '_k_a%' GROUP BY lastname;

-- HAVING
SELECT hire_date, COUNT(hire_date) FROM employees GROUP BY hire_date; -- conta o nº de pessoas contratadas por datas
SELECT hire_date, COUNT(hire_date) FROM employees GROUP BY hire_date HAVING COUNT (hire_date)>50; -- conta o nº de pessoas contratadas por datas e mostra as que tem mais de 50 pessoas
SELECT hire_date, COUNT(hire_date) FROM employees GROUP BY hire_date HAVING COUNT (hire_date)>50 ORDER BY hire_date DESC; -- ORDENAR DE ORDEM DECRESCENTE
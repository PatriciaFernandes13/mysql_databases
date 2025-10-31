USE employees;
SELECT * FROM EMPLOYEES;
SELECT * FROM employees WHERE emp_no>11500; -- seleciona os numeros maiores que 11500
SELECT * FROM employees WHERE emp_no>11500 AND emp_no<11600; -- seleciona um range de datas
SELECT * FROM employees WHERE emp_no>11500 OR emp_no<11600; -- seleciona os 2 numeros com 11500 e 11600
SELECT * FROM titles ORDER BY title DESC; -- ordena os titulos 
SELECT * FROM departments LIMIT 5; -- apresenta os 5 primeiros departamentos (podem ser repetidos)
SELECT COUNT(*) FROM departments; -- conta o nº de departamentos
SELECT * FROM employees; -- apresenta os 5 primeiros departamentos (podem ser repetidos)
SELECT COUNT(*) FROM emplyees WHERE gender='M'; -- conta o nº de empregados com sexo masculino
SELECT COUNT(*) FROM salaries WHERE to_date='9999-01-01'; -- conta o nº de empregados com salarios nesta data
SELECT * FROM salaries WHERE to_date='9999-01-01'; -- listar salarios atuais de cada trabalhador
SELECT * FROM emplyees WHERE last_name='Facello'; -- listar empregados com o sobrenome Facello
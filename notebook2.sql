CREATE TABLE clientes (
	Código INT PRIMARY KEY, 
    Nome VARCHAR(50), 
    Idade INT, 
    Morada VARCHAR(30),
    Localidade VARCHAR(20)
);
INSERT INTO clientes (código,nome,idade,morada,localidade) VALUES (1,'Rui',40,'Rua','Braga');
INSERT INTO clientes (código,nome,idade,morada,localidade) VALUES (2,'Ana',20,'Avenida','Braga');
SELECT * FROM clientes;
--
CREATE TABLE fatura (
	id INT AUTO_INCREMENT PRIMARY KEY,
    valor INT NOT NULL,
    ativo BOOLEAN NOT NULL
);
INSERT INTO fatura (id,valor,ativo) VALUE (1,50,FALSE);
INSERT INTO fatura (id,valor,ativo) VALUE (2,150,TRUE);
SELECT * FROM fatura;
-- Exercicio 7
CREATE TABLE produtos (
	id INT PRIMARY KEY,
    marca VARCHAR(15)
);
INSERT INTO produtos VALUES(1,'DELL');
INSERT INTO produtos VALUES(2,'HP');
INSERT INTO produtos VALUES(3,'Toshiba');
SELECT * FROM produtos;
-- Exercicio 8
CREATE TABLE alunos (
	id INT PRIMARY KEY,
    nome VARCHAR(15),
    data_nascimento DATE,
    data_inscrição DATETIME
);
INSERT INTO alunos VALUES(1,'Ana','1999/10/14','2025/09/25');
INSERT INTO alunos VALUES(2,'Rita','1997/09/12','2023/08/23');
INSERT INTO alunos VALUES(3,'Anita','1989/11/30','2022/11/12');
SELECT * FROM alunos;
-- ALTERAR TABELAS
ALTER TABLE alunos ADD COLUMN (codigopostal CHAR(11), localidade VARCHAR(20)); -- adiciona coluna
INSERT INTO alunos VALUES(4,'Tita','1999/10/13','2025/09/20',4700,'Braga');
ALTER TABLE alunos DROP COLUMN localidade; -- apaga coluna
ALTER TABLE alunos MODIFY COLUMN codigopostal INT; -- modificar tipo coluna
SELECT * FROM alunos;
-- Exercício 11
CREATE DATABASE registos;
USE registos;
CREATE TABLE utilizadores(
        nome VARCHAR(20),
        morada VARCHAR(20),
		codPostal VARCHAR(20),
        idade INT 
);
INSERT INTO utilizadores VALUES('Ana', 'Rua A', '4700-111', 25);
INSERT INTO utilizadores VALUES('Mafalda', 'Rua B', '4700-111', 22);
INSERT INTO utilizadores VALUES('Maria', 'Rua C', '4700-111', 29);
INSERT INTO utilizadores VALUES('Teresa', 'Rua D', '4700-111', 25);
INSERT INTO utilizadores VALUES('Clara', 'Rua E', '4700-111', 21);
SELECT * FROM utilizadores;
-- Renomear uma coluna
ALTER TABLE utilizadores CHANGE COLUMN morada localidade VARCHAR(20);
-- Apresentar só algumas das colunas da tabela
SELECT nome, idade FROM utilizadores;
-- A importância do WHERE (determina que registos vamos atualizar)
UPDATE utilizadores SET codPostal='4700-201' WHERE nome='Ana';
-- Apagar dados
DELETE FROM utilizadores WHERE idade>45
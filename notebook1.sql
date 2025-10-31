CREATE DATABASE	aws;
USE aws;
DROP DATABASE AWS;

-- Exercício 1
CREATE DATABASE braga;

CREATE DATABASE empresa;

-- Aqui ficamos dentro da base de dados empresa
USE empresa; 

-- Aqui, como já estamos dentro da base de dados empresa, só precisamos de escrever a tabela que queremos ver. abaixo será apresentada a dada tabela
SELECT * FROM funcionarios; 

-- Aqui, da tabela funcionários, só serão apresentados os dados dos campos de id e idade
SELECT id,idade FROM funcionarios; 


-- Exercício 2

-- O asterisco vai buscar todos os campos
SELECT * FROM servicos;

-- Ver as bases de dados do sistema
SHOW DATABASES;

-- Apagar base de dados
DROP DATABASE aws;
DROP DATABASE braga;


-- Exercício 3

CREATE DATABASE exemplo;
SHOW DATABASES;
DROP DATABASE exemplo;


-- Exercício 4

CREATE DATABASE teste_tipo_dados;
USE teste_tipo_dados;

-- Criar tabelas
CREATE TABLE utilizadores (
	codigo CHAR(5), 
    nome VARCHAR(100) NOT NULL, 
    biografia MEDIUMTEXT
);

-- Apagar a tabela utilizadores da base de dados empresa
USE empresa;
DROP TABLE utilizadores;


-- Exercício 5

USE teste_tipo_dados;
CREATE TABLE registo (
	nome VARCHAR(50),
    sobrenome VARCHAR(50)
);

-- Inserir dados na tabela registo
INSERT INTO registo(nome, sobrenome) VALUES ('Rui', 'Guerra');
SELECT * FROM registo; -- Vai aparecer a tabela com o nome Rui Guerra inserido

INSERT INTO registo(nome, sobrenome) VALUES ('Mafalda', 'Oliveira');
SELECT * FROM registo;


-- Exercício 6

CREATE TABLE produtos (
	marca VARCHAR(50),
    modelo VARCHAR(50)
);

INSERT INTO produtos(marca, modelo) VALUES ('ASUS', 'ABCD');
INSERT INTO produtos(marca, modelo) VALUES ('ACER', 'EFGH');

SELECT * FROM produtos;

-- Criar tabelas com números

-- Exemplo 1
CREATE TABLE numeros (
	id INT,
    valor INT,
    activo BOOLEAN
);

INSERT INTO numeros(id,valor,activo) VALUES (1, 100, 3); -- Como são números (valores do tipo numérico) não são precisas as aspas
SELECT * FROM numeros;

-- INSERT INTO numeros(id,valor,activo) VALUES (1, 100, TRUE); -> Isto assim não me deu

-- Exemplo 2
CREATE TABLE fatura (
	id INT AUTO_INCREMENT PRIMARY KEY,
    valor INT NOT NULL,
    activo BOOLEAN NOT NULL
);

INSERT INTO fatura(valor,activo) VALUES (100, FALSE);
SELECT * FROM fatura;

INSERT INTO fatura(valor) VALUES (100); -- Aqui não vai dar, porque o activo é NOT NULL, então precisa de ser inserido um valor
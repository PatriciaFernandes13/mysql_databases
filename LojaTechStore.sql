CREATE DATABASE techstore; -- Criar Base de Dados
USE techstore;
-- Criar Tabela Clientes
CREATE TABLE clientes(
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    localidade VARCHAR(20),
    telefone VARCHAR(20)
);

-- Criar Tabela Produtos
CREATE TABLE produtos (
	id_produto INT AUTO_INCREMENT PRIMARY KEY,
    designacao VARCHAR(50) NOT NULL,
    preco FLOAT(5) NOT NULL
);

-- Criar Tabela Vendas
CREATE TABLE vendas(
	id_venda INT AUTO_INCREMENT PRIMARY KEY,
    data_venda DATE NOT NULL,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Criar Tabela Linha
CREATE TABLE vendas_linha(
	id_linha_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);
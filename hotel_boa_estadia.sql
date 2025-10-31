CREATE DATABASE IF NOT EXISTS hotel_boa_estadia;
USE hotel_boa_estadia;
CREATE TABLE tipo_quarto (id INT AUTO_INCREMENT PRIMARY KEY, tipo VARCHAR(50) NOT NULL, preco_noite DECIMAL(10,2) NOT NULL);
CREATE TABLE hospede (id INT AUTO_INCREMENT PRIMARY KEY, pri_nome VARCHAR(100) NOT NULL, ult_nome VARCHAR(100), telemovel VARCHAR(30), email VARCHAR(150), num_ident VARCHAR(50) NOT NULL);
CREATE TABLE status (id INT AUTO_INCREMENT PRIMARY KEY, nome VARCHAR(50) NOT NULL UNIQUE);
CREATE TABLE quarto (id INT AUTO_INCREMENT PRIMARY KEY, num_quarto VARCHAR(10) NOT NULL UNIQUE, tipo_quarto_id INT NOT NULL, status_id INT NOT NULL, 
	FOREIGN KEY (tipo_quarto_id) REFERENCES tipo_quarto(id),
    FOREIGN KEY (status_id) REFERENCES status(id));
CREATE TABLE reserva (id INT AUTO_INCREMENT PRIMARY KEY, hospede_id INT NOT NULL, data_criada DATE NOT NULL, status_reserva VARCHAR(50) NOT NULL, 
	FOREIGN KEY (hospede_id) REFERENCES hospede(id));
CREATE TABLE reserva_quarto (id INT AUTO_INCREMENT PRIMARY KEY, reserva_id INT NOT NULL, quarto_id INT NOT NULL, check_in DATE NOT NULL, check_out DATE NOT NULL,
	FOREIGN KEY (reserva_id) REFERENCES reserva(id),
	FOREIGN KEY (quarto_id) REFERENCES quarto(id));
CREATE TABLE pagamento( id INT AUTO_INCREMENT PRIMARY KEY, reserva_id INT NOT NULL, data_pagamento DATE NOT NULL, metodo VARCHAR(50) NOT NULL, valor DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (reserva_id) REFERENCES reserva(id));
CREATE TABLE funcionario (id INT AUTO_INCREMENT PRIMARY KEY, pri_nome VARCHAR(100) NOT NULL, ult_nome VARCHAR(100), cargo VARCHAR(100), telemovel VARCHAR(30), email VARCHAR(150));

INSERT INTO hospede (id, pri_nome, ult_nome, telemovel, email, num_ident)
	VALUES (1, 'Ana', 'Andrade', '912345678', 'ana@andrade.pt', '123456789'), (2, 'Bruno', 'Barbosa', '987654321', 'bruno@barbosa.pt', '876543219'), (3, 'Carla', 'Carvalho', '975312468', 'carla@carvalho.pt', '753124689'), (4, 'Dario', 'Duarte', '913578642', 'dario@duarte.pt', '135786429'), (5, 'Erica', 'Eirinha', '986754231', 'erica@eirinha.pt', '867542319');
INSERT INTO tipo_quarto (id, tipo, preco_noite)
	VALUES (1, 'Individual', 60), (2, 'Duplo', 80), (3, 'Suite', 100), (4, 'Familiar', 120), (5, 'VIP', 140);
INSERT INTO status (id, nome)
	VALUES (1, 'Disponivel'), (2, 'Ocupado'), (3, 'Manutencao');
INSERT INTO quarto (id, num_quarto, tipo_quarto_id, status_id)
	VALUES (1, '1', 1, 1), (11, '11', 2, 2), (21, '21', 3, 3), (31, '31', 4, 1), (41, '41', 5, 2);
INSERT INTO reserva (id, hospede_id, data_criada, status_reserva)
	VALUES (1, 1, '2011-01-01', 'Reservada'), (2, 2, '2022-02-02', 'Check_in'), (3, 3, '2033-03-03', 'Check_out'), (4, 4, '2044-04-04', 'Cancelada'), (5, 5, '2055-05-05', 'Reservada');
INSERT INTO reserva_quarto (id, reserva_id, quarto_id, check_in, check_out)
	VALUES (1, 1, 1, '2000-01-01', '2000-01-11'), (2, 2, 11, '2000-02-02', '2000-02-22'), (3, 3, 21, '2000-03-03', '2000-03-23'), (4, 4, 31, '2000-04-04', '2000-04-24'), (5, 5, 41, '2000-05-05', '2000-05-25'), (6, 5, 31, '2000-05-05', '2000-05-25');
 INSERT INTO pagamento (id, reserva_id, data_pagamento, metodo, valor) 
	VALUES (1, 1, '2011-01-01', 'Cartão de Crédito', 60), (2, 2, '2022-02-02', 'Dinheiro', 160), (3, 3, '2033-03-03', 'Cartão de Débito', 300), (4, 4, '2044-04-04', 'Cartão de Crédito', 480), (5, 5, '2055-05-05', 'Dinheiro', 700);
INSERT INTO funcionario (id, pri_nome, ult_nome, cargo, telemovel, email)
	VALUES (1, 'Ana', 'Andrade', 'Rececionista', '912345678', 'ana@andrade.pt'), (2, 'Bruno', 'Barbosa', 'Diretor', '987654321', 'bruno@barbosa.pt'), (3, 'Carla', 'Carvalho', 'Rececionista', '975312468', 'carla@carvalho.pt'), (4, 'Dario', 'Duarte', 'Diretor', '913578642', 'dario@duarte.pt'), (5, 'Erica', 'Eirinha', 'Rececionista', '986754231', 'erica@eirinha.pt');

-- Quantos quartos estão ocupados por data?
SELECT quarto.num_quarto, tipo_quarto.tipo, reserva_quarto.check_in, reserva_quarto.check_out, reserva.id, hospede.pri_nome , hospede.ult_nome FROM reserva_quarto
INNER JOIN quarto ON reserva_quarto.quarto_id = quarto.id
INNER JOIN tipo_quarto ON quarto.tipo_quarto_id = tipo_quarto.id
INNER JOIN reserva ON reserva_quarto.reserva_id = reserva.id
INNER JOIN hospede ON reserva.hospede_id = hospede.id
ORDER BY reserva_quarto.check_in;

-- Quantos quartos estão ocupados na data 2000-05-05?
SELECT quarto.num_quarto, tipo_quarto.tipo, reserva_quarto.check_in, reserva_quarto.check_out, reserva.id, hospede.pri_nome , hospede.ult_nome FROM reserva_quarto
INNER JOIN quarto ON reserva_quarto.quarto_id = quarto.id
INNER JOIN tipo_quarto ON quarto.tipo_quarto_id = tipo_quarto.id
INNER JOIN reserva ON reserva_quarto.reserva_id = reserva.id
INNER JOIN hospede ON reserva.hospede_id = hospede.id
WHERE '2000-05-05' >= reserva_quarto.check_in AND '2000-05-05' < reserva_quarto.check_out
ORDER BY quarto.num_quarto;

-- Valor total de uma reserva Ex: 1 (soma por quarto: noites × preço do tipo)
SELECT reserva.id, hospede.pri_nome, hospede.ult_nome, SUM(DATEDIFF(reserva_quarto.check_out, reserva_quarto.check_in) * tipo_quarto.preco_noite) AS Preco_Total
FROM reserva_quarto
INNER JOIN reserva ON reserva_quarto.reserva_id = reserva.id
INNER JOIN quarto ON reserva_quarto.quarto_id = quarto.id
INNER JOIN tipo_quarto ON quarto.tipo_quarto_id = tipo_quarto.id
INNER JOIN hospede ON reserva.hospede_id = hospede.id
WHERE reserva.id = 1
GROUP BY reserva.id, hospede.pri_nome, hospede.ult_nome;

-- Listar reservas de um hóspede
SELECT reserva.id, reserva.status_reserva, reserva_quarto.quarto_id, quarto.num_quarto, reserva_quarto.check_in, reserva_quarto.check_out FROM reserva
INNER JOIN reserva_quarto ON reserva_quarto.reserva_id = reserva.id
INNER JOIN quarto ON reserva_quarto.quarto_id = quarto.id
WHERE reserva.hospede_id = 1
ORDER BY reserva_quarto.check_in;

-- Verificar disponibilidade de um quarto em datas
SELECT COUNT(*) FROM reserva_quarto
INNER JOIN quarto ON reserva_quarto.quarto_id = quarto.id
WHERE quarto.num_quarto = '11'
  AND NOT (reserva_quarto.check_out <= '2025-06-10' OR reserva_quarto.check_in >= '2025-06-12'); -- se = 0 então está livre

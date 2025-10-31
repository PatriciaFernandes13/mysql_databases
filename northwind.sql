USE northwind;
-- Ex1: Liste todos os produtos da categoria com CategoryID = 1.
SELECT * FROM product WHERE CategoryID = 1 ORDER BY ProductID;

-- Ex2: Liste os clientes da cidade "Berlin".
SELECT * FROM customer WHERE City = 'Berlin' ORDER BY CustomerID;

-- Ex3: Liste os empregados com título "Sales Representative".
SELECT * FROM employee WHERE Title = 'Sales Representative' ORDER BY EmployeeID;

-- Ex4: Liste os fornecedores com nome começando com "A".
SELECT * FROM supplier WHERE CompanyName LIKE 'A%' ORDER BY SupplierID;

-- Ex5: Liste os produtos cujo preço é menor que 20.
SELECT ProductName, UnitPrice FROM product WHERE UnitPrice < 20 ORDER BY UnitPrice;

-- Ex6: Liste todos os pedidos antes de 1 de janeiro de 1997.
SELECT * FROM salesorder WHERE OrderDate < '1997-01-01' ORDER BY OrderDate;

-- Ex7: Conte quantos pedidos existem na tabela Orders.
SELECT COUNT(*) AS pedidos_total FROM salesorder;

-- Ex8: Liste os produtos com estoque menor que 10.
SELECT ProductName, UnitsInStock FROM product WHERE UnitsInStock < 10 ORDER BY UnitsInStock;

-- Ex9: Liste os pedidos e o nome do cliente correspondente.
SELECT salesorder.OrderID, customer.CompanyName, customer.ContactName FROM salesorder 
	INNER JOIN customer ON salesorder.CustomerID = customer.CustomerID 
    ORDER BY salesorder.OrderID;

-- Ex10: Liste os produtos cujo nome termina com "Tea".
SELECT * FROM product WHERE ProductName LIKE '%Tea';

-- Ex11: Liste os pedidos do cliente CustomerID = 'BERGS'.
SELECT * FROM salesorder WHERE CustomerID = 'BERGS' ORDER BY OrderID;

-- Ex12: Mostre o nome do empregado e a data de nascimento (BirthDate).
SELECT FirstName, LastName, BirthDate FROM employee ORDER BY FirstName;

-- Ex13: Liste todas as cidades dos fornecedores sem repetições.
SELECT DISTINCT City, COUNT(SupplierID) AS num_fornecefores FROM supplier GROUP BY City ORDER BY City;

-- Ex14: Liste os pedidos cujo total de itens seja menor que 5.
SELECT OrderID, SUM(Quantity) AS itens_total FROM orderdetail
	GROUP BY OrderID HAVING SUM(Quantity) < 5 ORDER BY OrderID;

-- Ex15: Liste os produtos com fornecedores usando INNER JOIN.
SELECT product.ProductName, supplier.CompanyName AS fornecedor FROM product
	INNER JOIN supplier ON product.SupplierID = supplier.SupplierID
	ORDER BY Fornecedor;

-- Ex16: Liste os pedidos com o preço total de cada pedido (quantidade x preço unitário).
SELECT OrderID, SUM(UnitPrice * Quantity) AS valor_total FROM orderdetail GROUP BY OrderID ORDER BY valor_total DESC;

-- Ex17: Liste os produtos com preços entre 10 e 40.
SELECT ProductName, UnitPrice FROM product WHERE UnitPrice BETWEEN 10 AND 40 ORDER BY UnitPrice;

-- Ex18: Liste os clientes que têm pelo menos um pedido registrado.
SELECT DISTINCT customer.CustomerID, customer.CompanyName FROM customer
	INNER JOIN salesorder ON customer.CustomerID = salesorder.CustomerID
	ORDER BY customer.CustomerID;

-- Ex19: Liste os funcionários que têm supervisores (ReportsTo IS NOT NULL).
SELECT EmployeeID, FirstName, LastName, ReportsTo FROM employee WHERE ReportsTo IS NOT NULL ORDER BY FirstName;

-- Ex20: Mostre o total de vendas por funcionário.
SELECT employee.FirstName, employee.LastName, SUM(orderdetail.UnitPrice * orderdetail.Quantity) AS vendas_total FROM employee
	INNER JOIN salesorder ON employee.EmployeeID = salesorder.EmployeeID
	INNER JOIN orderdetail ON salesorder.OrderID = orderdetail.OrderID
	GROUP BY employee.firstName, employee.LastName ORDER BY vendas_total DESC;

-- Ex21: Liste os produtos com estoque entre 50 e 150 unidades.
SELECT ProductName, UnitsInStock FROM product
	WHERE UnitsInStock BETWEEN 50 AND 150 ORDER BY UnitsInStock;

-- Ex22: Liste os pedidos agrupados por mês de envio (ShippedDate).
SELECT MONTH(ShippedDate), COUNT(*) AS pedidos_total FROM salesorder WHERE ShippedDate IS NOT NULL
	GROUP BY MONTH(ShippedDate) ORDER BY MONTH(ShippedDate);

-- Ex23: Liste os fornecedores que fornecem produtos da categoria Beverages.
SELECT DISTINCT supplier.CompanyName AS fornecedor, category.CategoryName FROM supplier
	INNER JOIN product ON supplier.SupplierID = product.SupplierID
	INNER JOIN category ON product.CategoryID = category.CategoryID
	WHERE category.CategoryName = 'Beverages' ORDER BY supplier.CompanyName;

-- Ex24: Liste o número de pedidos feitos por funcionário.
SELECT employee.FirstName, employee.LastName, COUNT(salesorder.OrderID) AS pedidos_total FROM employee
	INNER JOIN salesorder ON employee.EmployeeID = salesorder.EmployeeID
	GROUP BY employee.FirstName, employee.LastName ORDER BY pedidos_total;

-- Ex25: Liste o produto mais barato de cada categoria (MIN(UnitPrice) por CategoryID).
SELECT category.CategoryName, product.ProductName, MIN(product.UnitPrice) AS produto_mais_barato FROM product
	INNER JOIN category ON product.CategoryID = category.CategoryID
	GROUP BY category.CategoryName ORDER BY produto_mais_barato;





-- EXERCICIOS AULA
-- Ex1: Listar todo os clientes (nome completo e cidade)
USE northwind;
SELECT CONCAT(customers.first_name, ' ', customers.last_name) AS nome_completo, city 
	FROM customers ORDER BY customers.first_name;
-- Ex2: Listar as incomendas de cada cliente
SELECT customers.id, customers.first_name, orders.id FROM customers
	INNER JOIN orders ON customers.id = orders.customer_id 
    ORDER BY customers.id;
-- Ex3: Listar quantas encomendas tem cada cliente
SELECT customers.id, customers.first_name, COUNT(orders.id) FROM customers
	INNER JOIN orders ON customers.id = orders.customer_id
	GROUP BY customers.first_name ORDER BY COUNT(orders.id) DESC;
-- Ex4: Listar as novas encomendas de cada cliente
SELECT customers.first_name, orders.id, orders_status.status_name FROM customers
	INNER JOIN orders ON customers.id = orders.customer_id
	INNER JOIN orders_status ON orders.status_id = orders_status.id
	WHERE orders_status.id = 0
	ORDER BY customers.first_name;
-- Ex5: Listar os detalhes da encomenda com os totais (quantidade*preço unitário )
SELECT order_details.product_id, order_details.quantity, order_details.unit_price, (quantity*unit_price) AS total FROM order_details ORDER BY total DESC; 
-- Ex6: Listar os detalhes da encomenda com os totais e o nome do produto
SELECT order_details.product_id, products.product_name, order_details.quantity, order_details.unit_price, (order_details.quantity*order_details.unit_price) AS total FROM order_details 
	INNER JOIN products ON order_details.product_id = products.id 
    ORDER BY total DESC;
-- Ex7: Qual é o valor das vendas por produto
SELECT products.product_id, products.product_name, SUM(order_details.quantity*order_details.unit_price) AS total FROM order_details 
	INNER JOIN products ON order_details.product_id = products.id
	GROUP BY product_id, products.product_name ORDER BY total; 
-- Ex8: Quantidade Produtos encomendados e recebidos por colaborador
SELECT employees.id, employees.first_name, products.id, products.product_name, SUM(order_details.quantity) AS quantidade_total FROM employees
	INNER JOIN orders ON employees.id = orders.employee_id
    INNER JOIN order_details ON orders.id = order_details.order_id
	INNER JOIN products ON order_details.product_id = products.id
	GROUP BY employees.first_name, products.product_name ORDER BY employees.first_name;

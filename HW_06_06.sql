-- Используя базу данных ShopDB и страницу Customers 
-- (удалите таблицу, если есть и создайте заново первый раз без первичного ключа затем – с первичным) и
-- затем добавьте индексы и проанализируйте выборку данных.

USE ShopDB;

SELECT * FROM Employees;
SELECT * FROM OrderDetails;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Customers;
------------------------------------------

-- удаляем таблицу Customers;
drop table Customers;

-- создаем заново таблицу Customers без первичного ключа
CREATE TABLE Customers
	(
	CustomerNo int NOT NULL,
	FName nvarchar(15) NOT NULL,
	LName nvarchar(15) NOT NULL,
	MName nvarchar(15) NULL,
	Address1 nvarchar(50) NOT NULL,
	Address2 nvarchar(50) NULL,
	City nchar(10) NOT NULL,
	Phone char(12) NOT NULL,
	DateInSystem date NULL
	);  
    
INSERT Customers 
(CustomerNo, LName, FName, MName, Address1, Address2, City, Phone,DateInSystem)
VALUES
(1,'Круковский','Анатолий','Петрович','Лужная 15',NULL,'Харьков','(092)3212211','2009-11-20'),
(2,'Дурнев','Виктор','Викторович','Зелинская 10',NULL,'Киев','(067)4242132','2009-11-20'),
(3,'Унакий','Зигмунд','федорович','Дихтяревская 5',NULL,'Киев','(092)7612343','2009-11-20'),
(4,'Левченко','Виталий','Викторович','Глущенка 5','Драйзера 12','Киев','(053)3456788','2009-11-20'),
(5,'Выжлецов','Олег','Евстафьевич','Киевская 3','Одесская 8','Чернигов','(044)2134212','2009-11-20');    

SELECT * FROM Customers;

-- производим анализ запроса данных
EXPLAIN SELECT * FROM Customers 
				 WHERE CustomerNo = 5; -- выполнение запроса низкое
                 
EXPLAIN SELECT * FROM Customers 
				 WHERE LName = 'Выжлецов'; -- выполнение запроса низкое
                 
-- добавляем индекс с колонку LName
CREATE INDEX indexLName
ON Customers(LName);

-- снова выполняем анализ выборки данных
EXPLAIN SELECT * FROM Customers 
				 WHERE LName = 'Выжлецов'; -- после добавления индекса выборка данных улучшилась в 5 раз

EXPLAIN SELECT * FROM Customers 
				 WHERE CustomerNo = 5; -- без добавления индекса результат остался без изменений - выполнение запроса низкое                 

DROP INDEX indexLName
ON Customers;

drop table Customers;
-------------------------------

-- создаем заново таблицу Customers с первичным ключом
CREATE TABLE Customers
	(
	CustomerNo int NOT NULL auto_increment,
	FName nvarchar(15) NOT NULL,
	LName nvarchar(15) NOT NULL,
	MName nvarchar(15) NULL,
	Address1 nvarchar(50) NOT NULL,
	Address2 nvarchar(50) NULL,
	City nchar(10) NOT NULL,
	Phone char(12) NOT NULL,
	DateInSystem date NULL,
    primary key(CustomerNo)
	);
    
INSERT Customers 
(LName, FName, MName, Address1, Address2, City, Phone,DateInSystem)
VALUES
('Круковский','Анатолий','Петрович','Лужная 15',NULL,'Харьков','(092)3212211','2009-11-20'),
('Дурнев','Виктор','Викторович','Зелинская 10',NULL,'Киев','(067)4242132','2009-11-20'),
('Унакий','Зигмунд','федорович','Дихтяревская 5',NULL,'Киев','(092)7612343','2009-11-20'),
('Левченко','Виталий','Викторович','Глущенка 5','Драйзера 12','Киев','(053)3456788','2009-11-20'),
('Выжлецов','Олег','Евстафьевич','Киевская 3','Одесская 8','Чернигов','(044)2134212','2009-11-20');    

SELECT * FROM Customers;

-- производим анализ выборки данных.
EXPLAIN SELECT * FROM Customers 
				 WHERE CustomerNo = 5; -- выполнение запроса высокое
                 
EXPLAIN SELECT * FROM Customers 
				 WHERE LName = 'Выжлецов'; -- выполнение запроса низкое
                 
EXPLAIN SELECT * FROM Customers 
				 WHERE Phone = '(044)2134212'; -- выполнение запроса низкое
 
-- добавляем индекс с колонку LName
CREATE INDEX indexLName
ON Customers(LName);

-- выполняем анализ запрос данных
EXPLAIN SELECT * FROM Customers 
				 WHERE LName = 'Выжлецов'; -- после добавления индекса выборка данных улучшилась в 5 раз

EXPLAIN SELECT * FROM Customers 
				 WHERE CustomerNo = 5;
                 -- без добавления индекса, но с первичным ключом  производительность выборки данных осталась высокой 

EXPLAIN SELECT * FROM Customers 
				 WHERE Phone = '(044)2134212'; 
				-- т.к. в данном столбце отсутствует и первичний ключ и индекс, то выборка данных низкая

-- на выборку данных в таблице влияет наличие первичного ключа(при этом создается кластеризованный индекс) и 
-- создание для определенного столбца некластеризованного индекса 

DROP INDEX indexLName
ON Customers;

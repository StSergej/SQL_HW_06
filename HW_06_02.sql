-- Зайдите в базу данных “MyJoinsDB”, под созданным в предыдущем уроке пользователем. 
-- Проанализируйте, какие типы индексов заданы на созданных в предыдущем домашнем задании таблицах. 

create database MyJoinsDB;

use MyJoinsDB;

create table employees
(
	personal_number smallint Not Null,
	full_name varchar(20) Not Null,
    telephone varchar(15) Not Null,
    primary key(personal_number)
);
-- в таблице employees в столбце personal_number автоматически был создан кластеризованный индекс,
-- т.к. этот столбец содержит primary key;
-- некластеризовынных индексов в данной таблице нет

insert into employees(personal_number, full_name, telephone)
values (101, 'Ткаченко А.С.', '050-608-45-17'),
	   (202, 'Антонов В.Н.', '066-345-12-15'),
	   (303, 'Скорик М.И.', '099-654-45-99');

select * from employees;
------------------------------

create table proprietary_data
(
	talon_number smallint Not Null,
	salary mediumint Not Null,
	position varchar(20) Not Null,
    primary key (talon_number)
);
-- в столбце talon_number автоматически был создан кластеризованный индекс
-- некластеризовынных индексов в таблице proprietary_data нет 

alter table proprietary_data
add constraint FK_proprietaryEmployees
foreign key(talon_number) references employees(personal_number);

insert into proprietary_data(talon_number, salary, position)
values (101, 30000, 'директор'),
	   (202, 22000, 'менеджер'),
	   (303, 20000, 'рабочий');	

select * from proprietary_data;
----------------------------

create table personal_data
(
	account_number smallint Not Null,
	family_status varchar(10) Not Null,
    birthday date Not Null,
    address varchar(50) Not Null,
    primary key (account_number)
);
-- в столбце account_number был создан кластеризованный индекс
-- некластеризовынных индексов в таблице personal_data нет

alter table personal_data
add constraint FK_personalEmployees
foreign key(account_number) references employees(personal_number);

insert into personal_data(account_number, family_status, birthday, address)
values  (101, 'женат', '1980-12-02', 'Луцк, пр.Науки,43'),
		(202, 'холост', '2001-06-28', 'Луцк, ул.Киевская,71'),
		(303, 'холост', '1999-02-17', 'Луцк, пр.Шевченко,125');

select * from personal_data;
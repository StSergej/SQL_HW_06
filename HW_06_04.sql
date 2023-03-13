-- Создайте представления для таких заданий: 
-- 1. Необходимо узнать контактные данные сотрудников (номера телефонов, место жительства). 
-- 2. Необходимо узнать информацию о дате рождения всех не женатых сотрудников и номера телефонов этих сотрудников. 
-- 3. Необходимо узнать информацию о дате рождения всех сотрудников с должностью менеджер и номера телефонов этих сотрудников. 

use MyJoinsDB;

select * from employees;

select * from proprietary_data;

select * from personal_data;

-- 1. Создаем представление, с помощью которого узнаем контактные данные сотрудников (номера телефонов, место жительства). 
create view contact_details as
select personal_number as id, full_name, telephone, address
from employees
INNER JOIN personal_data on employees.personal_number = personal_data.account_number;

select * from contact_details;

drop view contact_details;
---------------------------

-- 2. Представление о дате рождения всех не женатых сотрудников и номера телефонов этих сотрудников.
create view personal_details as
select (select full_name from employees 
						 where employees.personal_number = personal_data.account_number) as full_name, 
	   birthday, 
       family_status,
       (select telephone from employees
						 where employees.personal_number = personal_data.account_number) as telephone 
from personal_data
where family_status = 'холост';

select * from personal_details;

drop view personal_details;
----------------------------

-- 3. Представление выводит дату рождения всех сотрудников с должностью менеджер и номера телефонов этих сотрудников. 
create view position as
select full_name, position, birthday, telephone
from (employees
inner join personal_data on personal_data.account_number = employees.personal_number)
inner join proprietary_data on employees.personal_number = proprietary_data.talon_number
where position = 'менеджер';

select * from position;

drop view position;

-- Задайте свои индексы на таблицах, созданных в предыдущем домашнем задании и обоснуйте их необходимость. 

use MyJoinsDB;

---------------------------
select * from employees;

EXPLAIN SELECT * FROM employees 
				 WHERE full_name = 'Антонов В.Н.';

create index indexEmployee
on employees (full_name);

EXPLAIN SELECT * FROM employees 
				 WHERE full_name = 'Антонов В.Н.';

drop index indexEmployee
on employees;
---------------------------

select * from proprietary_data;

explain select * from proprietary_data 
				 where position = 'рабочий';

create index indexPosition
on proprietary_data (position);

explain select * from proprietary_data 
				 where position = 'рабочий';

drop index indexPosition
on proprietary_data;
----------------------------

select * from personal_data;

explain select * from personal_data 
				 where address = 'Луцк, ул.Киевская,71';

create index indexPersonalData
on personal_data(address);

explain select * from personal_data 
				 where address = 'Луцк, ул.Киевская,71';

drop index indexPersonalData
on personal_data;

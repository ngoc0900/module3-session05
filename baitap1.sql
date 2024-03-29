create database ss4_baitap;
use ss4_baitap;
create table categorys(
id int primary key auto_increment,
category_name varchar(100) not null unique,
category_status bit(1) default 1
);
create table products(
id int primary key auto_increment,
product_name varchar(100) ,
price double ,
stock int,
product_status bit(1) default 1,
category_id int not null,
foreign key (category_id) references categorys(id)
);
insert into categorys(category_name) values 
('ao'),
('quan'),
('mu');
insert into products(product_name,price,stock,category_id) values
('ao so mi', 20000,20, 1),
('ao khoac', 30000,30, 1),
('ao ngan tay', 40000,10, 1),
('quan bo', 30000,9, 2),
('quan the thao', 50000,40, 2),
('mu chong nang', 10000,12, 3);

create view ctg_prd 
as
select categorys. *,count(products.id) as amout
from categorys
join products 
on categorys.id= products.category_id
group by products.category_id;

select * from products join categorys on categorys.id= products.category_id;
select * from ctg_prd order by amout desc limit 1;
drop view ctg_prd ;
select * from ctg_prd ;

create view prd 
as select * from products where price > 10000;

drop view prd ;
 select * from prd ;
 
 create view prd_s
as select * from products where stock > 10;
select * from prd_s;
 



create database session05_fuk;
use session05_fuk;
create table category(
id int primary key auto_increment,
category_name varchar(100) not null unique,
category_status bit(1) default 1
);

create table product(
id int primary key auto_increment,
product_name varchar(100) ,
price double ,
category_id int not null,
foreign key (category_id) references category(id)
);

insert into category(category_name) values 
('ao'),
('quan'),
('mu');

insert into product(product_name,price,category_id) values
('ao so mi', 2000, 1),
('quan bo', 3000, 2),
('mu chong nang', 1000, 3);

-- lấy ra product_name,price, tên danh mục
select p.product_name,p.price,c.category_name as categoty_name
from product p
join category c
on p.category_id = c.id;
-- lấy view
create view vw_prd_cate 
as 
select p.product_name,p.price,c.category_name as categoty_name
from product p
join category c
on p.category_id = c.id;
-- lấy dữ liệu từ view
select * from vw_prd_cate ;



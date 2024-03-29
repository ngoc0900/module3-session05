create database session05_fk;
use session05_fk;
drop database session05_fk;
create table category(
	id int primary key auto_increment,
    category_name varchar(100) not null unique,
    category_status bit(1) default 1
);
create table product(
	id int primary key auto_increment,
    product_name varchar(150),
    price double,
    category_id int not null,
    foreign key (category_id) references category(id)
);

insert into category(category_name) value ('ÁO');
insert into category(category_name) value ('Quần');
insert into category(category_name) value ('Mũ');

insert into product(product_name,price,category_id) value ('áo sơ mi',2000,1);
insert into product(product_name,price,category_id) value ('Quần',5000,2);

-- lấy ra product_name, price,ten danh mục 
select p.product_name,p.price,c.category_name as category_name
from product p 
join category c
on p.category_id = c.id;

-- tạo view 
create view vw_product_cate
AS 
	select p.product_name,p.price,c.category_name as category_name
	from product p 
	join category c
	on p.category_id = c.id;

-- lấy dữ liệu từ view
select * from vw_product_cate;

-- tạo thủ tục lấy về danh sách sản phâm bao gôm  product_name, price,ten danh mục
DELIMITER //
CREATE PROCEDURE PROC_GET_ALL_PRODUCT()
 BEGIN
	select p.product_name,p.price,c.category_name as category_name
	from product p 
	join category c
	on p.category_id = c.id;
END;
//
DELIMITER ;
-- goi thu tục 
CALL PROC_GET_ALL_PRODUCT();
-- thủ tục có tham số đầu vào 
-- tạo thủ tục thêm mới danh mục 
DELIMITER //
CREATE PROCEDURE PROC_ADD_CATEGORY(IN cateName varchar(100),_status bit)
 BEGIN
	insert into category(category_name,category_status) value (cateName,_status);
END;
//
DELIMITER ;

CALL PROC_ADD_CATEGORY('Gì đó',1);

SELECT * FROM category;

-- thủ tục có tham số đầu ra 
-- tạo thủ tục kiểm tra trong bảng category có tồn tại 1 cái bản ghi theo id hay không có trả 1 không có trả 0 

DELIMITER //
CREATE PROCEDURE PROC_FIND_BY_ID_EXITS(IN _id int,OUT _check bit)
 BEGIN
	SET _check = (select count(id) from category where id = _id);
END;
//
DELIMITER ;

-- goi thu tuc tham so dau ra 
CALL PROC_FIND_BY_ID_EXITS(100,@check);
SELECT @check as 'check';

SELECT * FROM category;

-- thêm sửa xoá sản phẩm bằng thủ tục
-- thêm
DELIMITER //
CREATE PROCEDURE PROC_ADD_PRODUCT(IN productName varchar(150),price double,category_id int)
 BEGIN
	insert into product(product_name,price,category_id) value (productName,price,category_id);
END;
//
DELIMITER ;
DROP PROCEDURE PROC_ADD_PRODUCT;
CALL PROC_ADD_PRODUCT('áo chống nắng',12000,1);

select * from product;

-- sửa sản phẩm
SET _check = (select count(id) from product where id = _id);
DELIMITER //
CREATE PROCEDURE PROC_EDIT_PRODUCT(IN id1 int, productName varchar(150),price1 double,category_id int,OUT _check bit)
 BEGIN
	SET _check = (select count(id) from product where id = id1);
    if (_check) then
    update product set product_name = productName,price = price1,category_id=category_id where id = id1;
    else select 'khong ton tai id';
END IF;
end;
//
DELIMITER ;
CALL PROC_EDIT_PRODUCT(1,'quan dui',20000,2,@check);

DROP PROCEDURE PROC_EDIT_PRODUCT;



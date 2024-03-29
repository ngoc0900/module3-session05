create database ss5_btvn01;
use ss5_btvn01;
create table users(
id int primary key auto_increment,
fullName varchar(150) not null ,
username varchar(150) not null unique,
password_ varchar(10) not null,
adrress  varchar(100) not null,
phone varchar(100) not null,
status_ bit(1) default 1
);

create table roles(
id int primary key auto_increment,
name_ varchar(150) not null unique
);

create table user_role(
user_id int not null,
foreign key (user_id) references users(id),
role_id int not null,
foreign key(role_id) references roles(id)
);

insert into roles(name_) values 
('nguoi 1'),
('nguoi 2');
insert into user_role(user_id,role_id) values 
(1,1),
(3,2);
select * from users;
select * from roles;
select * from 

DELIMITER //
CREATE PROCEDURE PROC_SIGNIN(IN fullName varchar(150),username varchar(150),password_ varchar(10),adrress varchar(100), phone varchar(100))
 BEGIN
	insert into users(fullName,username,password_,adrress,phone) value (fullName,username,password_,adrress,phone);
END;
//
DELIMITER ;
CALL PROC_SIGNIN('hong ngoc', 'ngoc', '1234', 'hp' ,'0123455');
CALL PROC_SIGNIN('hong nhung', 'nhunf', '9876', 'hp' ,'019983');
select * from users;

DELIMITER //

CREATE PROCEDURE LoginUser (
    IN p_username VARCHAR(150),
    IN p_password VARCHAR(10)
)
BEGIN
    DECLARE user_id INT;

    -- Kiểm tra xem username có tồn tại trong bảng users hay không
    SELECT id INTO user_id FROM users WHERE username = p_username;

    -- Nếu username không tồn tại, thông báo lỗi
    IF user_id IS NULL THEN
        SELECT 'Tên đăng nhập không tồn tại';
    ELSE
        -- Kiểm tra thông tin đăng nhập
        SELECT id INTO user_id FROM users WHERE username = p_username AND password_ = p_password;

        -- Nếu thông tin đăng nhập không chính xác, thông báo lỗi
        IF user_id IS NULL THEN
            SELECT 'Sai mật khẩu';
        ELSE
            -- Trả về user_id nếu đăng nhập thành công
            SELECT user_id AS 'user_id';
        END IF;
    END IF;
END //

DELIMITER ;

DROP PROCEDURE LoginUser;
CALL LoginUser('ngoc','0123455');
CALL LoginUser('MAI','012345');

DELIMITER //

CREATE PROCEDURE GetUsersByRole (
    IN p_role_name VARCHAR(150)
)
BEGIN
    -- Lấy role_id từ tên role
    DECLARE role_id INT;
    SELECT id INTO role_id FROM roles WHERE name_ = p_role_name;

    -- Lấy thông tin tất cả người dùng có role_id tương ứng
    SELECT u.* 
    FROM users u
    INNER JOIN user_role ur 
    ON u.id = ur.user_id
    WHERE ur.role_id = role_id;
END //

DELIMITER ;
call GetUsersByRole('nguoi 1');



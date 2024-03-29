create database ss5_btvn02;
use  ss5_btvn02;

create table Class(
classId int primary key auto_increment,
className varchar(100) not null unique,
startDate date ,
status_ bit(1) default 1
);

create table Student(
StudentId int primary key auto_increment,
StudentName varchar(100) not null unique,
adrress  varchar(100) not null,
phone  varchar(100) not null,
status_ bit(1) default 1,
class_id int not null,
foreign key(class_id) references Class(classId)
);


create table Subject_(
subId int primary key auto_increment,
subName varchar(100) not null unique,
credit int not null,
status_ bit(1) default 1
);


create table Mark(
markId int primary key auto_increment,
sub_id int not null,
foreign key(sub_id) references Subject_(subId),
student_id int not null,
foreign key(student_id) references Student(StudentId),
mark float,
examTime time
);

DELIMITER //
CREATE PROCEDURE PROC_CLASS(
IN class_Name varchar(100),
IN start_Date DATE
)
 BEGIN
	insert into Class(className,startDate) value (class_Name,start_Date);
END;
//
DELIMITER ;
CALL PROC_CLASS('A1','2024-01-15');
CALL PROC_CLASS('A2','2024-01-16');
CALL PROC_CLASS('A3','2024-01-17');
select * from Class;

DELIMITER //
CREATE PROCEDURE PROC_STUDENT(
IN Student_Name varchar(100),
IN adrress varchar(100),
IN phone  varchar(100), 
IN class_id int 
)
 BEGIN
	insert into Student(StudentName,adrress,phone,class_id) value (Student_Name,adrress,phone,class_id);
END;
//
DELIMITER ;
CALL PROC_STUDENT('ngoc','hp','12345',1);
CALL PROC_STUDENT('trang','hn','222334',2);
CALL PROC_STUDENT('nam','hcm','455341',3);
CALL PROC_STUDENT('hung','hn','2455121',2);
select * from Student;

DELIMITER //
CREATE PROCEDURE PROC_SUBJECT(
IN sub_Name varchar(100) ,
IN credit int 
)
 BEGIN
	insert into Subject_(subName,credit) value (sub_Name,credit);
END;
//
DELIMITER ;

CALL PROC_SUBJECT('hoá',2);
CALL PROC_SUBJECT('Toán',3);
CALL PROC_SUBJECT('Lý',1);
select * from Subject_;

DELIMITER //
CREATE PROCEDURE PROC_MARK(
IN sub_id int,
IN student_id int ,
IN mark float,
IN examTime time
)
 BEGIN
	insert into Mark(sub_id,student_id,mark,examTime) value (sub_id,student_id,mark,examTime);
END;
//
DELIMITER ;
CALL PROC_MARK(1,2,8,'45:00');
CALL PROC_MARK(2,1,6,'45:00');
CALL PROC_MARK(2,3,9,'45:00');
CALL PROC_MARK(3,4,7,'45:00');
CALL PROC_MARK(1,1,5,'45:00');
CALL PROC_MARK(1,3,7,'45:00');
CALL PROC_MARK(1,4,9,'45:00');
select* from Mark;



-- Tạo store procedure lấy ra danh sách học sinh có điểm cao nhất môn “Hóa Học” sắp xếp theo chiều giảm dần
DELIMITER //
CREATE PROCEDURE PROC_MARK_HOA()
 BEGIN
	select s.StudentId,s.StudentName,m.mark,sbj.subName  from Student s
    inner join Mark m
    on s.StudentId = m.student_id
	inner join Subject_ sbj
    on m.sub_id = sbj.subId
    where sbj.subId = 1
    order by m.mark desc;
END;
//
DELIMITER ;
CALL PROC_MARK_HOA();


-- Tạo store procedure lấy ra danh sách môn học được nhiều sinh viên thi nhất sắp xếp theo chiều giảm dần
DELIMITER //
CREATE PROCEDURE PROC_SBJ_BY_MARK()
 BEGIN
	select sbj.subName, count(*) As num_students from Subject_ sbj
inner join Mark m
on sbj.subId = m.sub_id
group by sbj.subId
order by num_students desc;
END;
//
DELIMITER ;

CALL PROC_SBJ_BY_MARK();



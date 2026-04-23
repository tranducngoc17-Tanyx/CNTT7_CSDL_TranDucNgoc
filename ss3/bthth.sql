create database to_do_list_db;

use to_do_list_db;

create table tasks (
	id int primary key auto_increment,
    name char(50) not null,
    details text,
    status tinyint
);

insert into tasks
values
(9, 'làm bài tập elearning', 'Làm bài tập session02 - Môn Cơ sở dữ liệu', 1),
(10, 'Học SQL cơ bản', 'Xem video hướng dẫn về lệnh INSERT và UPDATE', 0);


select * from tasks
where id = 9 or id = 10;

delete from tasks
where id > 10;

update tasks
set status = 1
where id = 10;

select * from tasks;

select name, status from tasks;



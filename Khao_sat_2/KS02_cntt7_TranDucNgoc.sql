create database LibaryManagement;

use LibaryManagement;

create table Book (
	book_id varchar(10) primary key,
    name varchar(100) not null,
    author varchar(50) not null,
    publish_year int not null,
    stock int not null default 0 check (stock >= 0)
);

create table Reader (
	reader_id varchar(10) primary key,
    name varchar(100) not null,
    email varchar(100) unique,
    phoneNumber varchar(15) unique,
    dob date not null
);

create table Borrow_Card (
    card_id varchar(10) primary key,
    borrow_date date NOT NULL,
    return_date date NOT NULL,
    reader_id varchar(10) NOT NULL,
    foreign key (reader_id) references Reader(reader_id)
        on delete cascade
        on update cascade
);

create table Borrow_Detail (
    card_id varchar(10),
    book_id varchar(10),
    status varchar(10),
    fee decimal(10,2),
    
    primary key (card_id, book_id),
    foreign key (card_id) references Borrow_Card(card_id),
    foreign key (book_id) references Book(book_id)
);

alter table Reader
add address varchar(255);

alter table Book
change publish_year NamPhatHanh int;

insert into Book values
('B001','Doraemon','Fujiko',2018,10),
('B002','Mat biec','Nguyễn Nhật Ánh',2019,5),
('B003','Cho toi xin mot ve di tuoi tho','Nguyễn Nhật Ánh',2020,7),
('B004','White Fang','Jack London',2016,6),
('B005','SQL co ban','ABC',2022,8);

insert into Reader values
('R001','An','an@gmail.com','0123','2000-01-01'),
('R002','Binh',null,'0456','2001-02-02'),
('R003','Cuong','c@gmail.com','0789','2002-03-03'),
('R004','Dung','d@gmail.com','0111','2003-04-04'),
('R005','Em','e@gmail.com','0222','2004-05-05');

insert into Borrow_Card values
('PM001','2026-04-01','2026-04-10','R001'),
('PM002','2026-04-05','2026-04-15','R003'),
('PM003','2026-03-01','2026-03-10','R004'),
('PM004','2026-04-10','2026-04-20','R005'),
('PM005','2026-02-01','2026-02-10','R001');

insert into Borrow_Detail values
('PM001','B001','Moi',1000),
('PM001','B002','Cu',2000),
('PM002','B003','Moi',1500),
('PM003','B004','Cu',1200),
('PM004','B005','Moi',1800);

set sql_safe_updates = 0;
update Book
set stock = stock + 5
where author = 'Nguyễn Nhật Ánh';
set sql_safe_updates = 1;


delete from Reader
where email is null;

select * from Book;
select * from Reader;

select * from Book
where NamPhatHanh between 2015 and 2023;

select name from Reader
where reader_id in (
    select reader_id
    from Borrow_Card
    where month(borrow_date) = 4
      and year(borrow_date) = 2026
);

select name from Book
where book_id in (
    select book_id
    from Borrow_Detail
    where card_id = 'PM001'
);

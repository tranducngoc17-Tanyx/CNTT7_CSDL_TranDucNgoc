-- Phan2 DDL 
create database SalesManagement;
use SalesManagement;

create table Product (
    product_id varchar(10) primary key,
    name varchar(100),
    HangSanXuat varchar(100),
    price decimal(15,2),
    stock int
);

create table Customer (
    customer_id varchar(10) primary key,
    name varchar(100),
    email varchar(100),
    phone varchar(20),
    address varchar(255)
);

create table Orders (
    order_id varchar(10) primary key,
    order_date date,
    total_amount decimal(15,2),
    customer_id varchar(10),
    foreign key (customer_id) references Customer(customer_id)
);



create table Order_Detail (
    order_id varchar(10),
    product_id varchar(10),
    quantity int,
    price_time decimal(15,2),
    primary key (order_id, product_id),
    foreign key (order_id) references Orders(order_id),
    foreign key (product_id) references Product(product_id)
);

alter table Orders
add note text;

alter table Product
change HangSanXuat NhaSanXuat varchar(100);

-- xoa bang 
drop table Order_Detail;
drop table Orders;

-- Phan3 DML
insert into Product values
('P001', 'MacBook Air M2', 'Apple', 25000000, 10),
('P002', 'iPhone 14', 'Apple', 20000000, 15),
('P003', 'Dell XPS 13', 'Dell', 22000000, 8),
('P004', 'HP Tuf', 'HP', 15000000, 12),
('P005', 'Asus Vivobook', 'Asus', 30000000, 5);

insert into Customer values
('C001', 'Nguyen Van A', 'a@gmail.com', '0123456789', 'Ho Chi Minh'),
('C002', 'Tran Van B', 'b@gmail.com', NULL, 'Ha Noi'),
('C003', 'Vu Van C', 'c@gmail.com', '0987654321', 'Binh Dinh'),
('C004', 'Phan Van D', 'd@gmail.com', NULL, 'Son La'),
('C005', 'Tan Van E', 'e@gmail.com', '0111222333', 'Thao Nguyen');

insert into Orders (order_id, order_date, total_amount, customer_id)
values
('DH001', '2026-04-01', 45000000, 'C001'),
('DH002', '2026-04-02', 20000000, 'C003'),
('DH003', '2026-04-03', 30000000, 'C005'),
('DH004', '2026-04-04', 15000000, 'C001'),
('DH005', '2026-04-05', 22000000, 'C003');

insert into Order_Detail values
('DH001', 'P001', 1, 25000000),
('DH001', 'P002', 1, 20000000),
('DH002', 'P002', 1, 20000000),
('DH003', 'P005', 1, 30000000),
('DH004', 'P004', 1, 15000000);

select * from Order_Detail;

update Product
set price = price * 1.1
where NhaSanXuat = 'Apple';

delete from Customer
where phone is null;

-- Phan4 select
select * from Product
where price between 10000000 and 20000000;

select * from Orders
where order_id = "DH001";

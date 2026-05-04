create database MechKeyStore;
use MechKeyStore;

create table Product(
	productId int primary key auto_increment,
    name varchar(100) not null,
    HangSX varchar(100) not null,
    Price decimal(10, 2) check (Price >= 0),
    stock int
    
);

create table Customer(
	customerId int primary key auto_increment,
    name varchar(100) not null,
    email varchar(50) unique,
    phoneNumber varchar(15),
    address varchar(50)
);

create table Orders(
	orderId int primary key auto_increment,
    order_date date,
    total decimal(10, 2) check (total >= 0)
);

create table Order_Detail(
	purchase_quantity varchar(15),
    price_time decimal(10, 2)check (price_time >= 0),
    
    foreign key (orderId) references Orders(orderId),
    foreign key (customerId) references Customer(customerId)
);



drop table Orders;
drop table Order_Detail;

insert into Product (name, HangSX, Price, stock) values
('Aula F75', 'Aula', 950000, 5),
('Aula F75 pro', 'Aula', 2200000, 3),
('Logitech M1', 'Logitech', 1200000, 15),
('Shrank 78', 'Shrank', 740000, 21),
('Asus M68', 'Asus', 760000, 12);

insert into Customer (name, email, phoneNumber, address) values
('Tran Van A', 'a@gmail.com', '0123456789', 'Dong Nai'),
('Tran Thi B', 'b@gmail.com', '0123456788', 'Gia Lai'),
('Tran Nguyen D', 'c@gmail.com', '0123456799', 'Tay Ninh'),
('Tran Luong E', 'e@gmail.com', '0123456787', 'Da Lat'),
('Tran Ta F', 'f@gmail.com', '0123456785', 'Phu Tho');

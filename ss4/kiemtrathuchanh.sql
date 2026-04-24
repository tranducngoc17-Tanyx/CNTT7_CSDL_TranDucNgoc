create database ShopManager;

use ShopManager;

create table Categories_db (
	category_id int primary key auto_increment,
    category_name char(255) not null
);

create table Products_db (
	product_id int primary key auto_increment,
    product_name char(255) not null,
    price decimal(10,2) not null check (price >= 0),
    stock int,
    category_id int not null
);

insert into Categories_db (category_name)
values ('Điện tử'), ('Thời trang');

select * from Categories_db;

insert into Products_db (product_name, price, stock, category_id)
values
('iPhone 15',  25000000, 10, 1),
('Samsung S23', 20000000, 5, 1),
('Áo sơ mi nam', 500000, 50, 2),
('Giày thể thao', 1200000, 20, 2);

select * from Products_db;

SET SQL_SAFE_UPDATES = 0;

update Products_db
set price = 26000000 where product_name = 'iPhone 15';

update Products_db set stock = stock + 10 where category_id = 1;





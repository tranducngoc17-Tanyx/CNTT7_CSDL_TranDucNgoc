use shop_db;

create table Customers (
	CustomerID int auto_increment primary key,
    FullName varchar(100) not null,
    Email varchar(100) not null unique
);

create table Orders (
	OrderID int auto_increment primary key,
    OrderDate date default current_date,
    TotalAmount decimal(10, 2) not null check (TotalAmount >= 0),
    CustomerID int not null,
    
    constraint fk_customer
    foreign key (CustomerID)
    references Customers(CustomersID)
);

insert into Customers (FullName, Email)
values('Nguyen Van b', 'vanb@gmail.com');

insert into Orders (TotalAmount, CustomerID)
values(130000, 1);

select * from Customers; 

select * from Orders; 
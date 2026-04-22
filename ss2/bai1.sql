CREATE DATABASE shop_db;
USE shop_db;

CREATE TABLE Products (
	ID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    Description VARCHAR(500)
);

SELECT * FROM Products;
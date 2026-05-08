CREATE DATABASE Shop_DB;

USE Shop_DB;

CREATE TABLE Customer (
    Customer_id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(10),
    Gender CHAR(1),
    Date_of_birth DATE,
    Customer_type VARCHAR(20)
);

CREATE TABLE Category (
    Category_id INT PRIMARY KEY,
    Category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Product (
    Product_id INT PRIMARY KEY,
    Product_name VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT DEFAULT 0,
    Category_id INT NOT NULL,
    FOREIGN KEY (Category_id) REFERENCES Category(Category_id)
);

CREATE TABLE Orders (
    Order_id INT PRIMARY KEY,
    Order_date DATE NOT NULL,
    Customer_id INT,
    Status VARCHAR(20),
    FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id)
);

CREATE TABLE Order_Detail (
    Order_detail_id INT PRIMARY KEY,
    Order_id INT,
    Product_id INT,
    Quantity INT NOT NULL,
    Unit_price DECIMAL(10,2),
    FOREIGN KEY (Order_id) REFERENCES Orders(Order_id),
    FOREIGN KEY (Product_id) REFERENCES Product(Product_id)
);

INSERT INTO Customer
(Name, Email, Phone, Gender, Date_of_birth, Customer_type)
VALUES
('Nguyen Van A', 'vana@gmail.com', '0901111111', 'M', '2002-05-10', 'VIP'),
('Tran Thi B', 'thib@gmail.com', '0902222222', 'F', '2004-08-15', 'Normal'),
('Le Van C', 'vanc@gmail.com', '0903333333', 'M', '2001-11-20', 'VIP'),
('Pham Thi D', 'thid@gmail.com', '0904444444', 'F', '2005-03-25', 'Normal'),
('Hoang Van E', 'vane@gmail.com', '0905555555', 'M', '2003-12-01', 'VIP');

INSERT INTO Category (Category_id, Category_name)
VALUES
(1, 'Dien tu'),
(2, 'Thoi trang'),
(3, 'Gia dung'),
(4, 'Sach'),
(5, 'My pham');

INSERT INTO Product
(Product_id, Product_name, Price, Stock, Category_id)
VALUES
(1, 'Iphone 15', 25000000, 10, 1),
(2, 'Laptop Dell', 18000000, 5, 1),
(3, 'Ao Hoodie', 500000, 20, 2),
(4, 'Noi chien khong dau', 2000000, 8, 3),
(5, 'Sach SQL', 150000, 15, 4);

INSERT INTO Orders
(Order_id, Order_date, Customer_id, Status)
VALUES
(1, '2026-05-01', 1, 'Completed'),
(2, '2026-05-02', 2, 'Completed'),
(3, '2026-05-03', 3, 'Cancelled'),
(4, '2026-05-04', 1, 'Completed'),
(5, '2026-05-05', 4, 'Completed');

INSERT INTO Order_Detail
(Order_detail_id, Order_id, Product_id, Quantity, Unit_price)
VALUES
(1, 1, 1, 1, 25000000),
(2, 1, 3, 2, 500000),
(3, 2, 2, 1, 18000000),
(4, 3, 5, 3, 150000),
(5, 4, 4, 1, 2000000);

UPDATE Product
SET Price = 27000000
WHERE Product_id = 1;

UPDATE Customer
SET Email = 'newemail@gmail.com'
WHERE Customer_id = 2;

DELETE FROM Order_Detail
WHERE Order_detail_id = 5;

SELECT
    Customer_id AS MaKhachHang,
    Name AS HoTen,
    Email AS Email,
    CASE
        WHEN Gender = 'M' THEN 'Nam'
        WHEN Gender = 'F' THEN 'Nu'
        ELSE 'Khac'
    END AS GioiTinh
FROM Customer;

SELECT
    Customer_id AS MaKhachHang,
    Name AS HoTen,
    Email AS Email,
    YEAR(NOW()) - YEAR(Date_of_birth) AS Tuoi
FROM Customer
ORDER BY Tuoi ASC
LIMIT 3;

SELECT
    o.Order_id AS MaDonHang,
    c.Name AS TenKhachHang,
    o.Order_date AS NgayDatHang,
    o.Status AS TrangThai
FROM Orders o
INNER JOIN Customer c
ON o.Customer_id = c.Customer_id;

SELECT
    c.Category_id AS MaDanhMuc,
    c.Category_name AS TenDanhMuc,
    COUNT(p.Product_id) AS SoLuongSanPham
FROM Category c
INNER JOIN Product p
ON c.Category_id = p.Category_id
GROUP BY c.Category_id, c.Category_name
HAVING COUNT(p.Product_id) >= 2;

SELECT
    Product_id AS MaSanPham,
    Product_name AS TenSanPham,
    Price AS GiaBan
FROM Product
WHERE Price > (
    SELECT AVG(Price)
    FROM Product
);

SELECT
    Customer_id AS MaKhachHang,
    Name AS HoTen,
    Email AS Email
FROM Customer
WHERE Customer_id NOT IN (
    SELECT Customer_id
    FROM Orders
    WHERE Customer_id IS NOT NULL
);

SELECT
    c.Category_id AS MaDanhMuc,
    c.Category_name AS TenDanhMuc,
    SUM(od.Quantity * od.Unit_price) AS TongDoanhThu
FROM Category c
INNER JOIN Product p
ON c.Category_id = p.Category_id
INNER JOIN Order_Detail od
ON p.Product_id = od.Product_id
INNER JOIN Orders o
ON od.Order_id = o.Order_id
WHERE o.Status <> 'Cancelled'
GROUP BY c.Category_id, c.Category_name
HAVING SUM(od.Quantity * od.Unit_price) > (
    SELECT AVG(category_revenue) * 1.2
    FROM (
        SELECT
            SUM(od2.Quantity * od2.Unit_price) AS category_revenue
        FROM Category c2
        INNER JOIN Product p2
        ON c2.Category_id = p2.Category_id
        INNER JOIN Order_Detail od2
        ON p2.Product_id = od2.Product_id
        INNER JOIN Orders o2
        ON od2.Order_id = o2.Order_id
        WHERE o2.Status <> 'Cancelled'
        GROUP BY c2.Category_id
    ) AS revenue_table
);

SELECT
    p.Product_id AS MaSanPham,
    p.Product_name AS TenSanPham,
    p.Price AS GiaBan,
    c.Category_name AS TenDanhMuc
FROM Product p
INNER JOIN Category c
ON p.Category_id = c.Category_id
WHERE p.Price = (
    SELECT MAX(p2.Price)
    FROM Product p2
    WHERE p2.Category_id = p.Category_id
);

SELECT
    Name AS HoTenKhachVIP
FROM Customer
WHERE Customer_type = 'VIP'
AND Customer_id IN (
    SELECT Customer_id
    FROM Orders
    WHERE Order_id IN (
        SELECT Order_id
        FROM Order_Detail
        WHERE Product_id IN (
            SELECT Product_id
            FROM Product
            WHERE Category_id IN (
                SELECT Category_id
                FROM Category
                WHERE Category_name = 'Dien tu'
            )
        )
    )
);
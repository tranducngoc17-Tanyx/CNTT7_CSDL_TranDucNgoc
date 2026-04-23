CREATE TABLE SHIPPERS (
    ShipperID INT PRIMARY KEY AUTO_INCREMENT,
    ShipperName VARCHAR(255),
    Phone VARCHAR(20)
);

INSERT INTO SHIPPERS (ShipperName, Phone) 
VALUES ('Giao Hàng Nhanh', '0901234567');

INSERT INTO SHIPPERS (ShipperName, Phone) 
VALUES ('Viettel Post', '0987654321');

-- Phân tích nguyên nhân lỗi:
-- 1. Lỗi cú pháp (Syntax Error): Ở dòng lệnh đầu tiên, chuỗi 'Giao Hàng Nhanh bị thiếu một dấu nháy đơn đóng ở cuối. Kiểu dữ liệu chuỗi (VARCHAR) luôn phải được bọc kín trong cặp dấu nháy đơn.
-- 2. Lỗi kẹt dữ liệu (Cột Phone bị NULL): Câu lệnh thứ hai không khai báo danh sách cột mục tiêu phía sau tên bảng. Việc khai báo tường minh tên các cột (ShipperName, Phone) giúp hệ quản trị cơ sở dữ liệu ánh xạ chính xác dữ liệu đầu vào, đảm bảo không có cột nào bị thiếu thông tin hoặc nhận giá trị rỗng sai nghiệp vụ.
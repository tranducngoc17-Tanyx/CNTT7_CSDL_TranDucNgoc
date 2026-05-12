CREATE DATABASE HospitalIndexDB;
USE HospitalIndexDB;

CREATE TABLE Patients (
    Patient_ID INT PRIMARY KEY AUTO_INCREMENT,
    Full_Name VARCHAR(100),
    Phone VARCHAR(20),
    Age INT,
    Address VARCHAR(255)
);

DELIMITER //

CREATE PROCEDURE SeedPatients()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 500000 DO
        INSERT INTO Patients (Full_Name, Phone, Age, Address)
        VALUES (
            CONCAT('Patient ', i),
            CONCAT('090', LPAD(i, 7, '0')),
            FLOOR(RAND() * 100),
            'Ho Chi Minh City'
        );

        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL SeedPatients();

SELECT * 
FROM Patients
WHERE Phone = '0900001000';

EXPLAIN
SELECT * 
FROM Patients
WHERE Phone = '0900001000';

CREATE INDEX idx_phone
ON Patients(Phone);

SELECT * 
FROM Patients
WHERE Phone = '0900001000';

EXPLAIN
SELECT * 
FROM Patients
WHERE Phone = '0900001000';

DROP PROCEDURE IF EXISTS InsertTest;

DELIMITER //

CREATE PROCEDURE InsertTest()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1000 DO
        INSERT INTO Patients (Full_Name, Phone, Age, Address)
        VALUES (
            CONCAT('New Patient ', i),
            CONCAT('091', LPAD(i, 7, '0')),
            FLOOR(RAND() * 100),
            'Ha Noi'
        );

        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL InsertTest();

-- Nhận xét:
-- Trước khi tạo Index, câu lệnh SELECT sẽ quét toàn bộ bảng nên chậm hơn.
-- Sau khi tạo INDEX trên cột Phone, tốc độ tìm kiếm tăng đáng kể.
-- Tuy nhiên, thao tác INSERT sẽ chậm hơn một chút vì Database phải cập nhật thêm dữ liệu cho Index.
-- Đây là sự “đánh đổi” giữa hiệu năng đọc dữ liệu (SELECT) và ghi dữ liệu (INSERT/UPDATE).
-- Cách 1 (Bad Practice - lọc trễ)

SELECT hotel_id, COUNT(*) AS total_orders, AVG(total_price) AS avg_revenue
FROM Bookings
GROUP BY hotel_id
HAVING 
    SUM(CASE WHEN status = 'COMPLETED' THEN 1 ELSE 0 END) >= 50  
    AND AVG(total_price) > 3000000;                             

-- Vấn đề:
-- 1. GROUP BY toàn bộ dữ liệu (cả đơn lỗi, hủy, rác)
-- 2. Tốn RAM + CPU vì phải gom nhóm dữ liệu lớn trước
-- 3. Sau đó mới lọc → rất nặng khi data lớn

-- ✅ Cách 2 (Tối ưu - lọc sớm bằng WHERE)

SELECT hotel_id,
       COUNT(*) AS total_orders,
       AVG(total_price) AS avg_revenue
FROM Bookings
WHERE status = 'COMPLETED'        -- lọc sớm → giảm dữ liệu trước khi GROUP
GROUP BY hotel_id
HAVING 
    COUNT(*) >= 50                -- ì đã chỉ còn đơn completed
    AND AVG(total_price) > 3000000;
-- Cách viết sai (thường gặp)

SELECT user_id, COUNT(*) AS total_orders
FROM Bookings
WHERE status = 'CANCELLED'   -- Sai: lọc ở WHERE làm mất các đơn khác
GROUP BY user_id
HAVING COUNT(*) >= 10 AND COUNT(*) > 5;

-- Sai:
-- 1. WHERE status = 'CANCELLED' → chỉ còn đơn bị hủy → không còn tổng đơn thật
-- 2. COUNT(*) lúc này = số đơn hủy, không phải tổng đơn
-- -> không thể kiểm tra đồng thời 2 điều kiện

-- Cách đúng (dùng CASE WHEN để đếm có điều kiện)

SELECT user_id, COUNT(*) AS total_orders,  
SUM(CASE 
	WHEN status = 'CANCELLED' THEN 1 
	ELSE 0 
	END) AS cancelled_orders
FROM Bookings
GROUP BY user_id
HAVING COUNT(*) >= 10 
AND SUM (CASE 
	WHEN status = 'CANCELLED' THEN 1 
ELSE 0 END) > 5;            
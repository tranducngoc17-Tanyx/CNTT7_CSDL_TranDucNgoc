SELECT hotel_id, room_name, MIN(price_per_night)
FROM Rooms
GROUP BY hotel_id;

-- Sai:
-- 1. room_name không nằm trong GROUP BY
-- 2. room_name cũng không phải hàm tổng hợp
-- Trong 1 hotel có nhiều phòng → nhiều room_name
-- MySQL không biết lấy room_name nào → lỗi ONLY_FULL_GROUP_BY

/* Phân tích ngắn:
GROUP BY hotel_id → gom nhiều phòng của 1 khách sạn
MIN(price_per_night) → hợp lệ (hàm tổng hợp)
room_name → không xác định vì có nhiều giá trị trong nhóm
*/

-- Sửa đúng theo yêu cầu (chỉ lấy giá rẻ nhất mỗi hotel)

SELECT hotel_id, MIN(price_per_night) AS min_price
FROM Rooms
GROUP BY hotel_id;
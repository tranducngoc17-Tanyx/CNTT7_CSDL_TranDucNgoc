SELECT restaurant_name, created_at
FROM Restaurants
LIMIT 5;
/* Phân tích
1. Không có ORDER BY nên dữ liệu trả ngâu nhiên 
2. Không đảm bảo 5 quán mới nhất
3. Mỗi làn refresh là mỗi kết quả khác nhau
*/

-- Sửa lại
SELECT restaurant_name, created_at
FROM Restaurants
group by created_at desc
limit 5;


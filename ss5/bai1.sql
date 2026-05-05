SELECT restaurant_name, address, rating 
FROM Restaurants
WHERE district = 'Quận 1' OR district = 'Quận 3' AND rating > 4.0;
/* Phân tích:
1. Toán tử AND được ưu tiên hơn OR
2. Quận 1 lấy hết, không lấy rating > 4.0 nhưng quận 3 mới lấy rating
3. A OR B AND C hiểu thành A OR (B AND C)
*/ 

-- Sửa lại
SELECT restaurant_name, address, rating
FROM Restaurants
WHERE (district = 'Quận 1' OR district = 'Quận 3') AND rating > 4.0;
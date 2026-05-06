SELECT city, SUM(total_price) AS revenue
FROM Bookings
WHERE status = 'COMPLETED'
      AND SUM(total_price) > 0   -- Sai: WHERE chạy trước GROUP BY nên chưa có SUM()
GROUP BY city;

/* Sửa lại */

SELECT city, SUM(total_price) AS revenue
FROM Bookings
WHERE status = 'COMPLETED'       -- lọc từng dòng
GROUP BY city
HAVING SUM(total_price) > 0;     -- lọc sau khi đã GROUP + SUM 
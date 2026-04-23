INSERT INTO CART_ITEMS (UserID, ProductID, Quantity) 
VALUES (1, 101, 1);

SELECT CartItemID, ProductID, Quantity, AddedDate 
FROM CART_ITEMS 
WHERE UserID = 1;

UPDATE CART_ITEMS 
SET Quantity = 5 
WHERE UserID = 1 AND ProductID = 101;

DELETE FROM CART_ITEMS 
WHERE UserID = 1 AND ProductID = 101;

-- Phân tích luồng xử lý bẫy dữ liệu (Edge Cases):
-- 1. Xử lý số lượng âm: Ứng dụng không được phép truyền tham số số âm vào lệnh UPDATE. Nếu người dùng cố tình nhập số <= 0, luồng chuẩn của hệ thống là tự động chuyển hướng sang gọi câu lệnh DELETE để gỡ sản phẩm đó khỏi giỏ hàng thay vì cập nhật.
-- 2. Trùng sản phẩm đã có trong giỏ: Tuyệt đối không dùng lệnh INSERT tạo thêm dòng mới để tránh rác dữ liệu và hiển thị trùng lặp. Luồng chuẩn là thiết lập ràng buộc duy nhất (UNIQUE) cho cặp (UserID, ProductID), sau đó gọi lệnh UPDATE để cộng dồn số lượng (Quantity = Quantity + 1).
-- 3. Chốt chặn bảo vệ giỏ hàng: Trong các câu lệnh SELECT, UPDATE và DELETE, mệnh đề WHERE bắt buộc phải luôn có mặt điều kiện UserID = [ID định danh của khách hàng]. Đây là chìa khóa để cô lập dữ liệu, đảm bảo không ai có thể can thiệp vào giỏ hàng của người khác.
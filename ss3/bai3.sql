SELECT FullName, Email
FROM CUSTOMERS
WHERE City = 'Hà Nội' 
  AND LastPurchaseDate <= '2025-10-01' 
  AND Email IS NOT NULL 
  AND Status = 'Active';

-- Phân tích I/O: Input quét từ bảng CUSTOMERS. Output chỉ lấy 2 cột là FullName và Email theo đúng nhu cầu gửi thư.
-- Sai lầm của SELECT *: Bảng CUSTOMERS chứa hàng triệu bản ghi với hàng chục cột. Việc dùng SELECT * sẽ kéo theo một lượng dữ liệu rác khổng lồ (Ngày sinh, Điểm thưởng, Địa chỉ...) không cần thiết, làm tiêu tốn RAM, nghẽn băng thông mạng và sập hệ thống gửi mail.
-- Thiết kế giải pháp lọc: Mệnh đề WHERE cần 4 điều kiện ràng buộc đồng thời (dùng AND). Lọc khách ở Hà Nội, thời gian mua hàng cuối cùng từ 01/10/2025 trở về trước (hơn 6 tháng so với 01/04/2026), loại bỏ bẫy thiếu email (Email IS NOT NULL) và bẫy tài khoản bị khóa (Status = 'Active').
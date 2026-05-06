-- 1. Bẫy dữ liệu logic (Thảm họa NOT IN và NULL)
-- Trong SQL, NULL không phải là một giá trị rỗng hay số 0, mà nó mang ý nghĩa là "Không xác định" (Unknown). SQL sử dụng logic 3 trạng thái (True, False, Unknown).
-- Khi bạn viết WHERE room_id NOT IN (SELECT room_id FROM Bookings), cơ sở dữ liệu sẽ diễn dịch mệnh đề này thành một chuỗi các phép toán AND.
-- Giả sử trong bảng Bookings có các room_id là (1, 2, NULL). Nếu ta đang xét room_id = 3 từ bảng Rooms, phép toán sẽ được mở rộng ra như sau:
-- 3 <> 1 (Đúng - True) AND 3 <> 2 (Đúng - True) AND 3 <> NULL
-- Lúc này thảm họa xảy ra ở phép toán 3 <> NULL. Vì NULL là "không xác định", nên việc so sánh một số với "không xác định" cũng sẽ trả về kết quả là "Không xác định" (Unknown), chứ không phải True hay False.
-- Do cấu trúc là chuỗi AND, kết quả cuối cùng của True AND True AND Unknown sẽ bị đánh giá là Unknown. Vì điều kiện WHERE chỉ giữ lại các dòng có kết quả là True, dòng dữ liệu này bị loại bỏ. Hậu quả là toàn bộ câu truy vấn trả về rỗng (0 kết quả) chỉ vì dính một giá trị NULL.
-- 2. Thiết kế giải pháp an toàn
-- Để né bẫy này, chúng ta có 2 hướng giải quyết an toàn và phổ biến nhất:
-- Cách 1: Sửa lại Subquery (Vá lỗi NOT IN): Bổ sung thêm điều kiện lọc IS NOT NULL ngay bên trong câu truy vấn con để triệt tiêu mầm mống gây lỗi.
-- WHERE room_id NOT IN (SELECT room_id FROM Bookings WHERE room_id IS NOT NULL)
-- Cách 2: Chuyển sang mô hình Anti-Join bằng LEFT JOIN và IS NULL (Khuyên dùng): Ghép nối bảng Rooms (trái) với bảng Bookings (phải). Dữ liệu phòng nào chưa từng được đặt sẽ không có thông tin khớp ở bảng bên phải, khiến cho các cột dữ liệu của bảng phải tự động nhận giá trị NULL. Sau đó, ta chỉ cần dùng WHERE để nhặt những dòng có giá trị NULL này ra.
SELECT 
    r.room_id, 
    r.room_name
FROM Rooms r
LEFT JOIN Bookings b ON r.room_id = b.room_id
WHERE b.room_id IS NULL;
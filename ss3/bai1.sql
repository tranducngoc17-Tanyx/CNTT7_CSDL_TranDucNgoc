-- thiếu where nên update toàn bộ bảng và sản phẩm đều bị giảm giá 10%
update PRODUCT
set OriginalPrice = OriginalPrice * 0.9;


-- cách đúng là kiểm tra những dòng sẽ bị lỗi. Sau đó, thực hiện update đúng đối tưởng
select * from PRODUCTS
where Category = 'Electronics';

update PRODUCTS
set OriginalPrice = 0.9
where Category = 'Electronics';
 
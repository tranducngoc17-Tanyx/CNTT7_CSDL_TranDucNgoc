-- Phần A phân tích
-- vi phạm tính atomicity trong acid.
-- quá trình chuyển giường phải thực hiện toàn bộ hoặc hủy toàn bộ.
-- hiện tại chỉ giải phóng giường cũ nhưng chưa gán giường mới,
-- làm dữ liệu bệnh nhân không còn thuộc giường nào.

-- phần B sửa chữa mã nguồn
drop procedure if exists transferbed;

delimiter //

create procedure transferbed(
    in p_patient_id int,
    in p_new_bed_id int
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
    end;

    start transaction;

    update beds
    set patient_id = null
    where patient_id = p_patient_id;

    update beds
    set patient_id = p_patient_id
    where bed_id = p_new_bed_id;

    commit;

end //

delimiter ;

call transferbed(1,5);

select * from beds
where patient_id = 1;

select * from beds
where bed_id = 5;
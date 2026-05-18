drop procedure if exists dispensmedicine;
delimiter //

create procedure dispensmedicine(
    in p_patient_id int,
    in p_medicine_id int,
    in p_quantity int,
    out p_message varchar(100)
)
begin

    declare v_stock int;
    declare v_price decimal(10,2);

    declare exit handler for sqlexception
    begin
        rollback;
        set p_message='loi: giao dich that bai';
    end;

    start transaction;

    select stock_quantity
    into v_stock
    from medicines
    where medicine_id = p_medicine_id;

    if v_stock < p_quantity then

        rollback;
        set p_message='loi: so luong ton kho khong du';

    else

        update medicines
        set stock_quantity = stock_quantity - p_quantity
        where medicine_id = p_medicine_id;

        select price
        into v_price
        from medicines
        where medicine_id = p_medicine_id;

        update patient_invoices
        set total_due = total_due + (p_quantity * v_price)
        where patient_id = p_patient_id;

        commit;

        set p_message='da cap phat thanh cong';

    end if;

end //

delimiter ;

call dispensmedicine(
    1,
    1,
    3,
    @message
);
select @message;

call dispensmedicine(
    1,
    1,
    10,
    @message
);
select @message;
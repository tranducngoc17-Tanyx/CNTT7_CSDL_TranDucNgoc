-- Cach 1
ALTER TABLE USERS 
MODIFY Phone varchar(15);

-- Cach 2
ALTER TABLE USERS ADD Phone_new varchar(15);

UPDATE USERS 
SET Phone_new = CAST(Phone AS CHAR);

ALTER TABLE USERS DROP COLUMN Phone;

ALTER TABLE USERS 
change Phone_new Phone varchar(15);
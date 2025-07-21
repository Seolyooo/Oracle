/*
2025/07/17
설유진
5장 데이터베이스 객체


*/

//워크북 p13
--실습하기 3-1
select * from dictionary;
select table_name from user_tables; 

select owner, table_name from all_tables;
select * from dba_tables;

select * from dba_tables;
select * from dba_users;

select instance_name, status , database_status ,host_name from V$INSTANCE;


--실습하기 3-2

select * from user_indexes;
select * from user_ind_columns;

--실습하기 3-3
create index inx_user1_id on USER1(USER_ID);

SELECT * FROM USER_IND_COLUMNS;

DROP INDEX inx_user1_id;
SELECT * FROM USER_IND_COLUMNS;

--실습하기 3-6

CREATE VIEW VW_USER1 AS (SELECT NAME ,HP, AGE FROM USER1);
create view vm_user2_age_under30 as(select * from user2 where age<30);


select * from VW_USER1;
select * from vm_user2_age_under30;


drop view VW_USER1;
drop view vm_user2_age_under30;

-- 실습하기 3-9
create table user6(
    seq number primary key,
    name varchar2(20),
    gender char(1),
    age number,
    addr varchar2(255)
);

-- 실습하기 3-10
CREATE SEQUENCE SEQ_USER6 INCREMENT BY 1 START WITH 1;

-- 실습하기 3-11
insert into user6 values (seq_user6.nextval, '김유신','m',25,'김해');

insert into user6 values (seq_user6.nextval, '김춘추','m',23,'경주');
insert into user6 values (seq_user6.nextval, '심사임당','f',27,'강릉');



--실습하기





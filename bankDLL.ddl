
CREATE TABLE account (
    acc_id            CHAR(14) NOT NULL,
    cust_jumin        CHAR(14),
    acc_type          VARCHAR2(20) NOT NULL,
    acc_balance       NUMBER NOT NULL,
    acc_card          CHAR(1) NOT NULL,
    acc_register_date DATE
);

ALTER TABLE account ADD CONSTRAINT account_pk PRIMARY KEY ( acc_id );

CREATE TABLE card (
    card_no            CHAR(14) NOT NULL,
    cust_jumin         CHAR(14),
    acc_id             CHAR(14),
    card_register_date DATE,
    card_limit         NUMBER,
    card_approve_date  DATE,
    card_type          VARCHAR2(10) NOT NULL
);

ALTER TABLE card ADD CONSTRAINT card_pk PRIMARY KEY ( card_no );

CREATE TABLE customer (
    cust_jumin CHAR(14) NOT NULL,
    name       VARCHAR2(20) NOT NULL,
    address    VARCHAR2(100) NOT NULL,
    birth      CHAR(10) NOT NULL,
    email      VARCHAR2(100),
    hp         VARCHAR2(20) NOT NULL,
    job        VARCHAR2(20) NOT NULL
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( cust_jumin );

CREATE TABLE transcation (
    trans_id      NUMBER NOT NULL,
    trans_acc_id  CHAR(14) NOT NULL,
    trans_type    VARCHAR2(20),
    trans_message VARCHAR2(20),
    trans_money   NUMBER,
    trans_date    DATE NOT NULL
);

ALTER TABLE transcation ADD CONSTRAINT transcation_pk PRIMARY KEY ( trans_id );

ALTER TABLE account
    ADD CONSTRAINT account_customer_fk FOREIGN KEY ( cust_jumin )
        REFERENCES customer ( cust_jumin );

ALTER TABLE card
    ADD CONSTRAINT card_account_fk FOREIGN KEY ( acc_id )
        REFERENCES account ( acc_id );

ALTER TABLE card
    ADD CONSTRAINT card_customer_fk FOREIGN KEY ( cust_jumin )
        REFERENCES customer ( cust_jumin );

ALTER TABLE transcation
    ADD CONSTRAINT transcation_account_fk FOREIGN KEY ( trans_acc_id )
        REFERENCES account ( acc_id );


CREATE SEQUENCE trans_seq
START WITH 1       
INCREMENT BY 1     
NOCACHE            
NOCYCLE;          

CREATE OR REPLACE TRIGGER trg_trans_id
BEFORE INSERT ON transcation
FOR EACH ROW
BEGIN
    IF :NEW.trans_id IS NULL THEN
        SELECT trans_seq.NEXTVAL
        INTO :NEW.trans_id
        FROM dual;
    END IF;
END;
/

-- 데이터 입력
insert into customer values ('760121-1234567','정우성','서울','1976-01-21',null,'010-1101-7601','배우');
insert into customer values ('750611-1234567','이정재','서울','1975-06-11',null,'010-1102-7506','배우');
insert into customer values ('890530-1234567','전지현','대전','1989-05-30','jjh@naver.com','010-1103-8905','자영업');
insert into customer values ('790413-1234567','이나영','대전','1979-04-13','lee@naver.com','010-2101-7904','회사원');
insert into customer values ('660912-1234567','원빈','대전','1966-09-12','one@daum.net','010-2104-6609','배우');


insert into card values ('2111-1001-1001','760121-1234567','1011-1001-1001','2020-01-21',1000000,'2020-02-10','check');
insert into card values ('2041-1001-1002','890530-1234567','1011-1001-1002','2020-06-11',3000000,'2020-06-15','check');
insert into card values ('2011-1001-1003','790413-1234567','1011-1001-1003','2020-05-30',5000000,'2020-06-25','check');
insert into card values ('2611-1001-1005','750611-1234567','1011-1002-1005','2020-09-12',1500000,'2020-10-10','check');


INSERT INTO account
VALUES ('1011-1001-1001','760121-1234567','자유입출금',4160000,'y',TO_DATE('2020-01-21 13:00:02', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO account
VALUES ('1011-1001-1002','890530-1234567','자유입출금',376000,'y',TO_DATE('2020-06-11 13:00:02', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO account
VALUES ('1011-1001-1003','790413-1234567','자유입출금',1200000,'y',TO_DATE('2020-05-30 13:00:02', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO account
VALUES ('1011-1001-1004','660912-1234567','정기적금',1000000,'y',TO_DATE('2020-04-13 13:00:02', 'YYYY-MM-DD HH24:MI:SS'));


DELETE FROM account WHERE acc_id = '1011-1001-1005';

INSERT INTO account
VALUES ('1011-1002-1005','750611-1234567','자유입출금',820000,'y',TO_DATE('2020-09-12 13:00:02', 'YYYY-MM-DD HH24:MI:SS'));
---------------------------
INSERT INTO transcation (trans_acc_id, trans_type, trans_message, trans_money, trans_date)
VALUES ('1011-1001-1001', '입금', '2월 정기급여', 3500000, TO_DATE('2020-02-10 12:36:12', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO transcation (trans_acc_id, trans_type, trans_message, trans_money, trans_date)
VALUES ('1011-1001-1003', '출금', 'atm 출금', 300000, TO_DATE('2020-02-10 12:37:12', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO transcation (trans_acc_id, trans_type, trans_message, trans_money, trans_date)
VALUES ('1011-1001-1002', '입금', '2월 급여', 2800000, TO_DATE('2020-02-10 12:38:12', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO transcation (trans_acc_id, trans_type, trans_message, trans_money, trans_date)
VALUES ('1011-1001-1001', '출금', '2월 공과금', 116200, TO_DATE('2020-02-10 12:39:12', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO transcation (trans_acc_id, trans_type, trans_message, trans_money, trans_date)
VALUES ('1011-1002-1005', '출금', 'atm 출금', 50000, TO_DATE('2020-02-10 12:40:12', 'YYYY-MM-DD HH24:MI:SS'));


----------
--1
select * from customer;
--2
select * from card;
--3
select * from account;
--4
select * from transcation order by trans_date desc fetch first 3 rows only;
--5
select name,b.card_type 
    from customer a 
    join card b on a.cust_jumin=b.cust_jumin 
    where b.card_limit >= 2000000;
    
--6
select trans_acc_id,count(*)
    from transcation
    group by trans_acc_id
    order by count(*) desc;
--7
select * from transcation where trans_money>=1000000 order by trans_date desc;
--8
select c.acc_id as 계좌번호 ,card_no as 카드번호, card_type as 카드타입 
    from card c join account a on c.acc_id = a.acc_id;
    
--9
select sum(trans_money) from transcation where trans_type='입금';

--10
select c.name as 고객명, a.cust_jumin as 주민번호 ,hp as 전화번호, address as 주소
    from account a 
    join customer c on a.cust_jumin= c.cust_jumin
    where acc_balance >=4000000;


/*

날짜 :  2025/07/21
이름 : 설유진
내용 : sql 연습문제2
*/

-- 실습2-2
Create table student(
    stdno char(8) primary key,
    name varchar2(20) not null,
    birth date not null,
    major varchar2(20),
    enr_date date  not null
);
drop table course;
create table course(
    cs_id number(4) primary key,
    cs_name varchar(40) not null,
    cs_credit number(1) not null,
    cs_dept varchar(20) not null
);
create table enrollment(
    enr_no number GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    enr_stdno char(8) not null,
    enr_csid number(4),
    mid_score number,
    final_score number,
    total_score number,
    grade char(1)
);
-- 실습2-3
insert into student values('20121016','김유신','1991-01-13','국문학과','2012-02-01');
insert into student values('20111126','김춘추','1992-04-11','경제학과','2011-02-01');
insert into student values('20100216','장보고','1991-05-23','컴퓨터학과','2010-02-01');
insert into student values('20120326','강감찬','1991-02-09','영문학과','2012-02-01');
insert into student values('20130416','이순신','1992-11-30','경영학과','2012-02-01');
insert into student values('20110521','송상현','1992-07-17','컴퓨터학과','2011-02-01');

insert into course values(1059,'고전문학',3,'국문학과');
insert into course values(2312,'데이터베이스',3,'컴퓨터학과');
insert into course values(1203,'EasyWriting',3,'경제학과');
insert into course values(2039,'글로벌경제학',3,'경제학과');
insert into course values(2301,'프로그래밍언어',3,'컴퓨터학과');
insert into course values(2303,'컴퓨터과학개론',2,'컴퓨터학과');
insert into course values(3012,'마케팅전략',2,'국문학과');


insert into enrollment (ENR_STDNO,ENR_CSID,MID_SCORE,FINAL_SCORE,TOTAL_SCORE,GRADE)values ('20111126',1203,null,null,null,null);
insert into enrollment (ENR_STDNO,ENR_CSID,MID_SCORE,FINAL_SCORE,TOTAL_SCORE,GRADE)values ('20121016',2301,null,null,null,null);
insert into enrollment (ENR_STDNO,ENR_CSID,MID_SCORE,FINAL_SCORE,TOTAL_SCORE,GRADE)values ('20121016',2303,null,null,null,null);
insert into enrollment (ENR_STDNO,ENR_CSID,MID_SCORE,FINAL_SCORE,TOTAL_SCORE,GRADE)values ('20111126',2039,null,null,null,null);
insert into enrollment (ENR_STDNO,ENR_CSID,MID_SCORE,FINAL_SCORE,TOTAL_SCORE,GRADE)values ('20100216',3012,null,null,null,null);
insert into enrollment (ENR_STDNO,ENR_CSID,MID_SCORE,FINAL_SCORE,TOTAL_SCORE,GRADE)values ('20120326',3012,null,null,null,null);
insert into enrollment (ENR_STDNO,ENR_CSID,MID_SCORE,FINAL_SCORE,TOTAL_SCORE,GRADE)values ('20121016',2312,null,null,null,null);
insert into enrollment (ENR_STDNO,ENR_CSID,MID_SCORE,FINAL_SCORE,TOTAL_SCORE,GRADE)values ('20130416',3012,null,null,null,null);

-- 실습2-4
select * from student where major = '컴퓨터학과';
-- 실습2-5
select cs_name from course where cs_dept = '컴퓨터학과';

-- 실습2-6
select * from enrollment where enr_stdno = '20121016';
-- 실습2-7
select name,major,enr_date from student where major = '국문학과';
-- 실습2-8
select cs_id,cs_name,cs_credit,cs_dept from course where cs_credit =2 and cs_dept = '컴퓨터학과';
-- 실습2-9
select stdno, name, birth from student where birth like '1992%';
-- 실습2-10
update enrollment set mid_score = 36,final_score = 42
                            where enr_stdno = '20111126' and enr_csid=1203;
update enrollment  SET MID_SCORE = 24, FINAL_SCORE= 62 
WHERE ENR_STDNO='20121016' AND ENR_CSID=2301;
update enrollment  SET MID_SCORE = 28, FINAL_SCORE= 40 
WHERE ENR_STDNO='20121016' AND ENR_CSID=2303;
update enrollment  SET MID_SCORE = 37, FINAL_SCORE= 57 
WHERE ENR_STDNO='20111126' AND ENR_CSID=2039;
update enrollment SET MID_SCORE = 28, FINAL_SCORE= 68 
WHERE ENR_STDNO='20100216' AND ENR_CSID=3012;
update enrollment SET MID_SCORE = 16, FINAL_SCORE= 65 
WHERE ENR_STDNO='20120326' AND ENR_CSID=3012;
update enrollment  SET MID_SCORE = 18, FINAL_SCORE= 38 
WHERE ENR_STDNO='20121016' AND ENR_CSID=2312;
update enrollment SET MID_SCORE = 25, FINAL_SCORE= 58 
WHERE ENR_STDNO='20130416' AND ENR_CSID=3012;
SELECT * FROM enrollment;
-- 실습2-11
update enrollment set 
    total_score = mid_score + final_score,
    grade= case
        when(mid_score+final_score)>= 90 then 'A'
        when(mid_score+final_score)>= 80 then 'B'
        when(mid_score+final_score)>= 70 then 'C'
        when(mid_score+final_score)>= 60 then 'D'
        else 'F'
    end;

-- 실습2-12
select * from enrollment order by total_score desc;
-- 실습2-13
select * from enrollment where enr_csid = 3012 order by total_score desc;
-- 실습2-14
select cs_id, cs_name from course where cs_name in('데이터베이스','프로그래밍언어');
-- 실습2-15
select cs_name,cs_dept from course;
-- 실습2-16
select stdno ,name from student order by name;
-- 실습2-17
select distinct enr_stdno from enrollment;
-- 실습2-18
select max(total_score) as "가장큰총점" from enrollment;
-- 실습2-19
select major , count(*) as 학생수 from student group by major;
-- 실습2-20
select enr_csid,count(enr_csid) from enrollment group by enr_csid having count(enr_csid) >=2;
-- 실습2-21
select stdno,name,major, enr_csid,mid_score,final_score,total_score,grade
    from student S 
    join enrollment e on s.stdno = e.enr_stdno;
-- 실습2-22
select name, stdno, enr_csid
from student s
join enrollment e
on s.stdno = e.enr_stdno where enr_csid = 3012; 
-- 실습2-23
 SELECT
 stdNo,
 Name,
 COUNT(stdNo) AS "수강신청 건수",
 SUM(Total_Score) AS 종합점수,
 SUM(Total_Score) / COUNT(stdNo) AS 평균
FROM Student S
 JOIN ENROLLMENT E ON S.stdNo = E.ENR_STDNO
 group by stdno, name
 order by stdno;
 
-- 실습2-24
select enr_no,enr_stdno,cs_id,cs_name,cs_credit 
from enrollment e 
join course c on e.enr_csid = c.cs_id;

-- 실습2-25
SELECT
 COUNT(*) AS 마케팅_전략_수강_신청건수,
 AVG(TOTAL_SCORE) AS 마케팅_전략_평균
FROM Enrollment E
join course c on e.enr_csid = c.cs_id
where e.enr_csid =3012;
-- 실습2-26
SELECT 
ENR_StdNo, CS_Name
 FROM Enrollment E
 join course s ON e.enr_csid = c.cs_id
 where grade = 'A';
-- 실습2-27
 SELECT 
STDNO,
 NAME,
 MAJOR,
 ENR_CSID,
 CS_NAME,
 CS_CREDIT,
 TOTAL_SCORE,
 GRADE
 FROM Student S
   JOIN ENROLLMENT E ON S.stdNo = E.ENR_STDNO
  join course c ON e.enr_csid = c.cs_id;
-- 실습2-28
 SELECT
 stdNo,
 Name,
 CS_Name,
 TOTAL_SCORE,
 Grade
 FROM Student S
  JOIN ENROLLMENT E ON S.stdNo = E.ENR_STDNO
  join course c ON e.enr_csid = c.cs_id
  where e.grade = 'F';

-- 실습2-29
SELECT 
stdNo,
 Name,
 SUM(CS_Credit) AS 이수학점
FROM Student S
  JOIN ENROLLMENT E ON S.stdNo = E.ENR_STDNO
  join course c ON e.enr_csid = c.cs_id
  where grade != 'F'
  group by s.stdno,s.name;
-- 실습2-30
 SELECT 
S.STDNO, 
S.NAME, 
S.MAJOR
 FROM STUDENT S
 WHERE S.STDNO NOT IN (
    select enr_stdno from enrollment
  );
desc dept;
select empno,ename from emp;

select name,'good moring' "good morning" from professor;

select dname, 'it''s deptno', deptno "dname and deptno" from dept;

select profno, name, pay from professor;
select profno "prof'sno", name as "prof's name " , pay prof_pay from professor;

select  distinct deptno from emp;

select ename || job from emp;
select ename || ' ''s job is ' ||job from emp;


select * from student;

--연습문제1
select name || ' ''s ID :'||id||' , weight is '|| weight "id and weight" from student;

-- 연습문제2
select * from emp;
select ename||'('||job||'),'||ename||''''||job||'''' "name and job" from emp;

-- 연습문제 3
select ename|| '''s sal is $'||sal "name and sal" from emp;


-- 7. 원하는 조건만 골라내기 where
select empno ,ename from emp where empno = 7900;
select ename,sal from emp where sal <900;
select empno, ename,sal from emp where ename = 'SMITH';
select ename ,hiredate from emp where ename= 'SMITH';
select empno,ename,sal from emp where hiredate = '80/12/17';


--8.산술 연산자 사용하기
select ename ,sal from emp where deptno = 10; 
select ename, sal,sal +100 from emp where deptno = 10;
select ename, sal,sal *1.1 from emp where deptno= 10;

--9. 다양한 연산자 활용하기
select * from emp;
select empno,ename,sal from emp  where sal between 2000 and 3000;
select empno,ename,sal from emp where sal >=2000 and sal <=3000;

select ename from emp order by ename;
select ename from emp where ename between 'JAMES' and 'MART IN' order  by ename; 

select empno , ename, deptno from emp where deptno in (10,20);

select empno, ename, sal from emp where sal like '1%';
select empno, ename, sal from emp where ename like 'A%';
select empno, ename ,hiredate from emp where hiredate like '80%';
select empno,ename , hiredate from emp where hiredate like '___12%';

select empno,ename,comm from emp where deptno in(20,30);
select empno,ename,comm from emp where comm is null;
select empno,ename ,comm from emp where comm is not null;


select ename,hiredate, sal from emp where hiredate >'82/01/01' or sal >= 1300;


select empno, ename, sal 
    from emp
    where empno = &empno;
    
select empno ,ename ,sal from &table where sal = 3000;


--10. 정렬하여 출력하기
select ename,sal,hiredate from emp order by ename;

select deptno,sal ,ename from emp order by deptno asc,sal desc;

select ename,sal,hiredate from emp where sal >1000 order by 2,1;
-- 11. 집합연산자

select studno ,name ,deptno1 ,1 
    from student 
    where deptno1 = 101
    union all
    select profno, name, deptno,2
    from professor
    where deptno= 101;
    
select studno, name 
from student
where deptno1 =101
union 
select studno ,name 
from student
where deptno2= 201;

select studno, name
from student 
where deptno1=101
intersect
select studno, name
from student
where deptno2 = 201;

select empno, ename, sal 
from emp
minus
select empno,ename,sal
from emp
where sal>2500;

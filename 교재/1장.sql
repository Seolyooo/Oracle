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
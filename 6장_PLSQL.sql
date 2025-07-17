-- 실습 1-1
 set SERVEROUTPUT on;
 begin 
    dbms_output.put_line('hello');
end;
/
--실습1-2

 DECLARE
    NO   NUMBER(4) := 1001;
    NAME VARCHAR2(10) := '홍길동';
    HP   CHAR(13) := '010-1000-1001';    
    ADDR VARCHAR2(100) := '부산광역시';    
BEGIN    
    DBMS_OUTPUT.PUT_LINE('번호 : ' || NO);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('전화 : ' || HP);
    DBMS_OUTPUT.PUT_LINE('주소 : ' || ADDR);
 END;
 /
 -- 실습 2-1
SET SERVEROUTPUT ON;
 DECLARE
    NO   CONSTANT NUMBER(4) := 1001;
    NAME VARCHAR2(10);
    HP   CHAR(13) := '000-0000-0000';
    AGE  NUMBER(2) DEFAULT 1;
    ADDR VARCHAR2(10) NOT NULL := '부산';
 BEGIN
    NAME := '김유신';
    HP := '010-1000-1001';
    DBMS_OUTPUT.PUT_LINE('번호 : ' || NO);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('전화 : ' || HP);
    DBMS_OUTPUT.PUT_LINE('나이 : ' || AGE);
    DBMS_OUTPUT.PUT_LINE('주소 : ' || ADDR);
 END;
 /
  -- 실습하기 2-2
  declare 
    no dept.deptno%type;
    name dept.dname%type;
    dtel dept.dtel%type;
  begin
    select *
    into no,name, dtel
    from dept
    where deptno =30;
    
    dbms_output.put_line('부서번호: '|| no);
    dbms_output.put_line('부서명: '|| name);
    dbms_output.put_line('주소: '|| dtel);

  end;
 /
 
 
 declare 
     row _dept dept%rowtype;
 bigin
    select *
    into row_dept
    from dept
    where deptno=40;
    
    dbms_output.put_line('부서번호: '||row_dept.dpetno);
    dbms_output.put_line('부서명: '||row_dept.dname);
    dbms_output.put_line('주소: '||row_dept.loc);

 end;
 /
 
 -- 실습하기 2-4
DECLARE
    -- Record Define
    TYPE REC_DEPT IS RECORD (
        deptno  NUMBER(2),
        dname   DEPT.DNAME%TYPE,
        dtel     DEPT.dtel%TYPE
    );
    -- Record Declare
    dept_rec REC_DEPT;
 BEGIN
    -- Record Initialize
    dept_rec.deptno := 10;
    dept_rec.dname := '개발부';
    dept_rec.tel := '0512132';    
    -- Record Print
    DBMS_OUTPUT.PUT_LINE('deptno : ' || dept_rec.deptno);
    DBMS_OUTPUT.PUT_LINE('dname : ' || dept_rec.dname);
    DBMS_OUTPUT.PUT_LINE('dtel : ' || dept_rec.dtel);    
    DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
 END;
 /
 
 
 
 
delcare 
 type arr_city is table of varchar(20) index by pls_integer;
 arrcity arr_city;
begin   
    arrcity(1) := '서울';
    arrCity(2) := '대전';
    arrCity(3) := '대구';
    
    DBMS_OUTPUT.PUT_LINE('arrCity(1) : ' || arrCity(1));
    DBMS_OUTPUT.PUT_LINE('arrCity(2) : ' || arrCity(2));
    DBMS_OUTPUT.PUT_LINE('arrCity(3) : ' || arrCity(3));
    DBMS_OUTPUT.PUT_LINE('PL/SQL 종료...');
 END;
/


-- 실습 4-1

 declare
     v_dept_row dept%rowtype;
     
     cursor c2 is select * from dept where deptno =40;
 bigin
 
    open c1;
    
    fetch c1 into v_dept_row;
    
    dbms_output.put_line('Deptno : '|| V_dept_row.dptno);
    dbms_output.put_line('Dname : '|| V_dept_row.dname);
    dbms_output.put_line('dtel : '|| V_dept_row.dtel);

    close c1;
 end;
 /
 
declare
    CURSOR c1 IS SELECT * FROM DEPT;
bigin

    for c1_rec in c1 loop;
        DBMS_ OUTPUT.PUT_LINE('-------------');
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || c1_rec.DNAME);
        DBMS_OUTPUT.PUT_LINE('LOC : ' || c1_rec.LOC);
    END LOOP;
    
    end loop;
end;
/

-- 실습 4-2

 DECLARE 
 
    V_EMP_ROW EMP%ROWTYPE;
    CURSOR C1 IS SELECT * FROM EMP;
 BIGIN
    OPEN EMP_CURSUR;
    
    LOOP
        EXIT WHEN EMP_CURSOR%NOTFOUND;
        FETCH EMP_CUESUR INTO V_EMP_ROW;
        
        DBMS_OUTPUT.PUT_LINE('---------');
        DBMS_OUTPUT.PUT_LINE('EMPNO : '|| v_EMP.EMPNO);
        DBMS_OUTPUT.PUT_LINE('NAME : '|| v_EMP.EMPNO);
        DBMS_OUTPUT.PUT_LINE('REGDATE : '|| v_EMP.EMPNO);

    END LOOP;
 
 END;
 /
 
 -- 실습 5-1
 -- 프로시저 생성
CREATE PROCEDURE hello_procedure (
    p_name IN VARCHAR2
 )
 IS
 BEGIN
    DBMS_OUTPUT.PUT_LINE('안녕하세요, ' || p_name || '님!');
    DBMS_OUTPUT.PUT_LINE('환영합니다.');
 END;
 /-- 프로시저 실행1
 EXECUTE hello_procedure('홍길동');-- 프로시저 실행2
 EXECUTE hello_procedure('김철수');-- 프로시저 삭제
DROP PROCEDURE hello_procedure;



DROP FUNCTION GET_EMP_NAME;
-- 함수 생성
CREATE FUNCTION get_emp_name (p_empno NUMBER)
 RETURN VARCHAR2
 IS
    v_ename VARCHAR2(010);
 BEGIN
    SELECT ENAME
    INTO v_ename
    FROM EMP
    WHERE EMPNO = p_empno;
    RETURN v_ename;
 END;
 /-- 함수 실행
SELECT get_emp_name(0000) FROM DUAL;


CREATE TABLE emp_log (
 log_date DATE,
 empno NUMBER,
 action VARCHAR2(10)
 );
 -- 트리거 생성
CREATE TRIGGER trgg_emp_insert
 AFTER INSERT ON emp
 FOR EACH ROW
 BEGIN
 INSERT INTO emp_log (log_date, empno, action)
 VALUES (SYSDATE, :NEW.empno, 'INSERT');
 END;
 /-- INSERT 테스트
INSERT INTO emp (empno, ename, sal) VALUES (9999, '테스트', 1000);-- 로그 확인
SELECT * FROM emp_log;
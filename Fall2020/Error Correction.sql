set serveroutput on

DECLARE

  v_emp_no   emp.empno%TYPE
  v_ename    VARCHAR3(20);
  

BEGIN

  v_empno = 6;

  v_ename := Fred;

  SELECT ename
    FROM emp
   WHERE empno = 7876;

  SELECT empno
    INTO v_empno
    FROM emp;

  SELECT job
    INTO v_job
    FROM emp
   WHERE empno = 9483;

END;
/

SET SERVEROUTPUT ON

DECLARE
    -- EMPLOYEE CURSOR
    CURSOR c_employee IS
        SELECT *
        FROM emp
        FOR UPDATE;
    -- RECORDS
    r_employee c_employee%ROWTYPE;
    -- VARIABLES
    v_employee emp.empno%TYPE;
    v_salary emp.sal%TYPE;
    v_newSal emp.sal%TYPE;
    v_avg emp.sal%TYPE;
    v_presSal emp.sal%TYPE;
    v_lowCom emp.comm%TYPE;
    -- CONSTANTS
    k_president CONSTANT VARCHAR2(10) := 'PRESIDENT';
    k_fifty CONSTANT NUMBER(3,2) := 0.50;
    k_twentyFive CONSTANT NUMBER(3,2) := 0.25;
    k_hundred CONSTANT NUMBER(3) := 100;
    k_ten CONSTANT NUMBER(3,2) := 0.10;
    K_twentyTwo CONSTANT NUMBER(3,2) := 0.22;

BEGIN
-- ASSIGN FOR AVG SAL, PRES SAL, LOWEST COMM
SELECT AVG(sal)INTO v_avg FROM emp;
SELECT sal INTO v_presSal FROM emp WHERE job = k_president;

-- LOOP THROUGH EMPLOYEES
FOR r_employee IN c_employee LOOP

    -- SET EMPLOYEE ID AT CURRENT POSITION
    v_employee := r_employee.empno;

    -- CHECK IF EMPLOYEE SALARY > PRESIDENT SALARY
    IF (r_employee.sal > v_presSal) THEN
        -- CHECK IF 50% REDUCED EMPLOYEE SALARY IS STILL GREATER THAN 25% REDUCED PRESIDENT SALARY
        IF ((r_employee.sal * k_fifty) > (v_presSal - (v_presSal * k_twentyFive))) THEN
            -- EMPLOYEE GETS PRESIDENTS 25% REDUCED SALARY
            v_newSal := (v_presSal - (v_presSal * k_twentyFive));
        ELSE
            -- EMPLOYEE GETS 50% PAY CUT
            v_newSal := (r_employee.sal * k_fifty);
        END IF;
    

    -- CHECK IF EMPLOYEE SALARY IS LESS THAN $100
    ELSIF (r_employee.sal < k_hundred) THEN
        -- CHECK IF 10% RAISED EMPLOYEE SALARY IS LESS THEN COMPANY AVERAGE
        IF ((r_employee.sal + (r_employee.sal * k_ten)) < v_avg) THEN
            -- EMPLOYEE GETS 10% RAISE
            v_newSal := (r_employee.sal + (r_employee.sal * k_ten));
        END IF;
    ELSE
        v_newSal := r_employee.sal;
    END IF;

    -- CHECK IF EMPLOYEE COMMISSION IS MORE THAN 22% OF TOTAL SALARY
    IF  r_employee.comm > r_employee.sal * k_twentyTwo THEN
        -- GET LOWEST COMMISSION WITHIN DEPARTMENT
        SELECT MIN(comm)
        INTO v_lowCom
        FROM emp
        WHERE deptno = r_employee.deptno
        AND comm > 0;
    
    ELSE
        v_lowCom := r_employee.comm;
    END IF;

    --UPDATE EMPLOYEE SALARY AND COMMISSION
    UPDATE emp
    SET sal = v_newSal, comm = v_lowCom
    WHERE empno = v_employee;
    
END LOOP;
-- END
END;
/
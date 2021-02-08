SET SERVEROUTPUT ON

-- TASK 3
DECLARE
    -- VARIABLES
    v_pSal emp.sal%TYPE;
    v_avg emp.sal%TYPE;
    -- CONSTANTS
    k_lower CONSTANT NUMBER(3,2) := 0.75;
    k_raise CONSTANT NUMBER(3,2) := 1.10;
    k_thousand CONSTANT NUMBER(4) := 1000;
    k_pres CONSTANT VARCHAR2(30) := 'PRESIDENT';
    
BEGIN
    -- PRESIDENT SALARY
    SELECT sal
    INTO v_pSal
    FROM emp
    WHERE job = k_pres;
    
    -- SALARIES THAT ARE HIGHER THAN THE PRESIDENT LOWERED BY 25%
    UPDATE emp
    SET sal = (v_pSal * k_lower)
    WHERE sal > v_pSal;
    
    -- AVERAGE SALARY OF COMPANY
    SELECT AVG(sal)
    INTO v_avg
    FROM emp;

    -- RAISE SALARY OF PEOPLE WHOS NEW SALARY IS STILL LOWER THAN COMPANY AVERAGE SALARY
    UPDATE emp 
    SET sal = (sal * k_raise)
    WHERE k_thousand < v_avg AND (sal * k_raise) < v_avg;
END;
/
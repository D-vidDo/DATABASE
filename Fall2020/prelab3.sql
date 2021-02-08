SET SERVEROUTPUT ON

DECLARE
    -- TASK 1
    v_hiredate DATE := TO_DATE ('10-JAN-2013');
    v_surname VARCHAR2(30);
    v_firstname VARCHAR2(30);
    k_salary CONSTANT NUMBER(5,2) := 100.25;

    -- TASK 2
    a_agentid VARCHAR2(7);
    a_lastname VARCHAR2(25);
    a_firstname VARCHAR2(25);
    a_doh DATE;
    a_home VARCHAR2(10);
    a_business VARCHAR2(10);

    --TASK 3
    ab_agentid ata_agent.agent_id%TYPE;
    ab_lastname ata_agent.last_name%TYPE;
    ab_firstname ata_agent.first_name%TYPE;
    ab_doh ata_agent.date_of_hire%TYPE;
    ab_home ata_agent.home_phone%TYPE;
    ab_business ata_agent.business_phone%TYPE;

    -- TASK 4
    TYPE type_agent IS RECORD(
        agentid ata_agent.agent_id%TYPE,
        lastname ata_agent.last_name%TYPE,
        firstname ata_agent.first_name%TYPE,
        doh ata_agent.date_of_hire%TYPE,
        home ata_agent.home_phone%TYPE,
        business ata_agent.business_phone%TYPE
    );
    rec_agent type_agent;

    -- TASK 5
    rec_agentrow ata_agent%ROWTYPE;
BEGIN
    -- TASK 1
    v_surname := 'Do';
    v_firstname := 'David';
    DBMS_OUTPUT.PUT_LINE(v_hiredate);
    DBMS_OUTPUT.PUT_LINE(v_surname);
    DBMS_OUTPUT.PUT_LINE(v_firstname);
    DBMS_OUTPUT.PUT_LINE(k_salary);

    -- TASK 2
    SELECT agent_id, last_name, first_name, date_of_hire, home_phone, business_phone
    INTO a_agentid, a_lastname, a_firstname, a_doh, a_home, a_business
    FROM ata_agent
    WHERE agent_id = '0000002';
    DBMS_OUTPUT.PUT_LINE('TASK 2 NO %TYPE: ' || a_agentid || ' * ' || a_lastname || ' * ' || a_firstname || ' * ' || a_doh || ' * ' || a_home || ' * ' || a_business);

    -- TASK 3
    SELECT agent_id, last_name, first_name, date_of_hire, home_phone, business_phone
    INTO ab_agentid, ab_lastname, ab_firstname, ab_doh, ab_home, ab_business
    FROM ata_agent
    WHERE agent_id = '0000002';
    DBMS_OUTPUT.PUT_LINE('TASK 3 WITH %TYPE: ' ||ab_agentid || ' ** ' || ab_lastname || ' ** ' || ab_firstname || ' ** ' || ab_doh || ' ** ' || ab_home || ' ** ' || ab_business);

    -- TASK 4
     SELECT agent_id, last_name, first_name, date_of_hire, home_phone, business_phone
    INTO rec_agent
    FROM ata_agent
    WHERE agent_id = '0000002';
    DBMS_OUTPUT.PUT_LINE('TASK 4 RECORD TYPE: ' ||rec_agent.agentid || ' * ' || rec_agent.lastname || ' * ' || rec_agent.firstname || ' * ' || rec_agent.doh || ' * ' || rec_agent.home || ' * ' || rec_agent.business);

    -- TASK 5
    SELECT *
    INTO rec_agentrow
    FROM ata_agent
    WHERE agent_id = '0000002';
    DBMS_OUTPUT.PUT_LINE('TASK 5 ROWTYPE: ' || rec_agentrow.agent_id || ' * ' || rec_agentrow.last_name || ' * ' || rec_agentrow.first_name || ' * ' || rec_agentrow.date_of_hire || ' * ' || rec_agentrow.home_phone || ' * ' || rec_agentrow.business_phone);
END;
/
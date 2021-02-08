-- SET SERVEROUTPUT ON
-- DECLARE

-- k_clientID CONSTANT NUMBER := 8;
-- v_contract NUMBER;

-- BEGIN

-- select contract_number 
-- INTO v_contract
-- from ata_contract 
-- where client_id = k_clientID;

-- EXCEPTION
-- WHEN NO_DATA_FOUND THEN
-- DBMS_OUTPUT.PUT_LINE('No Client ID found, please enter a correct ID');
-- END;
-- /

-- SET SERVEROUTPUT ON
-- DECLARE

-- k_clientID CONSTANT NUMBER :=0000020;
-- v_contractFee NUMBER;

-- BEGIN
-- select fee
-- into v_contractFee
-- from ata_contract
-- where client_id = k_clientID;

-- EXCEPTION
-- WHEN TOO_MANY_ROWS THEN
--     DBMS_OUTPUT.PUT_LINE('There are more than one contract fees under that client ID');

-- END;
-- /


-- SET SERVEROUTPUT ON
-- DECLARE

-- k_addition CONSTANT NUMBER :=500;
-- k_type CONSTANT VARCHAR2(25) :='Retirement Party';
-- ex_noEventType_update EXCEPTION;

-- BEGIN

-- UPDATE ata_contract
-- set fee = fee + k_addition
-- where event_type = k_type;

-- IF SQL%NOTFOUND THEN
--     RAISE ex_noEventType_update;
-- END IF;

-- EXCEPTION
--     WHEN ex_noEventType_update THEN
--     DBMS_OUTPUT.PUT_LINE('No Rows were updated due to event type not existing in database');
-- END;
-- /


SET SERVEROUTPUT ON
DECLARE

k_addition CONSTANT NUMBER :=500;
k_type CONSTANT VARCHAR2(25) :='Retirement Party';
ex_noEventType_update EXCEPTION;
PRAGMA exception_init(ex_noEventType_update, -20010);

BEGIN

UPDATE ata_contract
set fee = fee + k_addition
where event_type = k_type;

IF SQL%NOTFOUND THEN
    RAISE_application_error(-20010,'No rows were found here');
END IF;

EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('No Rows were updated due to event type not existing in database');
END;
/
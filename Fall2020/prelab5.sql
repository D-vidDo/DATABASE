SET SERVEROUTPUT ON
-- QUESTION 1
DECLARE
    v_clientID ata_contract.client_id%TYPE;
    k_eight CONSTANT NUMBER(1) := 8;
BEGIN
    SELECT client_id INTO v_clientID FROM ata_contract WHERE contract_number = k_eight;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('The contract does not exist!');
END;
/
-- QUESTION 2
DECLARE
    k_clientID CONSTANT NUMBER(7) := 0000020;
    v_contractFee ata_contract.fee%TYPE;
BEGIN
    SELECT fee INTO v_contractFee FROM ata_contract WHERE client_id = k_clientID;
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('There are more than one contract fee involved!');
END;
/
-- QUESTION 3
DECLARE
    k_fiveH CONSTANT NUMBER :=500;
    k_type CONSTANT VARCHAR2(25) :='Retirement Party';
    ex_noEventType_update EXCEPTION;

BEGIN
    UPDATE ata_contract SET fee = fee + k_fiveH WHERE event_type = k_type;
    IF SQL%NOTFOUND THEN
        RAISE ex_noEventType_update;
    END IF;
EXCEPTION
    WHEN ex_noEventType_update THEN
    DBMS_OUTPUT.PUT_LINE('Selected event type does not exist!');
END;
/
-- QUESTION 4
DECLARE
    k_fiveH CONSTANT NUMBER :=500;
    k_type CONSTANT VARCHAR2(25) :='Retirement Party';
    ex_noEventType_update EXCEPTION;
    PRAGMA exception_init(ex_noEventType_update, -20222);

BEGIN
    UPDATE ata_contract SET fee = fee + k_fiveH WHERE event_type = k_type;
    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20222,'No rows found');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Nothing was updated as the selected event type does not exist!');
END;
/
SET SERVEROUTPUT ON
DECLARE
    -- NEW TRANSACTION CURSOR
    CURSOR c_transaction IS
        SELECT *
        FROM new_transactions
        FOR UPDATE;
    -- HISTORY CURSOR
    CURSOR c_history IS 
        SELECT *
        FROM transaction_history;
    -- CONSTANTS
    k_d constant VARCHAR2(1) := 'D';
    k_c constant VARCHAR2(1) := 'C';
    -- RECORDS
    r_transaction c_transaction%ROWTYPE;
    r_history c_history%ROWTYPE;

    COLUMN "Description" FORMAT A30
    COLUMN "Cust#" FORMAT A10
    COLUMN "Account Type" FORMAT A30

BEGIN

    for r_transaction IN c_transaction LOOP

    END LOOP;
/* ********************************************************************
** FILE:        Do_Tran_A1.sql
** AUTHOR:      David Do, Daniel Tran
** CREATED:     October 23, 2020
** DESCRIPTION: Double Entry Account System Processing Debit & Credit
**              Transactions & Updating Account Balances
************************************************************************/
DECLARE

    -- 1ST CURSOR
	CURSOR c_new_trans IS
		SELECT *
        FROM new_transactions
		FOR UPDATE;

    -- HISTORY CURSOR
    CURSOR c_trans_hist IS
		SELECT DISTINCT transaction_no, transaction_date, description 
		FROM new_transactions;
	
    -- CONSTANTS
	k_trans_typec CONSTANT CHAR(1) := 'C';
	k_trans_typed CONSTANT CHAR(1) := 'D';
	
    -- RECORDS
	r_tranA new_transactions%ROWTYPE;
	
    -- VARIABLES
	v_transaction new_transactions.transaction_no%TYPE;
	v_amount new_transactions.transaction_amount%TYPE;
    v_type new_transactions.transaction_type%TYPE;
	v_defTransType account_type.default_trans_type%TYPE;
	v_err_msg VARCHAR2(100);
	
	e_missing_trans_no EXCEPTION;
	PRAGMA EXCEPTION_INIT(e_missing_trans_no, -1400);
	
	e_pk_error EXCEPTION;
	PRAGMA EXCEPTION_INIT(e_pk_error, -0001);
	
BEGIN
    -- INSERT TRANSACTION DATA INTO HISTORY
	FOR r_trans_hist IN c_trans_hist LOOP

	BEGIN
		INSERT INTO transaction_history (transaction_no, transaction_date, description)
		VALUES (r_trans_hist.transaction_no, r_trans_hist.transaction_date, r_trans_hist.description);
			
		v_transaction := r_trans_hist.transaction_no;
    -- 1ST RUN OF NEW TRANSACTIONS
    FOR r_tranA IN c_new_trans LOOP

        -- ASSIGN FIRST RUN VARIABLES
		SELECT default_trans_type INTO v_defTransType FROM account_type NATURAL JOIN account WHERE account_no = r_tranA.account_no;

	    v_amount := r_tranA.transaction_amount;
        v_type := r_tranA.transaction_type;
		
		INSERT INTO transaction_detail (account_no, transaction_no, transaction_type, transaction_amount)
		VALUES (r_tranA.account_no, r_tranA.transaction_no, r_tranA.transaction_type, r_tranA.transaction_amount);
		
        -- IF TRANSACTION TYPE IS C
		IF r_tranA.transaction_type = k_trans_typec THEN
			-- CHECK FOR THE DEFAULT TRANSACTION TYPE IS CREDIT
			IF v_defTransType = k_trans_typec THEN
				-- ADD TRANSACTION AMOUNT TO ACCOUNT BALANCE
				UPDATE account SET account_balance = account_balance + r_tranA.transaction_amount
				WHERE account_no = r_tranA.account_no;
			ELSE
				-- SUBTRACT TRANSACTION AMOUNT FROM ACCOUNT BALANCE
				UPDATE account SET account_balance = account_balance - r_tranA.transaction_amount
				WHERE account_no = r_tranA.account_no;
			END IF;

		-- IF TRANSACTION TYPE IS D
		ELSIF r_tranA.transaction_type = k_trans_typed THEN
			-- CHECK FOR THE DEFAULT TRANSACTION TYPE IS DEBIT
			IF v_defTransType = k_trans_typed THEN
				-- ADD TRANSACTION AMOUNT TO ACCOUNT BALANCE
				UPDATE account SET account_balance = account_balance + r_tranA.transaction_amount
				WHERE r_tranA.account_no = account_no;
			ELSE
				-- SUBTRACT TRANSACTION FROM ACCOUNT BALANCE
				UPDATE account SET account_balance = account_balance - r_tranA.transaction_amount
				WHERE r_tranA.account_no = account_no;
			END IF;
		END IF;
		
		-- DELETE TRANSACTION ENTRY
		DELETE FROM new_transactions
		WHERE r_tranA.transaction_amount = v_amount
		AND r_tranA.transaction_type != v_type;
		
        END LOOP;
		
		EXCEPTION 
		-- MISSING TRANSACTION NUMBER
		WHEN e_missing_trans_no THEN
		-- ROLLBACK;
		DBMS_OUTPUT.PUT_LINE('Transaction Number is Null');
		v_err_msg := 'Transaction Number is Null';
		INSERT INTO wkis_error_log(transaction_no, transaction_date, description, error_msg)
		VALUES (1, SYSDATE, 'The Transaction Number is Null', v_err_msg);
		-- COMMIT;
		
		WHEN e_pk_error THEN
		-- ROLLBACK;
		DBMS_OUTPUT.PUT_LINE('There is a Constraint Error');
		v_err_msg := 'There is a Constraint Error';
		INSERT INTO wkis_error_log(transaction_no, transaction_date, description, error_msg)
		VALUES (1, SYSDATE, 'There is a Constraint Error in the New Transaction Table', v_err_msg);
		END;
		
    END LOOP;
	
	
END;
/
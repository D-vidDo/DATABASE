/* ***************************************************************************
** FILE:        Do_Tran_A1.sql
** AUTHOR:      David Do, Daniel Tran
** CREATED:     October 23, 2020
** DESCRIPTION: Double Entry Account System Processing Debit & Credit
**              Transactions & Updating Account Balances
** VERSION: 	v9.05
** CHANGES: 	EVERYTHIING BECAUSE OLD CODE DID NOT WORK WITH OUR EXCEPTIONS
******************************************************************************/
SET SERVEROUTPUT ON
DECLARE

    -- VARIABLES
	v_transaction new_transactions.transaction_no%TYPE;
	v_defTransType account_type.default_trans_type%TYPE;
	v_err_msg VARCHAR2(100);
	v_credit NUMBER;
	v_debit NUMBER;
	
    -- 1ST CURSOR
	CURSOR c_new_trans IS
		SELECT *
        FROM new_transactions
		WHERE transaction_no = v_transaction
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
	
	
	-- EXCEPTIONS
	e_missing_trans_no EXCEPTION;
	PRAGMA EXCEPTION_INIT(e_missing_trans_no, -1400);
	
	e_pk_error EXCEPTION;
	PRAGMA EXCEPTION_INIT(e_pk_error, -0001);
	
	e_invalid_acc_no EXCEPTION;
	PRAGMA EXCEPTION_INIT(e_invalid_acc_no, -1722);
	
	e_invalid_trans_type EXCEPTION;
	PRAGMA EXCEPTION_INIT(e_invalid_trans_type, -2290);
	
	e_negative_amount EXCEPTION;
	
	e_dc_not_equal EXCEPTION;
	
BEGIN
    -- INSERT TRANSACTION DATA INTO HISTORY
	FOR r_trans_hist IN c_trans_hist LOOP
	
	-- INITIALIZE THE TWO CREDIT AND DEBIT VARIABLES
	v_credit := 0;
	v_debit := 0;
	
	BEGIN
		INSERT INTO transaction_history (transaction_no, transaction_date, description)
		VALUES (r_trans_hist.transaction_no, r_trans_hist.transaction_date, r_trans_hist.description);
			
		v_transaction := r_trans_hist.transaction_no;
    -- 1ST RUN OF NEW TRANSACTIONS
    FOR r_tranA IN c_new_trans LOOP

		-- CHECKING FOR A NEGATIVE TRANSACTION AMOUNT
		IF r_tranA.transaction_amount < 0 THEN
            RAISE e_negative_amount;
        END IF;
		
		SELECT default_trans_type INTO v_defTransType FROM account_type NATURAL JOIN account WHERE account_no = r_tranA.account_no;
		
		INSERT INTO transaction_detail (account_no, transaction_no, transaction_type, transaction_amount)
		VALUES (r_tranA.account_no, r_tranA.transaction_no, r_tranA.transaction_type, r_tranA.transaction_amount);
		
        -- IF TRANSACTION TYPE IS C
		IF r_tranA.transaction_type = k_trans_typec THEN
			-- CHECK FOR THE DEFAULT TRANSACTION TYPE IS CREDIT
			v_credit := v_credit + r_tranA.transaction_amount;
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
			v_debit := v_debit + r_tranA.transaction_amount;
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
		WHERE r_tranA.transaction_no = transaction_no
		AND account_no = r_tranA.account_no;
		
        END LOOP;
		
		-- CHECKING FOR EQUAL BALANCE IN DEBIT AND CREDIT
		IF v_credit != v_debit THEN
			RAISE e_dc_not_equal;
        END IF;
		
		EXCEPTION 
		-- MISSING TRANSACTION NUMBER
		WHEN e_missing_trans_no THEN
			ROLLBACK;
			DBMS_OUTPUT.PUT_LINE('Transaction Number is Null');
			v_err_msg := 'Transaction Number is Null';
			INSERT INTO wkis_error_log(transaction_no, transaction_date, description, error_msg)
			VALUES (1, SYSDATE, 'The Transaction Number is Null', v_err_msg);
			COMMIT;
		
		-- PRIMARY KEY ERROR	
		WHEN e_pk_error THEN
			ROLLBACK;
			DBMS_OUTPUT.PUT_LINE('There is a Constraint Error');
			v_err_msg := 'There is a Constraint Error';
			INSERT INTO wkis_error_log(transaction_no, transaction_date, description, error_msg)
			VALUES (r_tranA.transaction_no, SYSDATE, 'There is a Constraint Error in the New Transaction Table', v_err_msg);
			COMMIT;
		
		-- INVALID ACCOUNT NUMBER ERROR
		WHEN e_invalid_acc_no THEN
			ROLLBACK;
			DBMS_OUTPUT.PUT_LINE('The Account Number is INVALID');
			v_err_msg := 'The Account Number is INVALID';
			INSERT INTO wkis_error_log(transaction_no, transaction_date, description, error_msg)
			VALUES (r_tranA.transaction_no, SYSDATE, 'The Account Number in the New Transaction Table is INVALID', v_err_msg);
			COMMIT;
		
		-- INVALID TRANSACTION TYPE ERROR
		WHEN e_invalid_trans_type THEN
			ROLLBACK;
			DBMS_OUTPUT.PUT_LINE('The Transaction type is neither "D" or "C"');
			v_err_msg := 'The Transaction type is neither "D" or "C"';
			INSERT INTO wkis_error_log(transaction_no, transaction_date, description, error_msg)
			VALUES (r_tranA.transaction_no, SYSDATE, 'The Transaction Type is invalid. It is not "D" or "C"', v_err_msg);
			COMMIT;
		
		-- NEGATIVE AMOUNT ERROR
		WHEN e_negative_amount THEN
			ROLLBACK;
			DBMS_OUTPUT.PUT_LINE('The Transaction Amount is a negative');
			v_err_msg := 'The Transaction Amount is a negative';
			INSERT INTO wkis_error_log(transaction_no, transaction_date, description, error_msg)
			VALUES (r_tranA.transaction_no, SYSDATE, 'The Transaction Amount in New Transaction Table is a Negative amount', v_err_msg);
			COMMIT;
		
		-- DEBIT AND CREDIT ARE NOT EQUAL ERROR
		WHEN e_dc_not_equal THEN
			ROLLBACK;
			DBMS_OUTPUT.PUT_LINE('The Debit and Credit Total are not equal');
			v_err_msg := 'The Debit and Credit Total are not equal';
			INSERT INTO wkis_error_log(transaction_no, transaction_date, description, error_msg)
			VALUES (r_tranA.transaction_no, SYSDATE, 'The Debit and Credit Total are NOT Equal in New Transaction Table', v_err_msg);
			COMMIT;
		
		-- WHEN AN UNANTICIPATED ERROR OCCURES
		WHEN OTHERS THEN 
			ROLLBACK;
			DBMS_OUTPUT.PUT_LINE ('There was an unanticipated Error during the process');
			v_err_msg := 'Unanticipated Error Occured during the process';
			INSERT INTO wkis_error_log(transaction_no, transaction_date, description, error_msg)
			VALUES (r_tranA.transaction_no, SYSDATE, 'There was an unanticipated Error during the process at Transaction Number: ' + r_tranA.transaction_no, v_err_msg);
			COMMIT;
		END;
		
		COMMIT;
    END LOOP;
	
END;
/
SET SERVEROUTPUT ON
DECLARE
v_one CHAR(3) := 'ABCDE';
BEGIN
	SELECT ename INTO v_one FROM emp WHERE ename = 'Riley';
	IF (SQL%ROWCOUNT > 2) THEN
		RAISE_APPLICATION_ERROR(-20000, 'more than 1');
	END IF;
	COMMIT;
EXCEPTION
		WHEN OTHERS THEN
			v_two := SUBSTR(SQLERRM, 1, 100);
			ROLLBACK;
			DBMS_OUTPUT.PUT_LINE(v_two);
END;
/

CREATE OR REPLACE PROCEDURE check_number
(p_num NUMBER)
IS
BEGIN
	UPDATE number_table
		SET range = v_range
		WHERE id = p_num;
END;
/

BEGIN
	DECLARE
		v_test CHAR(3) := 'ABCDE';
	BEGIN
		DBMS_OUTPUT.PUT_LINE('test');
	EXCEPTION
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('inner');
	END;
EXCEPTION
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('prgoram');
END;
/


declare
k_value_1 constant char := 'I';
k_value_2 constant char := 'o';
k_value_3 constant char := 'a';
k_value_4 constant char := ' ';

begin
for i in 1..5 loop
  declare
  v_count number := 2;
  k_value_2 constant char := 'n';
  v_done boolean := false;
  
  begin
  while (not v_done) loop
  dbms_output.put(k_value_1);
  dbms_output.put(k_value_4);
  
  if ((i + v_count) = 3) then
  dbms_output.put('know');
  dbms_output.put(k_value_4);
  v_count := v_count +1;
  elsif ((i + 10) = 11) then
  dbms_output.put('c' || k_value_3 || k_value_2);
  dbms_output.put(k_value_4);
  v_done := true;
  elsif ((i + 1) = 2) then
  dbms_output.put(k_value_3);
  end if;
  end loop;
  
  dbms_output.put('tr' || k_value_3 || 'ce');
  dbms_output.put(k_value_4);
  
  if(i = 1) then
  raise_application_error(-20000, 'errors');
  end if;
  
  exception when no_data_found then
  dbms_output.put('tr' || k_value_3 || 'ce');
  end;
  
  end loop;
  dbms_output.new_line;
  
  exception
  when others then
  dbms_output.put_line('c' || k_value_2 || 'de');
  end;
  /
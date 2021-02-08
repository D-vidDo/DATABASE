--ALTER TABLE ata_entertainer
--ADD more_than_one NUMBER;

SET SERVEROUTPUT ON

DECLARE
    -- GET ENTERTAINERS
    CURSOR c_entertainer IS
        SELECT *
        FROM ata_entertainer
        FOR UPDATE;
    
    -- GET STYLES
    CURSOR c_style IS
        SELECT *
        FROM ata_entertainers_style;

    -- CREATE RECORDS
    r_styles c_style%ROWTYPE;
    r_entertainer c_entertainer%ROWTYPE;

    -- VARIABLES
    v_entertainer_id ata_entertainer.entertainer_id%TYPE;
    v_entertainer_count NUMBER(2) := 0;

BEGIN
-- OPEN ENTERTAINER CURSOR
OPEN c_entertainer;
-- LOOP THROUGH ALL ENTERTAINERS
LOOP
    -- FETCH EACH ENTERTAINER
    FETCH c_entertainer INTO r_entertainer;
    -- EXIT WHEN THERE ARE NO MORE ENTERTAINERS
    EXIT WHEN c_entertainer%NOTFOUND;
    -- SET ENTERTAINER ID AT CURRENT POSITION
    v_entertainer_id := r_entertainer.entertainer_id;
    v_entertainer_count := 0;

    -- OPEN STYLES CURSOR
    OPEN c_style;
    -- LOOP THROUGH EACH STYLE
    LOOP
        -- FETCH EACH STYLE
        FETCH c_style INTO r_styles;
        EXIT WHEN c_style%NOTFOUND;

        -- WHILE SEARCHING THROUGH THE STYLES, IF AN
        --ENTERTAINER HAS MORE THAN 1 STYLE, ADD 1 TO THE COUNT
        IF r_styles.entertainer_id = v_entertainer_id THEN
            v_entertainer_count := v_entertainer_count + 1;
        END IF;
    END LOOP;
    -- CLOSE STYLE CURSOR
    CLOSE c_style;

    -- IF THE ENTERTAINER HAS 2 OR MORE
    --STYLES, UPDATE THE ENTERTAINER TABLE
    IF v_entertainer_count >= 2 THEN
        UPDATE ata_entertainer
        SET more_than_one = v_entertainer_count
        -- UPDATE AT THE CURRENT ENTERTAINER
        WHERE CURRENT OF c_entertainer;
    END IF;
END LOOP;
-- CLOSE ENTERTAINER CURSOR
CLOSE c_entertainer;

-- END
END;
/
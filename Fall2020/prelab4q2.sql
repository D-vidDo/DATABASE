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
-- LOOP THROUGH ALL ENTERTAINERS
FOR r_entertainer IN c_entertainer LOOP
    --SET ENTERTAINER ID AT CURRENT POSITION
    v_entertainer_id := r_entertainer.entertainer_id;
    v_entertainer_count := 0;

    -- LOOP THROUGH ALL STYLES
    FOR r_styles IN c_style LOOP
        -- CASE WHERE ID MATCHES, THEN ADD 1 TO COUNT
        CASE
            WHEN r_styles.entertainer_id = v_entertainer_id THEN
                v_entertainer_count := v_entertainer_count + 1;
            -- OTHERWISE DO NOTHING
            ELSE
                NULL;
        END CASE;
    END LOOP;

    -- CASE WHERE CHECK IF ENTERTAINER STYLES IS 2 OR MORE,
    -- THEN UPDATES THE ENTERTAINER TABLE
    CASE
        WHEN v_entertainer_count >= 2 THEN
            UPDATE ata_entertainer
            SET more_than_one = v_entertainer_count
            WHERE entertainer_id = v_entertainer_id;
        -- OTHERWISE DO NOTHING
        ELSE
            NULL;
    END CASE;
END LOOP;

-- END
END;
/


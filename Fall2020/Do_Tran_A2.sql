CREATE FUNCTION func_permissions_okay
RETURNS VARCHAR2(1)
AS BEGIN
    DECLARE @result VARCHAR2(1)
    
    IF EXISTS (SELECT * FROM USER_TAB_PRIVS WHERE privilege = 'EXECUTE' AND table_name = 'UTL_FILE')
        BEGIN
            SET @result = 'Y'
        END
    ELSE
        IF NOT EXISTS (SELECT * FROM USER_TAB_PRIVS WHERE privilege = 'EXECUTE' AND table_name = 'UTL_FILE')
            BEGIN
                SET @result = 'N'
            END

    RETURN @result
END
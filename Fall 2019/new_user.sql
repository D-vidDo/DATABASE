alter session set "_ORACLE_SCRIPT"=true; 
CREATE USER cprg250
      IDENTIFIED BY password
      DEFAULT TABLESPACE users;
ALTER USER cprg250 quota unlimited on <tablespace name>;
GRANT RESOURCE, CONNECT, CREATE TABLE, CREATE VIEW TO cprg250;
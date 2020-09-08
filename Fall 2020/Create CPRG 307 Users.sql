/* ****************************************************************************
**									                                         **
**	Script Name:  Create CPRG 307 Users.sql		                             **
**	Purpose:  Create two new user accounts (CPRG307, CPRG307a)               **
**									                                         **
***************************************************************************  */

ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE USER cprg307a IDENTIFIED BY password
DEFAULT TABLESPACE users
QUOTA UNLIMITED ON users;

GRANT connect, resource, dba TO cprg307a;

CREATE USER cprg307 IDENTIFIED BY password
DEFAULT TABLESPACE users
QUOTA UNLIMITED ON users;

GRANT connect, resource, create view, create public synonym, create synonym TO cprg307;





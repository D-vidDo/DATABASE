set echo on
set pagesize 66
set linesize 132
spool c:/cprg250/lab2output.txt

select firstname "FIRST", lastname "LAST" from customers where STATE='CA' order by last, first;

select title, category from books where retail-cost < 15 order by category, title;

select firstname, lastname, region from customers WHERE NOT region='NW' AND NOT region='N' AND NOT region='NE' order by lastname DESC, firstname ASC;

select firstname, lastname, region from customers WHERE region NOT IN ('N','NW','NE') order by lastname DESC, firstname ASC;

spool off
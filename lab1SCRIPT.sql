set echo on
set pagesize 66
set linesize 132
spool c:/cprg250/lab1output.txt

select title as "Book Title" from books;

select lastname ||', '|| firstname ||', '|| address ||', '|| city ||', '|| state ||', '|| zip as "Customer Information" from customers;

select title, cost, retail, (retail-cost)/cost*100 as "% Profit" from books;

select unique authorid as "Author ID" from bookauthor;

spool off
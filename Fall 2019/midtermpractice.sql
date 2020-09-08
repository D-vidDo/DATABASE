set echo ON
set pagesize 66
set linesize 100

spool c:/cprg250/midtermpractice.txt

-- Q1
SELECT s.student_id, cr.course_code, cr.grade 
FROM student s, course_registration cr
WHERE grade > 85
ORDER BY 1, 2;

-- Q2
COLUMN "Full Name" FORMAT A20
SELECT firstname || ' ' || surname "Full Name", birthdate, program_of_studies
FROM student
WHERE birthdate > '01-JAN-95'
ORDER BY 2;
CLEAR COLUMNS

-- Q3
COLUMN "Full Name" FORMAT A20
SELECT firstname || ' ' || surname "Full Name", COUNT(course_code) "Registered Courses"
FROM student NATURAL JOIN course_registration NATURAL JOIN class_section
GROUP BY (firstname, surname)
ORDER BY 1;
CLEAR COLUMNS

-- Q4
COLUMN "Full Name" FORMAT A20
COLUMN course_title FORMAT A25
SELECT firstname || ' ' || surname "Full Name", birthdate, course_code, semester, course_title, credits
FROM student NATURAL JOIN course_registration NATURAL JOIN class_section NATURAL JOIN course 
WHERE program_of_studies = 'Computer Technology'
AND prerequisite IS NULL;
CLEAR COLUMNS

-- Q5 wip 
SELECT * FROM student
WHERE student_id LIKE '000710000'
OR student_id LIKE '000600201';

-- Q6
SELECT course_title, AVG(enrolment)
FROM course NATURAL JOIN class_section
HAVING AVG(enrolment) > (SELECT AVG(enrolment) FROM class_section)
GROUP BY course_title;

-- Q7 wip
SELECT DISTINCT firstname FROM student
JOIN course_registration USING (student_id)
JOIN class_section USING (course_code)
ORDER BY 1;

SELECT DISTINCT f.firstname FROM faculty f
JOIN class_section cs ON (f.employee_id = cs.instructor_id)
ORDER BY 1;
-- SELECT DISTINCT s.firstname, f.firstname FROM student s
-- JOIN course_registration cr ON (s.student_id = cr.student_id) 
-- JOIN class_section cs ON (cr.course_code = cs.course_code)
-- JOIN faculty f ON (cs.instructor_id = f.employee_id)
-- ORDER BY 1;

-- Q8 wip

spool off
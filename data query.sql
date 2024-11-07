
use udb; 
SELECT DISTINCT dept_name
FROM instructor;

select *
from classroom; 

SELECT DISTINCT building
FROM classroom;

SELECT building, capacity
FROM classroom
WHERE capacity = 60;

SELECT building, capacity
FROM classroom
WHERE capacity BETWEEN 30 AND 602;

SELECT ID, name, 
       salary * 12 AS annual_salary,
       salary * 12 * 5 AS predicted_5_year_salary
FROM instructor;

SELECT ID, name,
       FLOOR(salary * 12) AS annual_salary,
       FLOOR(salary * 12 * 5) AS predicted_5_year_salary,
       FLOOR(salary * 12 * 5 * 1.10) AS predicted_5_year_salary_with_10_percent_increment
FROM instructor;

SELECT name
FROM instructor
WHERE salary BETWEEN 70000 AND 85000;



SELECT AVG(salary) AS average_salary
FROM instructor
WHERE dept_name = 'Elec. Eng.';


SELECT instructor.name, teaches.course_id
FROM instructor
JOIN teaches ON instructor.ID = teaches.ID;





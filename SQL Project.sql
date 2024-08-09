#-------------------SQL Complete Project-------------------------

#--- Create Database 
CREATE DATABASE employees;
USE employees;

-- Create department Table
CREATE TABLE department (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(20),
dept_location VARCHAR(15)
);

-- Create employee Table
CREATE TABLE employee (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(15),
job_name VARCHAR(10),
manager_id INT ,
hire_date DATE,
salary DECIMAL(7,2),
dept_id INT ,
FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);
-- Modify The employee Table
ALTER TABLE employee
ADD COLUMN commission DECIMAL(7,2);

-- Create salary_grade Table
CREATE TABLE salary_grade (
grade INT PRIMARY KEY,
min_salary INT,
max_salary INT 
);

-- Insert Values Into The employee Table
INSERT INTO employee VALUES
(68319, "KAYING", "PRESIDENT", NULL, "1991-11-18", 6000, 1001, NULL),
(66928, "BLAZE", "MANAGER", 68319, "1991-05-01", 2750, 3001, NULL),
(67832,"CLARE", "MANAGER", 68319, "1991-06-09", 2550, 1001, NULL),
(65646,"JONAS","MANAGER",68319,"1991-04-02",2957,2001, NULL),
(67858,"SCARLET", "ANALYST", 65646, "1997-04-19", 3100, 2001, NULL),
(69062,"FRANK", "ANALYST", 65646, "1991-12-03", 3100, 2001, NULL),
(63679,"SANDRINE", "CLERK", 69062, "1990-12-18", 900, 2001, NULL),
(64989, "ADELYN", "SALESMAN", 66928, "1991-02-20", 1700, 2001, 400),
(65271, "WADE", "SALESMAN", 66928, "1991-02-22", 1350, 3001, 600),
(66564, "MADDEN", "SALESMAN", 66928, "1991-09-28", 1350, 3001, 1500),
(68454, "TUCKKER", "SALESMAN", 66928, "1991-09-08", 1600, 3001, 0),
(68736, "ADNRES", "CLERK", 67858, "1997-05-23", 1200, 2001, NULL),
(69000, "JULIUS", "CLERK", 66928, "1991-12-03", 1050, 3001, NULL),
(69324, "MARKER", "CLERK", 67832, "1992-01-23", 1400, 1001, NULL);

-- Insert Values Into The department Table
INSERT INTO department VALUES
(1001, "FINANCE", "SYDNEY"),
(2001, "AUDIT", "MELBOURNE"),
(3001, "MARKETING", "PERTH"),
(4001, "PRODUCTION", "BRISBANE");

-- Insert Values Into The salary_grade Table
INSERT INTO salary_grade VALUES
(1, 800, 1300),
(2, 1301, 1500),
(3,1501,2100),
(4,2101,3100),
(5,3101,9999);

#Query-1:---display all the info of the employees
SELECT * FROM employee;

#Query-2:---find the salaries of all employees
SELECT salary FROM employee;

#Query-3:---display the unique designation for all employees
SELECT DISTINCT(job_name) FROM employee;

#Query-4:---list the emp_name and salary is increased by 15% and expressed as number of dollars
SELECT emp_name,salary,CONCAT('$',salary * 1.15) AS new_salary
FROM employee;


#Query-5:---produce the output of employee name and their job name as a format employee & job
SELECT CONCAT(emp_name,"-",job_name) AS "employee & job" 
FROM employee;

#Query-6:---produce the output of employee JONAS(manager)
SELECT CONCAT(emp_name,"(",LOWER(job_name),")") 
FROM employee;

#Query-7:---list all the employee with the salary and hire date in the formate like January 22, 1992
SELECT emp_id,emp_name,salary,DATE_FORMAT(hire_date,'%M %d, %Y') AS hire_date
FROM employee;

#Query-8:---count number of character without considering the space of each name
SELECT emp_name,LENGTH(LTRIM(emp_name)) AS lenth_of_emp_name 
FROM employee;

#Query-9:---list the emp_id, salary and commission of all the employee
SELECT emp_id,salary,commission
FROM employee;

#Query-10:---display the unique depertment with their job
SELECT DISTINCT dept_id,job_name
FROM employee;

#Query-11:---list the employee who does not belong to depertment 2001
SELECT * FROM employee
WHERE dept_id <> 2001;

#Query-12:---list the employee who joined before 1991
SELECT * FROM employee
WHERE hire_date < "1991-01-01";

#Query-13:---display the average salary of all employees who work as analyst
SELECT AVG(salary) AS average_salary
FROM employee
WHERE job_name = "Analyst";

#Query-14:---display the details of employee blaze
SELECT * FROM employee
WHERE emp_name = "BLAZE";

#Query-15:---display all the details of employees whose commission is more than their salary
SELECT * FROM employee
WHERE commission > salary;

#Query-16:---list the employee whose salary is more than 3000 after giving 25% increment
SELECT * FROM employee
WHERE salary * 1.25 > 3000;

#Query-17:---list the name of employee those having six characters to their name
SELECT emp_name
FROM employee
WHERE LENGTH(emp_name) = 6;

#Query-18:---list the employee who have joined in the month of january
SELECT * FROM employee
WHERE MONTH(hire_date) =1;

#Query-19:---list the name of employee and their manager seperated by string works for
SELECT CONCAT(e1.emp_name," Works For ",e2.emp_name) AS "Emp_name & manager_name"
FROM employee e1
JOIN
employee e2
ON e1.manager_id = e2.emp_id;

#Query-20:---list the name of employee whose designation is clerk
SELECT * FROM employee
WHERE job_name= "CLERK";

#Query-21:---list the name of employee whose experience is more than 27 years
SELECT * FROM employee
WHERE TIMESTAMPDIFF(YEAR,hire_date,CURDATE()) > 27;

#Query-22:---list the employee whose salaries are less than 3500
SELECT * FROM employee
WHERE salary < 3500;

#Query-23:---list the name,job_name and salary of any employee whose designation is ANALYST
SELECT emp_name,job_name,salary
FROM employee
WHERE job_name = "ANALYST";

#Query-24:---list the employee who have joined in the year 1991
SELECT * FROM employee
WHERE YEAR(hire_date)=1991;

#Query-25:---list the name, id, hire_date and salary of all the employees joined before 1 april 1991
SELECT emp_name,emp_id,hire_date,salary FROM employee
WHERE hire_date< "1991-04-01";

#Query-26:---list the emp_name, job_name who not working under a manager
SELECT emp_name,job_name FROM employee
WHERE manager_id IS NULL;

#Query-27:---list all the employee who joined on 1 may 1991
SELECT * FROM employee
WHERE hire_date = "1991-05-01";

#Query-28:---list the id, name,salary and experience of all employee who working for manager 68319
SELECT emp_id,emp_name,salary,
TIMESTAMPDIFF(YEAR,hire_date,CURDATE()) AS experience
FROM employee
WHERE manager_id= 68319;

#Query-29:---list the id, name,salary and experience of all employee who earn more than 100 as daily salary
SELECT emp_id, emp_name, salary, TIMESTAMPDIFF(YEAR,hire_date,CURDATE()) AS experience
FROM employee
WHERE (salary/30) > 100;

#Query-30:---list the employee who are retiring after 31 december 1991 after completion of 8 years of service period
SELECT emp_name
FROM employee
WHERE 
DATE_ADD(hire_date, INTERVAL 8 YEAR) > '1999-12-31';

#Query-31:---list those employee whose salary is an odd value 
SELECT * FROM employee
WHERE MOD(salary, 2) = 1;

#Query-32:---list those employee whose salary is contain only 3 digit
SELECT * FROM employee
WHERE salary BETWEEN 100 AND 999;

#Query-33:---list the employee who have joined in the month of april
SELECT * FROM employee
WHERE MONTH(hire_date) = 4;

#Query-34:---list the employee those who joined in company before 19th of the month
SELECT * FROM employee
WHERE DAY(hire_date) < 19;

#Query-35:---list the employee who are salesman and gathered an experience which month portion is more than 10
SELECT * FROM employee
WHERE job_name= "Salesman" AND TIMESTAMPDIFF(MONTH, hire_date, CURDATE())> 10;

#Query-36:---list the employee of dept_id 3001 or 1001 joined in the year 1991
SELECT * FROM employee
WHERE YEAR(hire_date) = 1991 AND dept_id IN (3001,1001);

#Query-37:---list the employees who are working for dept_id 1001 or 2001
SELECT * FROM employee
WHERE 
(dept_id = 1001 OR dept_id = 2001);

#Query-38:---list all the employees of designation of clerk in dept no 2001
SELECT * FROM employee
WHERE job_name="CLERK" AND dept_id=2001;

#Query-39:---list the id, name, salary and job_name of the employee for
#---1. Annual salary is below 34000 but receiving some commission whuch should not be more than the salary
#---2. Designation of salesman and working for depertment 3001 
SELECT emp_id, emp_name, salary, job_name
FROM employee
WHERE 
12* (salary -commission) < 34000 AND commission IS NOT NULL AND commission < salary
AND
job_name = 'Salesman' AND dept_id = 3001;

#Query-40:---list the employees who are either clerk or manager
SELECT * FROM employee
WHERE job_name IN("Clerk" , "Manager");

#Query-41:---list the employees who have joined in any years expect the month of february
SELECT * FROM employee
WHERE MONTH(hire_date) <> 2;

#Query-42:---list the employees who have joined in the year 1991
SELECT * FROM employee
WHERE YEAR(hire_date) = 1991;

#Query-43:---list the employees who have joined in the month of june 1991
SELECT * FROM employee
WHERE YEAR(hire_date) = 1991 
AND 
MONTH(hire_date) = 6;

#Query-44:---list the employees whose annual salary is within the range 24000 and 50000
SELECT * FROM employee
WHERE 12 * salary BETWEEN 24000 AND 50000;

#Query-45:---list the employees who have joined on the following dates 1 may, 20 feb, 3 dec in the year 1991
SELECT * FROM employee
WHERE hire_date IN ('1991-05-01', '1991-02-20', '1991-12-03');

#Query-46:---list the employees who are working under the manager 63679 ,68319, 66564, 69000
SELECT * FROM employee
WHERE manager_id IN (63679, 68319, 66564, 69000);

#Query-47:---list the employees who have joined after the month of june in the year 1992
SELECT * FROM employee
WHERE hire_date > "1992-06-30";

#Query-48:---list the employees who have joined in the 90's
SELECT * FROM employee
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

#Query-49:---list the managers of depertment 1001 and 2001
SELECT * FROM employee
WHERE job_name= "Manager"
AND
dept_id IN (1001 , 2001);

#Query-50:---list the employee who have joined in the month of february with a salary range between 1001 to 2000
SELECT * FROM employee
WHERE MONTH(hire_date) = 2
AND 
salary BETWEEN 1001 AND 2000;

#Query-51:---list all the employee who have joined before or after 1991
SELECT * FROM employee
WHERE YEAR(hire_date) NOT IN ("1991");

#Query-52:---list the employee along with depertment name
SELECT e.emp_id, e.emp_name, e.job_name, e.manager_id, e.hire_date, 
e.salary, e.commission, d.dept_name
FROM 
employee e
JOIN 
department d ON e.dept_id = d.dept_id;

#Query-53:---list the emp_name,job name,annual salary,dept_id,dept_name, grade of employee who earn 60000 in a year or not working as an analyst
SELECT e.emp_name, e.job_name, e.salary * 12 AS annual_salary,
e.dept_id, d.dept_name, sg.grade
FROM employee e, department d, salary_grade sg 
WHERE e.dept_id = d.dept_id AND e.salary BETWEEN sg.min_salary AND sg.max_salary
AND (((12 * e.salary ) = 60000 ) OR (e.job_name <> "Analyst"));

#Query-54:list the emp_name, job name, manager id, salary, manager name, manager salary for those employee whose salary is greter than the salary of their manager
SELECT w.emp_name, w.job_name, w.manager_id, w.salary, m.emp_name AS manager, m.emp_id, m.salary AS manager_salary
FROM employee w
JOIN
employee m 
ON w.manager_id = m.emp_id
WHERE w.salary > m.salary;

#Query-55:---list the emp_name,depertment, salary and commission for those whose salary is between 2000 and 5000 while location is perth
SELECT e.emp_name, e.dept_id, e.salary, e.commission 
FROM employee e 
JOIN department d
ON e.dept_id = d.dept_id
WHERE d.dept_location = "Perth"
AND e.salary BETWEEN 2000 AND 5000 ;

#Query-56:---list the grade, emp name for the dept id 1001 or 3001 but salary grade is not 4 while they joined the company before 1992-12-31
SELECT sg.grade, e.emp_name
FROM employee e 
JOIN salary_grade sg
WHERE e.dept_id IN (1001,3001)
AND (e.salary BETWEEN sg.min_salary AND sg.max_salary AND sg.grade NOT IN(4))
AND hire_date < "1992-12-31";

#Query-57:---list the employee whose manager name is JONAS
SELECT e.emp_id, e.emp_name, e.job_name, e.manager_id, e.hire_date, e.salary, e.dept_id, m.emp_name
FROM employee e
JOIN employee m 
ON e.manager_id = m.emp_id
WHERE 
m.emp_name = 'JONAS';

#Query-58:---list the name and salary of FRANK if his salary is eqal to max salary of his grade
SELECT e.emp_name, e.salary
FROM employee e, salary_grade sg
WHERE e.emp_name ="FRANK"
AND e.salary BETWEEN sg.min_salary AND sg.max_salary AND e.salary = sg.max_salary;

#Query-59:---list the employe who are working either manager or analyst with a salary range between 2000 or 5000 without any commission
SELECT * FROM employee
WHERE job_name IN ("MANAGER","ANALYST")
AND salary BETWEEN 2000 AND 5000
AND commission IS NULL;

#Query-60:---list the id, name, salary and location of the employee who are working at perth or melbourne with an experience over 10 years
SELECT e.emp_id,e.emp_name,e.salary,d.dept_location
FROM employee e
JOIN department d
ON e.dept_id=d.dept_id
WHERE d.dept_location IN ("PERTH","MELBOURNE")
AND TIMESTAMPDIFF(YEAR,hire_date,CURDATE()) > 10;

#Query-61:---list the employe along with their location who belongs to sydney,melbourne with a salary range between 2000 and 5000 and have joined 1991
SELECT e.emp_id,e.emp_name,e.salary,e.hire_date,d.dept_location
FROM  employee e
JOIN department d
ON e.dept_id=d.dept_id
WHERE d.dept_location IN ("SYDNEY" , "MELBOURNE")
AND e.salary BETWEEN 2000 AND 5000
AND YEAR(hire_date) = 1991;

#Query-62:---list the employe with their location and grade for marketing depertment who comes from melbourne or perth within the grade 3 to 5 and experience over 5 years
SELECT e.dept_id, e.emp_name, e.salary, d.dept_name, d.dept_location, sg.grade
FROM employee e,salary_grade sg, department d
WHERE e.dept_id=d.dept_id
AND d.dept_name="MARKETING" AND d.dept_location IN("MELBOURNE", "PERTH")
AND e.salary BETWEEN sg.min_salary AND sg.max_salary AND sg.grade IN(3,5)
AND TIMESTAMPDIFF(YEAR ,hire_date, CURDATE()) >5;

#Query-63:---list the employee who are senior to their own manager
SELECT e1.emp_name AS Employee, e2.emp_name AS Manager
FROM employee e1
JOIN  employee e2
ON e1.manager_id=e2.emp_id
WHERE e1.hire_date < e2.hire_date;

#Query-64:---list the employee with their grade for grade 4
SELECT * FROM employee AS e, salary_grade AS sg
WHERE e.salary BETWEEN sg.min_salary AND sg.max_salary
AND sg.grade=4;

#Query-65:---list the employee in depertment production or audit who joined after 1991 and they are not marker or adelyn to their name
SELECT e.emp_name , e.hire_date, d.dept_name
FROM employee e, department d, salary_grade sg
WHERE e.dept_id= d.dept_id
AND d.dept_name IN("PRODUCTION","AUDIT")
AND e.salary BETWEEN sg.min_salary AND sg.max_salary
AND e.emp_name NOT IN("MARKER","ADELYN")
AND YEAR(e.hire_date) > 1991;

#Query-66:---list the employee in the assending order of their salary
SELECT * FROM employee
ORDER BY salary ASC;

#Query-67:---list the details of employee in ascending to the dep id and descending for jobs
SELECT * FROM employee
ORDER BY dept_id, job_name DESC;

#Query-68:---display all the unique jobs in descending
SELECT DISTINCT job_name
FROM employee
ORDER BY job_name DESC;

#Query-69:---list the id, name, monthly salary, daily salary of all the employee in ascending order of their annual salary
SELECT emp_id, emp_name, salary AS monthly_salary, salary/30 AS daily_salary, 12* salary AS annual_salary
FROM employee
ORDER BY annual_salary ASC;

#Query-70:---list the employee in decending order who are either clerk or analyst
SELECT * FROM employee
WHERE job_name = "CLERK" OR job_name= "ANALYST"
ORDER BY job_name DESC;

#Query-71:---display the location of clerk
SELECT dept_location
FROM department d
JOIN employee e
ON d.dept_id = e.dept_id
WHERE e.emp_name="CLERK";

#Query-72:---list the employe in asc order of seniority who joined on 1 may 1991 or 3 december 1991 or 19 january 1990
SELECT * FROM employee
WHERE hire_date IN ('1991-05-01', '1991-12-03', '1990-01-19')
ORDER BY hire_date DESC;

#Query-73:---list the employee who are drawing salary less than 1000 and sort the output asc order on salary
SELECT * FROM employee
WHERE salary< 1000
ORDER BY salary;

#Query-74:---list the details of employee in ascending order on the salary
SELECT * FROM employee
ORDER BY salary;

#Query-75:---list the employee in ascending order on job name and dec order on the emp id
SELECT * FROM employee
ORDER BY job_name, emp_id DESC;
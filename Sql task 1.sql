DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS intemployee;

CREATE TABLE department (
	Dept_id INT PRIMARY KEY,
	DeptName VARCHAR(50)
);

INSERT INTO department 
   VALUES
		(101,'HR'),
		(102,'IT'),
		(103,'Finance'),
		(104,'Marketing'),
		(105,'Sales');
SELECT * FROM department;

CREATE TABLE intemployee (
	Emp_id INT PRIMARY KEY,
	Emp_name VARCHAR(50),
	Salary DECIMAL(10,2),
	Hire_date DATE,
	Dept_id INT
);

INSERT INTO intemployee
	VALUES
		(1, 'Amit', 50000, '2025-01-15', 101),
		(2, 'Priya', 75000, '2025-03-10', 102),
		(3, 'Rahul', 60000, '2024-12-20', 103),
		(4, 'Sneha', 85000, '2025-05-12', 102),
		(5, 'Vikas', 95000, '2024-08-15', 104),
		(6, 'Neha', 70000, '2025-02-01', 105),
		(7, 'Rohit', 55000, '2025-06-10', 101),
		(8, 'Anjali', 120000, '2024-10-05', 102),
		(9, 'Karan', 65000, '2025-04-18', 103),
		(10, 'Pooja', 80000, '2024-11-22', 104),
		(11, 'Arjun', 45000, '2025-05-25', 105),
		(12, 'Meera', 90000, '2024-09-30', 102),
		(13, 'Sanjay', 72000, '2025-01-08', 103),
		(14, 'Ritika', 68000, '2025-03-15', 101),
		(15, 'Deepak', 110000, '2024-07-19', 105),
		(16, 'Amit', 50000, '2025-01-15', 101),
		(17, 'Priya', 75000, '2025-03-10', 102);

SELECT * FROM intemployee;

--Top 5 highest Salary employee
SELECT * FROM intemployee
ORDER BY salary DESC
LIMIT 5;

--Department wise employee count
SELECT Dept_id, COUNT(*) AS Employee_Count
FROM intemployee
GROUP BY Dept_id;

--Find Second highest salary.
SELECT MAX(salary) AS Second_Highest_Salary
FROM intemployee
WHERE salary < (
	SELECT MAX(salary)
	FROM intemployee
);

SELECT * FROM intemployee
ORDER BY salary DESC
LIMIT 2;

--Employees whose salary > department average salary
SELECT e.*
FROM intemployee e
WHERE e.Salary >
(
	SELECT AVG(Salary)
	FROM intemployee
	WHERE Dept_id = e.Dept_id
);

--Inner Join
SELECT
	e.Emp_id,
	e.Emp_Name,
	e.Salary,
	d.DeptName
FROM intemployee e
INNER JOIN department d
ON e.Dept_id=d.dept_id;

--Left Join
SELECT
	d.Dept_id,
	d.DeptName,
	e.Emp_Name
FROM department d
INNER JOIN intemployee e
ON d.Dept_id=e.dept_id;

--Group By with Having
SELECT
	Dept_id, COUNT(*) AS TotalEmployees
FROM intemployee
GROUP BY Dept_id
HAVING COUNT(*) > 3;
	
--Employees hired in last 6 months
SELECT * 
FROM intemployee
WHERE Hire_date >= '2025-01-01';

--Find the Duplicates records
SELECT
	emp_name,
	salary,
	hire_date,
	COUNT(*) AS DuplicateCount
FROM intemployee
GROUP BY 
	emp_name,
	salary,
	hire_date
HAVING COUNT(*) > 1;

--How to remove the duplicates record
DELETE FROM intEmployee
WHERE Emp_ID IN (
    SELECT Emp_ID
    FROM (
        SELECT Emp_ID,
               ROW_NUMBER() OVER (
                   PARTITION BY Emp_Name, Salary, Hire_Date, Dept_ID
                   ORDER BY Emp_ID
               ) AS RN
        FROM intEmployee
    ) t
    WHERE RN > 1
);

SELECT * FROM intemployee;
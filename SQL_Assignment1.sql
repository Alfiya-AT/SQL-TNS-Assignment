-- Table Creation 
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    DeptID INT,
    Salary NUMERIC(10,2),
    JoiningDate DATE,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Insert Sample Data
INSERT INTO Department VALUES
(1, 'HR', 'Mumbai'),
(2, 'IT', 'Bangalore'),
(3, 'Finance', 'Delhi'),
(4, 'Sales', 'Pune'),
(5, 'Support', 'Hyderabad');

INSERT INTO Employee VALUES
(101, 'Amit', 2, 60000, '2022-01-15'),
(102, 'Neha', 1, 45000, '2021-03-10'),
(103, 'Ravi', 2, 75000, '2020-06-20'),
(104, 'Priya', 3, 52000, '2019-11-05'),
(105, 'Suresh', 4, 40000, '2023-02-01'),
(106, 'Kiran', 5, 48000, '2021-08-12'),
(107, 'Anita', 2, 68000, '2020-09-18'),
(108, 'Rahul', 3, 55000, '2018-12-30'),
(109, 'Meena', 1, 50000, '2019-04-25'),
(110, 'Vikas', 4, 62000, '2022-07-14');

-- Queries
SELECT e.EmpID, e.EmpName, d.DeptName
FROM Employee e
JOIN Department d
ON e.DeptID = d.DeptID;

SELECT d.DeptName, COUNT(e.EmpID) AS TotalEmployees
FROM Department d
LEFT JOIN Employee e
ON d.DeptID = e.DeptID
GROUP BY d.DeptName;

SELECT EmpID, EmpName, Salary
FROM Employee
WHERE Salary > 50000;

SELECT d.DeptName, COUNT(e.EmpID) AS TotalEmployees
FROM Employee e
JOIN Department d
ON e.DeptID = d.DeptID
GROUP BY d.DeptName
ORDER BY TotalEmployees DESC
LIMIT 1;

SELECT d.DeptName, AVG(e.Salary) AS AvgSalary
FROM Employee e
JOIN Department d
ON e.DeptID = d.DeptID
GROUP BY d.DeptName;

-- Stored Procedure 
CREATE OR REPLACE PROCEDURE GetEmployeesByDept(p_dept_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT EmpID, EmpName, Salary, JoiningDate
    FROM Employee
    WHERE DeptID = p_dept_id;
END;
$$;

CALL GetEmployeesByDept(2);
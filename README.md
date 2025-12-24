# 📘 SQL Assignments 

This repository contains **two SQL assignments** designed to practice and demonstrate SQL concepts using **PostgreSQL** and **pgAdmin 4**.

---

## 📌 Objective

The assignments aim to help learners understand and implement:

- DDL (Data Definition Language)
- DML (Data Manipulation Language)
- DCL (Data Control Language)
- JOINS and their use cases
- Aggregate functions (SUM, AVG, COUNT)
- Subqueries
- Window functions (ROW_NUMBER, RANK, SUM() OVER())
- Stored Procedures / Functions
- Database design, normalization, and relationships

---

## 🛠 Tools & Technologies Used

- Database: PostgreSQL
- Client Tool: pgAdmin 4
- Language: SQL (PostgreSQL – plpgsql)

---

## 📂 Assignment 1: Employee & Department Database

**Objective**:  
Practice basic SQL operations, table creation, inserting data, joins, aggregates, and stored procedures.

### Step-by-Step Guide

1. **Open pgAdmin & Create Database**  
   - Right-click Databases → Create → Database  
   - Name: `employee_db`  

2. **Open Query Tool**  
   - Expand `employee_db → Schemas → public` → Right-click → Query Tool  

3. **Create Tables (DDL)**  
   - `Department` (Parent table)  
   - `Employee` (Child table, FK referencing Department)  

4. **Insert Sample Data (DML)**  
   - Insert 5 departments and 10 employees  

5. **SQL Queries**  
   - Employees with Department Name (INNER JOIN)  
   - Total Employees in Each Department (LEFT JOIN + COUNT)  
   - Employees with Salary > 50000 (WHERE clause)  
   - Department with Highest Employees (GROUP BY + ORDER BY + LIMIT)  
   - Average Salary per Department (AVG + GROUP BY)  

6. **Stored Procedure**  
   - Create a procedure to fetch employees by DepartmentID  
   - Execute using `CALL GetEmployeesByDept(2)`  

7. **Save SQL Script**  
   - File name: `Assignment1_Employee_Department_PostgreSQL.sql`  

---

## 📂 Assignment 2: Sales & Products Database

**Objective**:  
Practice advanced SQL concepts including window functions, complex joins, subqueries, and stored procedures/functions.

### Step-by-Step Guide

1. **Open pgAdmin & Create Database**  
   - Right-click Databases → Create → Database  
   - Name: `sales_db`  

2. **Open Query Tool**  
   - Expand `sales_db → Schemas → public` → Right-click → Query Tool  

3. **Create Tables (DDL)**  
   - `Category` (Primary table)  
   - `Products` (FK referencing Category)  
   - `Sales` (FK referencing Products)  

4. **Insert Sample Data (DML)**  
   - 5 Categories  
   - 20 Products  
   - 30 Sales records  

5. **Complex SQL Queries**  
   - Total quantity sold and total sales amount per product (JOIN + SUM)  
   - Top 3 products with highest sales in the last month (JOIN + GROUP BY + ORDER BY + LIMIT)  
   - Cumulative sales over time (WINDOW function: SUM() OVER())  
   - Rank products based on total sales (RANK() OVER())  
   - Products with sales above average (Subquery)  

6. **Stored Function**  
   - Create a function `GetCategorySales(CategoryID, StartDate, EndDate)` to return total sales per category  
   - Execute using `SELECT * FROM GetCategorySales(...)`  

7. **Save SQL Script**  
   - File name: `Assignment2_Sales_Products_PostgreSQL.sql`  

---

## 🧭 Steps to Execute Assignments in pgAdmin

1. Open **pgAdmin** and connect to PostgreSQL server.  
2. Create the respective database (`employee_db` or `sales_db`).  
3. Open **Query Tool** for the database.  
4. Execute SQL scripts step by step:
   - Create tables  
   - Insert sample data  
   - Run queries  
   - Create stored procedures/functions  
5. Verify inserted data using **View/Edit Data → All Rows**.  

---

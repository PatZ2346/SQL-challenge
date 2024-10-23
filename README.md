# SQL-challenge #
Assignment 9

## Employee Database Management ##

### Overview ###
- This project involves creating and managing an employee database using PostgreSQL. The goal is to import data from CSV files into SQL tables, establish relationships between the tables, and execute various queries to retrieve meaningful insights from the data.

### Prerequisites ###
- PostgreSQL
- pgAdmin 4
- Python (optional for data formatting)
- QuickDBD (for ERD visualization)
- CSV files containing employee data

### File Structure ###
1. Resources
- employees.csv
- departments.csv
- dept_emp.csv
- dept_manager.csv
- salaries.csv
- titles.csv
2. SQL files
- queries.sql: File containing SQL queries for data retrieval
- tables_shemata.sql: File containing SQL table creation
- validate_data.sql: File containing queries to check data after import
3. ERD Visualization
- QuickDBD ERD visualization tool to bring your structure to life

### Setting Up ###
1. Setting Up the Database: 
- Open pgAdmin 4 and connect to your PostgreSQL server.
- Create a new database named SQL-challenge.

### Creating Tables ###
2. Run the following SQL script in your new SQL-challenge database Query Tool to create the necessary tables:

-- Create Employees table
CREATE TABLE Employees (
    emp_no INT NOT NULL,
    emp_title VARCHAR(255),
    birth_date DATE NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    sex CHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (emp_no)
);

-- Create Departments table
CREATE TABLE Departments (
    dept_no VARCHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (dept_no)
);

-- Create Dept_manager table
CREATE TABLE Dept_manager (
    dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

-- Create Dept_emp table
CREATE TABLE Dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

-- Create Salaries table
CREATE TABLE Salaries (
    emp_no INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

-- Create Titles table
CREATE TABLE Titles (
    title_id VARCHAR(10) NOT NULL,
    title VARCHAR(255) NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (title_id)
);

### Importing Data ###
3. Import the CSV data into their respective tables in the following order to maintain referential integrity:
- Employees
- Departments
- Titles
- Dept_emp
- Dept_manager
- Salaries

### How To Import Data ###
4. Importing CSV Data Using pgAdmin 4:
- Open pgAdmin and select your SQL-challenge database.
- Right-click on each table and choose Import/Export Data.
- Set the Filename to your CSV path (e.g., C:\Users\folder\SQL-challenge\Resources\employees.csv).
- Ensure Format is CSV and Header is set to Yes.
- Adjust Delimiter and Null representation as needed.
- Click Import to load the data.

### Validating Data Import ###
5. Run the following queries to check data in each table:
- SELECT * FROM Employees;
- SELECT * FROM Departments;
- SELECT * FROM Titles;
- SELECT * FROM Dept_emp;
- SELECT * FROM Dept_manager;
- SELECT * FROM Salaries;

### Executing Queries ###
6. Use the provided queries.sql file to run and retrieve data:

1) List the employee number, last name, first name, sex, and salary of each employee.
` SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM Employees e
JOIN Salaries s ON e.emp_no = s.emp_no;

2) List the first name, last name, and hire date for the employees who were hired in 1986.
` SELECT first_name, last_name, hire_date
FROM Employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

3) List the manager of each department along with their department number, department name, employee number, last name, and first name.
` SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM Dept_manager dm
JOIN Employees e ON dm.emp_no = e.emp_no
JOIN Departments d ON dm.dept_no = d.dept_no;

4) List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
` SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM Dept_emp de
JOIN Employees e ON de.emp_no = e.emp_no
JOIN Departments d ON de.dept_no = d.dept_no;

5) List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
` SELECT first_name, last_name, sex
FROM Employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

6) List each employee in the Sales department, including their employee number, last name, and first name.
` SELECT e.emp_no, e.last_name, e.first_name
FROM Dept_emp de
JOIN Employees e ON de.emp_no = e.emp_no
JOIN Departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

7) List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
` SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM Dept_emp de
JOIN Employees e ON de.emp_no = e.emp_no
JOIN Departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-- 8) List the frequency counts, in descending order, of all the employee last names.
` SELECT last_name, COUNT(last_name) AS frequency
FROM Employees
GROUP BY last_name
ORDER BY frequency DESC;

### Creating .sql File ###
7. Windows(Notepad, VSCode), Mac(TextEdit, VSCode):
- Open a Text Editor (Notepad, VS Code, TextEdit or similar).
- Copy and Paste Queries into the text editor.
- Save as queries.sql ensuring the file type is set to All Files.

### ERD Visualization ###
8. Use QuickDBD to visualize your database schema. Type the following structure into QuickDBD:

Employees 
-- 
-emp_no INT PK 
-emp_title VARCHAR(255) 
-birth_date "DATE NOT NULL" 
-first_name "VARCHAR(255) NOT NULL" 
-last_name "VARCHAR(255) NOT NULL" 
-sex "CHAR(1) NOT NULL" 
-hire_date "DATE NOT NULL" 
 
Departments 
-- 
-dept_no VARCHAR(4) PK 
-dept_name "VARCHAR(40) NOT NULL" 
 
Dept_manager 
-- 
-dept_no VARCHAR(4) FK >- Departments.dept_no 
-emp_no INT FK >- Employees.emp_no 
-PRIMARYKEY "(dept_no, emp_no)" 
 
Dept_emp 
-- 
-emp_no INT FK >- Employees.emp_no 
-dept_no VARCHAR(4) FK >- Departments.dept_no 
-PRIMARYKEY "(emp_no, dept_no)" 
 
Salaries 
-- 
-emp_no INT FK >- Employees.emp_no 
-salary "DECIMAL(10, 2) NOT NULL" 
-PRIMARYKEY "(emp_no)" 
 
Titles 
-- 
-title_id VARCHAR(10) PK 
-title "VARCHAR(255) NOT NULL" 
 

### Conclusion ###
- This guide walks you through setting up and managing an employee database using PostgreSQL. You’ll create tables, import data, and execute queries to gain insights from your dataset. Happy querying!
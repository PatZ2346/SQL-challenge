-- Create Employees table.
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

-- Create Departments table.
CREATE TABLE Departments (
    dept_no VARCHAR(4) NOT NULL,
    dept_name VARCHAR(40) NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (dept_no)
);

-- Create Salaries table.
CREATE TABLE Salaries (
    emp_no INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

-- Create Titles table.
CREATE TABLE Titles (
    title_id VARCHAR(10) NOT NULL,
    title VARCHAR(255) NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (title_id)
);

-- Create Dept_emp table.
CREATE TABLE Dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

-- Create Dept_manager table.
CREATE TABLE Dept_manager (
    dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);

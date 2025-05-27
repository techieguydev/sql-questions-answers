-- Find out the employee name who has highest and lowest salary in each department
-- Create a table named `employees` with the following structure:
CREATE TABLE public.employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary NUMERIC(10, 2) NOT NULL
);
-- Prepare input data for the query:
INSERT INTO public.employees(id, name, department, salary) VALUES (1, 'Alice', 'HR', 5000);
INSERT INTO public.employees(id, name, department, salary) VALUES (2, 'Bob', 'HR', 6000);
INSERT INTO public.employees(id, name, department, salary) VALUES (3, 'Charlie', 'IT', 7000);
INSERT INTO public.employees(id, name, department, salary) VALUES (4, 'David', 'IT', 8000);
INSERT INTO public.employees(id, name, department, salary) VALUES (5, 'Eve', 'Finance', 9000);
INSERT INTO public.employees(id, name, department, salary) VALUES (6, 'Frank', 'Finance', 4000);
INSERT INTO public.employees(id, name, department, salary) VALUES (7, 'Grace', 'HR', 3000);
INSERT INTO public.employees(id, name, department, salary) VALUES (8, 'Hank', 'IT', 2000);
INSERT INTO public.employees(id, name, department, salary) VALUES (9, 'Ivy', 'Finance', 10000);
INSERT INTO public.employees(id, name, department, salary) VALUES (10, 'Jack', 'HR', 1500);

-- Query to find the employee name who has highest and lowest salary in each department
-- Solution 1:
WITH RankedSalaries AS (
    SELECT 
        name,
        department,
        salary,
        ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn_highest,
        ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary ASC) AS rn_lowest
    FROM public.employees
)
SELECT 
    department,
    MAX(CASE WHEN rn_highest = 1 THEN name END) AS highest_salary_employee,
    MAX(CASE WHEN rn_lowest = 1 THEN name END) AS lowest_salary_employee
FROM RankedSalaries
GROUP BY department;

-- Solution 2:
SELECT 
    department,,
    MAX(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS highest_salary,
    MIN(salary) OVER (PARTITION BY department ORDER BY salary ASC) AS lowest_salary
FROM public.employees
GROUP BY department;
-- Find out the employee hierarchy in a company.

-- Create a table named `employees` with the following structure:
DROP TABLE IF EXISTS public.employees;
CREATE TABLE public.employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    manager_id INT,
    salary NUMERIC(10, 2) NOT NULL,
    designation VARCHAR(50) NOT NULL,
    FOREIGN KEY (manager_id) REFERENCES public.employees(id)
);

-- Prepare input data for the query:
INSERT INTO public.employees(id, name, manager_id, salary, designation) VALUES (1, 'Alice', NULL, 5000, 'CEO');
INSERT INTO public.employees(id, name, manager_id, salary, designation) VALUES (2, 'Bob', 1, 4000, 'CTO');
INSERT INTO public.employees(id, name, manager_id, salary, designation) VALUES (3, 'Charlie', 1, 4500, 'CFO');
INSERT INTO public.employees(id, name, manager_id, salary, designation) VALUES (4, 'David', 2, 3000, 'Senior Developer');
INSERT INTO public.employees(id, name, manager_id, salary, designation) VALUES (5, 'Eve', 2, 3500, 'Junior Developer');
INSERT INTO public.employees(id, name, manager_id, salary, designation) VALUES (6, 'Frank', 3, 3200, 'Accountant');
INSERT INTO public.employees(id, name, manager_id, salary, designation) VALUES (7, 'Grace', 4, 2800, 'Intern');
INSERT INTO public.employees(id, name, manager_id, salary, designation) VALUES (8, 'Hank', 5, 2900, 'Intern');

-- Query to find the employee hierarchy in a company
-- Solution 1: Using a recursive CTE to find the hierarchy
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT 
        id,
        name,
        manager_id,
        salary,
        designation,
        0 AS level
    FROM public.employees
    WHERE manager_id IS NULL  -- Start with the top-level employee (CEO)
    
    UNION ALL
    
    SELECT 
        e.id,
        e.name,
        e.manager_id,
        e.salary,
        e.designation,
        eh.level + 1
    FROM public.employees e
    JOIN EmployeeHierarchy eh ON e.manager_id = eh.id
)
SELECT 
    id,
    name,
    manager_id,
    salary,
    designation,
    level
FROM EmployeeHierarchy
ORDER BY level, name;
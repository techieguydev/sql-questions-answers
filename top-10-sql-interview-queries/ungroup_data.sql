-- Ungroup data in SQL
-- Create a table named `sales_data` with the following structure:
CREATE TABLE public.sales_data (
    id SERIAL PRIMARY KEY,
    product VARCHAR(100) NOT NULL,
    sales INT NOT NULL
);

-- Prepare input data for the query:
INSERT INTO public.sales_data(id, product, sales) VALUES (1, 'Product A', 2);
INSERT INTO public.sales_data(id, product, sales) VALUES (2, 'Product B', 1);
INSERT INTO public.sales_data(id, product, sales) VALUES (3, 'Product C', 4);
INSERT INTO public.sales_data(id, product, sales) VALUES (4, 'Product D', 5);

-- Query to ungroup data in SQL

-- Solution 1: Using a recursive CTE to ungroup data
WITH RECURSIVE ungrouped_sales AS (
    SELECT id, product, sales, 1 AS sales_count
    FROM public.sales_data
    WHERE sales > 0
    UNION ALL
    SELECT id, product, sales, sales_count + 1
    FROM ungrouped_sales
    WHERE sales_count < sales
)
SELECT id, product, sales_count AS sales
FROM ungrouped_sales
ORDER BY sales_count;

-- Solution 2: Using recursive CTE with a limit
WITH RECURSIVE cte AS (
    SELECT id, product, sales, 1 as total_count
    FROM public.sales_data
    UNION ALL
    SELECT cte.id, cte.product, cte.sales - 1, total_count + 1
    FROM cte
    JOIN public.sales_data sd on sd.product = cte.product
    AND sd.id = cte.id
    WHERE cte.sales > 1)
SELECT id, product, total_count AS sales
FROM cte
ORDER BY id, sales;

-- Solution 3: Using a numbers table to ungroup data
WITH numbers AS (
    SELECT generate_series(1, (SELECT MAX(sales) FROM public.sales_data)) AS n
)
SELECT sd.id, sd.product, n.n AS sales
FROM public.sales_data sd
JOIN numbers n ON n.n <= sd.sales
ORDER BY sd.id, n.n;

-- Solution 4: Using a lateral join to ungroup data
SELECT sd.id, sd.product, n.n AS sales
FROM public.sales_data sd,
LATERAL (
    SELECT generate_series(1, sd.sales) AS n
) AS n
ORDER BY sd.id, n.n;


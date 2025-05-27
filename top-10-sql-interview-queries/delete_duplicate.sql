-- Delete duplicate rows from a table while keeping the row with the lowest ID

-- INSERT INTO public.cars(model_id, model_name, color, brand) VALUES (1, 'Leaf', 'Black', 'Nissan');
-- INSERT INTO public.cars(model_id, model_name, color, brand) VALUES (2, 'Leaf', 'Black', 'Nissan');

-- INSERT INTO public.cars(model_id, model_name, color, brand) VALUES (3, 'Model S', 'Black', 'Tesla');

-- INSERT INTO public.cars(model_id, model_name, color, brand) VALUES (4, 'Model X', 'White', 'Tesla');

-- INSERT INTO public.cars(model_id, model_name, color, brand) VALUES (5, 'Ioniq 5', 'Black', 'Hyundai');
-- INSERT INTO public.cars(model_id, model_name, color, brand) VALUES (6, 'Ioniq 6', 'Black', 'Hyundai');

-- INSERT INTO public.cars(model_id, model_name, color, brand) VALUES (7, 'Ioniq 6', 'White', 'Hyundai');

-- Solution 1:
DELETE FROM public.cars WHERE model_id NOT IN 
    (SELECT MIN(model_id) FROM public.cars GROUP BY model_name, color, brand);

-- Solution 2:
DELETE FROM public.cars WHERE ctid in (SELECT MAX(ctid) FROM public.cars GROUP BY model_name, color, brand HAVING COUNT(1) > 1);

-- Solution 3:
WITH cte AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY model_name, color, brand ORDER BY model_id) AS rn
    FROM public.cars
)
DELETE FROM cte WHERE rn > 1;

-- Solution 4:
WITH cte AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY model_name, color, brand ORDER BY model_id) AS rn
    FROM public.cars
)
DELETE FROM public.cars
WHERE model_id IN (
    SELECT model_id FROM cte WHERE rn > 1
);

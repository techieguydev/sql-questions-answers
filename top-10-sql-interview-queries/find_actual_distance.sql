# From teh given cars_travel table, we need to find the actual distance traveled by each car corresponding to earch day:
-- Create a table named `cars_travel` with the following structure:
CREATE TABLE public.cars_travel (
    car_id SERIAL PRIMARY KEY,
    cars VARCHAR(40) NOT NULL,
    days VARCHAR(10) NOT NULL,
    cumulative_distance NUMERIC NOT NULL
);
-- Prepare input data for the query:
INSERT INTO public.cars_travel(car_id, cars, days, cumulative_distance) VALUES (1, 'Car A', 'Day1', 100);
INSERT INTO public.cars_travel(car_id, cars, days, cumulative_distance) VALUES (2, 'Car A', 'Day2', 150);
INSERT INTO public.cars_travel(car_id, cars, days, cumulative_distance) VALUES (3, 'Car A', 'Day3', 200);
INSERT INTO public.cars_travel(car_id, cars, days, cumulative_distance) VALUES (4, 'Car B', 'Day1', 80);
INSERT INTO public.cars_travel(car_id, cars, days, cumulative_distance) VALUES (5, 'Car B', 'Day2', 120);
INSERT INTO public.cars_travel(car_id, cars, days, cumulative_distance) VALUES (6, 'Car B', 'Day3', 180);
INSERT INTO public.cars_travel(car_id, cars, days, cumulative_distance) VALUES (7, 'Car C', 'Day1', 90);
INSERT INTO public.cars_travel(car_id, cars, days, cumulative_distance) VALUES (8, 'Car C', 'Day2', 130);
INSERT INTO public.cars_travel(car_id, cars, days, cumulative_distance) VALUES (9, 'Car C', 'Day3', 170);
-- Query to find the actual distance traveled by each car corresponding to each day
-- Solution 1:
SELECT *, cumulative_distance - LAG(cumulative_distance, 1, 0) OVER (PARTITION BY cars ORDER BY days) as distance_traveled
FROM public.cars_travel;


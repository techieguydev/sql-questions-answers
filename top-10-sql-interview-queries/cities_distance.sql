-- Find out the distance between two cities.

-- Create a table named `cities_distance` with the following structure:
CREATE TABLE public.cities_distance (
    id SERIAL PRIMARY KEY,
    city1 VARCHAR(100) NOT NULL,
    city2 VARCHAR(100) NOT NULL,
    distance NUMERIC NOT NULL
);
-- Prepare input data for the query:
INSERT INTO public.cities_distance(id, city1, city2, distance) VALUES (1, 'City A', 'City B', 100);
INSERT INTO public.cities_distance(id, city1, city2, distance) VALUES (2, 'City B', 'City A', 100);
INSERT INTO public.cities_distance(id, city1, city2, distance) VALUES (3, 'City C', 'City D', 150);
INSERT INTO public.cities_distance(id, city1, city2, distance) VALUES (4, 'City D', 'City C', 150);
INSERT INTO public.cities_distance(id, city1, city2, distance) VALUES (5, 'City E', 'City F', 400);
INSERT INTO public.cities_distance(id, city1, city2, distance) VALUES (6, 'City F', 'City E', 400);

SELECT * FROM public.cities_distance;

-- Query to find the distance between two cities
-- Solution 1:
WITH cte AS (
    SELECT
        city1,
        city2,
        distance,
        ROW_NUMBER() OVER () AS rn
    FROM public.cities_distance)
SELECT 
    c1.city1 AS city_from,
    c1.city2 AS city_to,
    c1.distance
FROM cte c1
LEFT JOIN cte c2 ON c1.city1 = c2.city2 AND c1.city2 = c2.city1
WHERE c1.rn < c2.rn
ORDER BY c1.city1;
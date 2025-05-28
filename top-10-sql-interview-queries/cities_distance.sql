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




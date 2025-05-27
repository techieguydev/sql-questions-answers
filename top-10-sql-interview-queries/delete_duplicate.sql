-- Delete duplicate rows from a table while keeping the row with the lowest ID

INSERT INTO public.cars(model_id, model_name, color, brand) VALUES (1, 'Leaf', 'Black', 'Nissan');
INSERT INTO public.cars(model_id, model_name, color, brand) VALUES (2, 'Leaf', 'Black', 'Nissan');

INSERT INTO public.cars(model_id, model_name, color, brand) VALUES (3, 'Model S', 'Black', 'Tesla');

INSERT INTO public.cars(model_id, model_name, color, brand) VALUES (4, 'Model X', 'White', 'Tesla');

INSERT INTO public.cars(model_id, model_name, color, brand) VALUES (5, 'Ioniq 5', 'Black', 'Hyundai');
INSERT INTO public.cars(model_id, model_name, color, brand) VALUES (6, 'Ioniq 6', 'Black', 'Hyundai');

INSERT INTO public.cars(model_id, model_name, color, brand) VALUES (7, 'Ioniq 6', 'White', 'Hyundai');
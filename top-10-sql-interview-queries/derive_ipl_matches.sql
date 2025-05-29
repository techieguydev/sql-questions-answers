-- Derive IPL matches from the given data
-- There are 10 IPL teams. 
-- 1. Each team plays with every other team twice, once at home and once away.
-- 2. Each team plays a total of 18 matches.
-- 3. Each team plays 9 home matches and 9 away matches.
-- 4. Each team plays with every other team twice, once at home and once away.

-- Create a table named `ipl_teams` with the following structure:
CREATE TABLE public.ipl_teams (
    id SERIAL PRIMARY KEY,
    team_code VARCHAR(10) NOT NULL,
    team_name VARCHAR(100) NOT NULL
);

-- Prepare input data for the query:
INSERT INTO public.ipl_teams(id, team_code, team_name) VALUES (1, 'CSK', 'Chennai Super Kings');
INSERT INTO public.ipl_teams(id, team_code, team_name) VALUES (2, 'MI', 'Mumbai Indians');
INSERT INTO public.ipl_teams(id, team_code, team_name) VALUES (3, 'RCB', 'Royal Challengers Bangalore');
INSERT INTO public.ipl_teams(id, team_code, team_name) VALUES (4, 'KKR', 'Kolkata Knight Riders');
INSERT INTO public.ipl_teams(id, team_code, team_name) VALUES (5, 'SRH', 'Sunrisers Hyderabad');
INSERT INTO public.ipl_teams(id, team_code, team_name) VALUES (6, 'DC', 'Delhi Capitals');
INSERT INTO public.ipl_teams(id, team_code, team_name) VALUES (7, 'PBKS', 'Punjab Kings');
INSERT INTO public.ipl_teams(id, team_code, team_name) VALUES (8, 'RR', 'Rajasthan Royals');
INSERT INTO public.ipl_teams(id, team_code, team_name) VALUES (9, 'GT', 'Gujarat Titans');
INSERT INTO public.ipl_teams(id, team_code, team_name) VALUES (10, 'LSG', 'Lucknow Super Giants');

-- Query to derive IPL matches
-- Solution 1: Using a self-join to derive matches
WITH matches AS (
    SELECT 
        t1.team_code AS home_team_code,
        t1.team_name AS home_team,
        t2.team_code AS away_team_code,
        t2.team_name AS away_team
    FROM public.ipl_teams t1
    JOIN public.ipl_teams t2 ON t1.id <> t2.id
)
SELECT 
    home_team_code,
    home_team,
    away_team_code,
    away_team,
    ROW_NUMBER() OVER (PARTITION BY home_team ORDER BY away_team) AS match_number
FROM matches
ORDER BY home_team, away_team;



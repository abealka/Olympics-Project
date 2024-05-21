-- Olympic Medal Project
-- Consolidate duplicates 

-- 1a. check duplicates for the athlete table
WITH athlete_cte AS 
(
SELECT *, 
ROW_NUMBER () OVER (
PARTITION BY athlete_full_name, games_participations, first_game, athlete_year_birth) AS row_num 
FROM olympic.athletes_update
)
SELECT *
FROM athlete_cte
WHERE	row_num > 1;

-- 1 result: need to assess Vinzenz GEIGER 

DELETE FROM olympic.athletes_update
WHERE athlete_full_name = 'Vinzenz Geiger' 
AND LOWER(athlete_full_name) = LOWER('Vinzenz Geiger') 
AND athlete_full_name <> 'Vinzenz GEIGER';

SELECT *
FROM olympic.athletes_update
WHERE athlete_full_name = 'Vinzenz GEIGER';
-- it appears i accidently deleted both of the values. i do have the values from the raw table, so I will populate them back in for only 1.

INSERT INTO olympic.athletes_update (athlete_full_name, games_participations, first_game, athlete_year_birth)
VALUES ('Vinzenz GEIGER', '2', 'PyeongChang 2018', '1997');

-- 1b. check duplicates for hosts, 0 results returned
WITH hosts_cte AS 
(
SELECT *, 
ROW_NUMBER () OVER (
PARTITION BY game_slug, game_end_date, game_start_date, game_location, game_name, game_season, game_year) AS row_num 
FROM olympic.hosts_update
)
SELECT *
FROM hosts_cte
WHERE	row_num > 1;

-- 1c. check duplicates for medals table, originally 251 results returned, which most likely is due to team events
WITH medals_cte AS 
(
SELECT *, 
ROW_NUMBER () OVER (
PARTITION BY discipline_title, slug_game, event_title, event_gender, medal_type, participant_type, participant_title, athlete_url, athlete_full_name, country_name, country_code, country_3_letter_code) AS row_num 
FROM olympic.medals_update
)
SELECT *
FROM medals_cte
WHERE	row_num > 1;

-- 3d. check duplicates for results table, orignially 116 results returned, however, they are all values before 1938, which should be kept in mind later, it's likely due to record keeping changes since then.
WITH results_cte AS 
(
SELECT *, 
ROW_NUMBER () OVER (
PARTITION BY discipline_tile, event_title, slug_name, participant_type, medal_type, athletes, rank_equal, rank_position, country_name, country_code, country_3_letter_code, athlete_url, athlete_full_name, value_unit, value_type) AS row_num 
FROM olympic.results_update
)
SELECT *
FROM results_cte
WHERE	row_num > 1
ORDER BY slug_name;
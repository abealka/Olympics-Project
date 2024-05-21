-- Olympic Medal Project
-- Standardize Data
-- Checks and updates by table and then columns within that table, nulls delt with later on

-- 1. check athletes_update table and columns 

-- 1a. check and update the name column
SELECT athlete_full_name
FROM olympic.athletes_update
WHERE NOT athlete_full_name REGEXP '^[A-Z][a-z]*([ -][A-Z][a-z]*)*$';

/* the following names are not correct
'CIRENZHANDUI ': after searching web results it appears they go by only the one name on records
'. DENI': same as above, only DENI is available
'. PRIYANKA': found her full name 'Priyanka GOSWAMI'
'. RAHUL': 'Rahul ROHILLA' */

SELECT *
FROM olympic.athletes_update
WHERE athlete_full_name IN ('CIRENZHANDUI ', '. DENI', '. PRIYANKA', '. RAHUL');

UPDATE olympic.athletes_update
SET athlete_full_name= TRIM(athlete_full_name);

UPDATE olympic.athletes_update
SET athlete_full_name = 'DENI'
WHERE athlete_full_name = '. DENI';

UPDATE olympic.athletes_update
SET athlete_full_name = 'Priyanka GOSWAMI'
WHERE athlete_full_name = '. PRIYANKA';

UPDATE olympic.athletes_update
SET athlete_full_name = 'Rahul ROHILLA'
WHERE athlete_full_name = '. RAHUL';

-- 1b. check the games_participation column
SELECT DISTINCT games_participations
FROM olympic.athletes_update
ORDER BY 1;

-- 1c. check the first_game column
SELECT DISTINCT first_game
FROM olympic.athletes_update
ORDER BY 1;

-- 1d. check athlete birth year, originally wanted to change this column from int to year, but there are values prior to 1900 which MySQL does not support
SELECT DISTINCT athlete_year_birth
FROM olympic.athletes_update
ORDER BY 1;

UPDATE olympic.athletes_update
SET athlete_year_birth = TRIM(athlete_year_birth);

SELECT *
FROM olympic.athletes_update
WHERE athlete_year_birth < 1901 OR athlete_year_birth > 2155;

-- update Raimo VIGANTS(1999) and Thibaut DE MARRE(1998), because cleary they were not born in 1900 if they went to Beijing 2022
UPDATE olympic.athletes_update
SET athlete_year_birth = 1999
WHERE athlete_full_name = 'Raimo VIGANTS';

UPDATE olympic.athletes_update
SET athlete_year_birth = 1998
WHERE athlete_full_name = 'Thibaut DE MARRE';

-- 2. check hosts table

-- 2a. check game_slug column
UPDATE olympic.hosts_update2
SET game_slug = TRIM(game_slug);

-- 2b. check and update game_end_date column from string to date
SELECT *
FROM olympic.hosts_update2
ORDER BY game_end_date;

SELECT *, 
STR_TO_DATE(SUBSTRING(game_end_date, 1, 10), '%Y-%m-%d')
FROM olympic.hosts_update2;

UPDATE olympic.hosts_update2
SET game_end_date = STR_TO_DATE(SUBSTRING(game_end_date, 1, 10), '%Y-%m-%d');

ALTER TABLE olympic.hosts_update2
MODIFY COLUMN game_end_date DATE;

-- 2c. check and update game_start_date column from string to date
SELECT *,
STR_TO_DATE(SUBSTRING(game_start_date, 1, 10), '%Y-%m-%d')
FROM olympic.hosts_update2;

UPDATE olympic.hosts_update2
SET game_start_date = STR_TO_DATE(SUBSTRING(game_start_date, 1, 10), '%Y-%m-%d');

ALTER TABLE olympic.hosts_update2
MODIFY COLUMN game_start_date DATE;

-- 2d. check game_location column
SELECT DISTINCT game_location
FROM olympic.hosts_update2
ORDER BY game_location;
/*
note: "Australia, Sweden" has duplicates. after research, it appears these games were in 1956 and held the summer olympics. only the equestrian events were in Sweden. everything else was in australia
*/

SELECT *
FROM olympic.hosts_update2
WHERE game_location = 'Australia, Sweden';

-- 2e. check game_name column
SELECT DISTINCT game_name
FROM olympic.hosts_update2
ORDER BY game_name;

-- create two additional columns that have city and year in seperate columns in hosts_update2
ALTER TABLE olympic.hosts_update2
ADD COLUMN city VARCHAR(255),
ADD COLUMN year VARCHAR(4);

UPDATE olympic.hosts_update2
SET 
    city = TRIM(SUBSTRING(game_name, 1, LENGTH(game_name) - 4)),
    year = RIGHT(game_name, 4);
    
SELECT city, year
FROM olympic.hosts_update2;

-- 2f. check game_season column
SELECT DISTINCT game_season
FROM olympic.hosts_update2;

-- 2g. check game_year
-- note: summer and winter games were held in the same year from 1924 to 1992 and occured every 4 years
SELECT DISTINCT game_year
FROM olympic.hosts_update2
ORDER BY game_year;

-- the first games are before 1900, so the data type can't be changed to year, for easier manipulation later, update to varchar(4)
ALTER TABLE olympic.hosts_update2
MODIFY COLUMN game_year VARCHAR(4);

-- 3. check medals_update table

-- 3a. check discipline_title
-- note that there are different categories for gymnastics, cycling, and canoe. also Baseball and Softball are in the same discipline as "Baseball/Softball"
SELECT DISTINCT discipline_title
FROM olympic.medals_update
ORDER BY discipline_title;

-- 3b. check slug_name column
-- this table only goes back to 2016, leave the other columns how they are unless using for analysis later on
SELECT DISTINCT slug_game
FROM olympic.medals_update
ORDER BY slug_game;

-- 4. check results_update table
-- 4a. check discipline_tile column
SELECT DISTINCT discipline_tile
FROM olympic.results_update
ORDER BY discipline_tile;

-- 4b. check event_title column
SELECT DISTINCT event_title
FROM olympic.results_update
ORDER BY event_title;
SELECT 
    COUNT(DISTINCT event_title) AS distinct_event_count
FROM 
    olympic.results_update;
/* after reviewing, there are varrying formats for event title, because of the different disciplines. 
during queries later on, come back to change if something is off*/

-- 4c. check and update slug_name column
SELECT DISTINCT slug_name
FROM olympic.results_update
ORDER BY slug_name;

-- create an additional year column
ALTER TABLE olympic.results_update
ADD COLUMN game_year VARCHAR(4);

UPDATE olympic.results_update
SET game_year = RIGHT(slug_name, 4);

SELECT DISTINCT game_year
FROM olympic.results_update
ORDER BY game_year;

-- 4d. check participant_type
SELECT DISTINCT participant_type
FROM olympic.results_update
ORDER BY participant_type;

-- 4e. check medal_type
SELECT DISTINCT medal_type
FROM olympic.results_update
ORDER BY medal_type;

-- 4f. check athletes
SELECT DISTINCT athletes
FROM olympic.results_update
ORDER BY athletes;

-- 4g. check athlete_url
SELECT DISTINCT athlete_url
FROM olympic.results_update
ORDER BY athlete_url;

-- 4h. check athlete_full_name
SELECT DISTINCT athlete_full_name
FROM olympic.results_update
ORDER BY athlete_full_name;

-- since the athletes column is a combonation of url and full_name, the full_name column should be used later on
-- trim the names that begin with -
UPDATE olympic.results_update
SET athlete_full_name = TRIM(LEADING '-' FROM athlete_full_name)
WHERE athlete_full_name LIKE '-%';

-- change the names that are --- to null, only 2 rows were returned 
SELECT *
FROM olympic.results_update
WHERE athlete_full_name LIKE  '%- -%';

UPDATE olympic.results_update
SET athlete_full_name = NULL
WHERE athlete_full_name LIKE '%- -%';

-- 4i. check rank_equal
-- 4j. check rank_position

-- 4k. check country_name
-- mentioned in the overview, it should be noted that there are different countries throughout time that are not present today
SELECT DISTINCT country_name
FROM olympic.results_update
ORDER BY 1;

-- 4l. check country_code
SELECT DISTINCT country_code
FROM olympic.results_update
ORDER BY 1;

-- 4m. check_3_letter_code
SELECT DISTINCT country_3_letter_code
FROM olympic.results_update
ORDER BY 1;

-- 4n. check value_unit
SELECT DISTINCT value_unit
FROM olympic.results_update
ORDER BY 1;

-- 4o. check value_type
SELECT DISTINCT value_type
FROM olympic.results_update
ORDER BY 1;




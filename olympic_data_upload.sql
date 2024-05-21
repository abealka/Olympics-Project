-- Olympic Medal Project
-- Import and preview data
/* Steps in this query
1. Import CSV data 
2. Import compressed zip data
3. Preview data
4. Create table copies to clean data in while maintaining raw data */

-- 1. Ipmorting data done with MySQL, create table, and import CSV data into that table

-- 2. Import compressed zip data
CREATE TABLE olympic.results_raw (
	discipline_tile VARCHAR(255),
	event_title VARCHAR(255),
    slug_name VARCHAR(255),
    participant_type VARCHAR(255),
    medal_type VARCHAR(255),
    athletes VARCHAR(255),
    rank_equal VARCHAR(255),
    rank_position VARCHAR(255),
    country_name VARCHAR(255),
    country_code VARCHAR(255),
    country_3_letter_code VARCHAR(255),
    athlete_url VARCHAR(255),
    athlete_full_name VARCHAR(255),
    value_unit VARCHAR(255),
    value_type VARCHAR(255)
);
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olympic_results.csv"
INTO TABLE olympic.results_raw
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- 3. Preview data
SELECT * FROM olympic.athletes;
SELECT * FROM olympic.hosts;
SELECT * FROM olympic.medals;
SELECT * FROM olympic.results_raw;

-- 4. Create tables to clean in 
CREATE TABLE olympic.athletes_update AS SELECT * FROM olympic.athletes;
SELECT * FROM olympic.athletes_update;

-- come back for hosts_update2
CREATE TABLE olympic.hosts_update2 AS SELECT * FROM olympic.hosts;
SELECT * FROM olympic.hosts_update2;

CREATE TABLE olympic.medals_update AS SELECT * FROM olympic.medals;
SELECT * FROM olympic.medals_update;

CREATE TABLE olympic.results_update AS SELECT * FROM olympic.results_raw;
SELECT * FROM olympic.results_update;


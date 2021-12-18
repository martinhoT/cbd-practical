CREATE KEYSPACE IF NOT EXISTS restaurants WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 3};

USE restaurants;

/*
Queries

restaurant_by_locality
✓ List all restaurants
    + TABLE
✓ Return id, restaurant_id, name, locality and gastronomy for all restaurants
    + TABLE WITH id, restaurant_id, name, locality, gastronomy
✓ Return restaurant_id, name, locality, gastronomy and zipcode for all restaurants
    + TABLE WITH id, restaurant_id, name, locality, gastronomy, zipcode
✓ Total number of restaurants in locality 'Bronx'
    + TABLE WITH locality PARTITION KEY locality
✓ First 15 restaurants in locality 'Bronx', ordered in ascending order by name
    + TABLE WITH locality PARTITION KEY locality CLUSTERING KEY name CLUSTERING ORDER (name ASC)
✓ List the id, restaurant_id, name, locality and gastronomy of all restaurants localized in 'Staten Island', 'Queens' or 'Brooklyn'
    + TABLE WITH id, restaurant_id, name, locality, gastronomy PARTITION KEY locality
✓ Count the total of restaurants in each locality
    + TABLE WITH locality PARTITION KEY locality
✓ List the id, name, gastronomy and locality of all restaurants ordered in ascending order by gastronomy and, in second, in descending order by locality
    + TABLE WITH id, name, gastronomy, locality PARTITION KEY ? CLUSTERING KEY gastronomy, locality CLUSTERING ORDER (gastronomy ASC, locality DESC)
    X NOT POSSIBLE -> order in the application side (which is stupid, because the list of all restaurants will be processed)

restaurant_by_score_class
✓ Find the restaurants that got one or more scores in the interval [80, 100]
    + TABLE WITH score, score_class PARTITION KEY score_class/10 CLUSTERING KEY score

restaurant_by_score_rid_name
✓ Return the name, restaurant_id, and the sum of scores of the restaurants, ordered by the sum of scores in descending order
    + TABLE WITH name, restaurant_id, sum(score)
    ? INDEX ON sum(score) -> order in the application side

restaurant_by_latitude_class
✓ Return the restaurants with latitude lower than -95.7
    + TABLE WITH latitude, latitude_class PARTITION KEY latitude_class/15 CLUSTERING KEY latitude

restaurant_grades
✓ List the id, name and the grades of the restaurants that obtained a rating with an 'A' grade, a score of 10 on the date '2014-08-11T00: 00: 00Z' (ISODATE)
    + TABLE WITH id, name, grades PARTITION KEY grades.grade CLUSTERING KEY grades.score, grades.date WHERE grades is map-array
✓ List the id, restaurant_id, name and score of the restaurants in which the second rating was grade 'A' and occurred in ISODATE '2014-08-11T00: 00: 00Z'
    + TABLE WITH id, restaurant_id, name, grades{score,grade,date} PARTITION KEY grades.grade CLUSTERING KEY grades.date

restaurant_by_locality_zipcode
✓ Return the id, name and locality of the second, third and fourth restaurants in street 'Flatbush Avenue' with a zipcode greater than 10000, ordered by name in descending order
    + TABLE WITH id, name, locality, zipcode PARTITION KEY locality CLUSTERING KEY zipcode
    ? INDEX ON name -> order in the application side
*/

-- Exact copy. This entire structure isn't really useful for the necessary queries
-- CREATE TYPE address (
--     building        text,
--     coord           tuple<float, float>,
--     run             text,
--     zipcode         text
-- );
--
-- CREATE TYPE grade (
--     grade       ascii,
--     score       smallint,
--     date        timestamp
-- );
--
-- CREATE TABLE restaurant (
--     address         address,
--     localidade      text,
--     gastronomia     text,
--     grades          list<grade>,
--     nome            text,
--     restaurant_id   text,
--
--     PRIMARY KEY (restaurant_id, nome)
-- );

-- Main table
DROP TABLE IF EXISTS restaurant_by_locality;
CREATE TABLE restaurant_by_locality (
    locality        text,
    gastronomy      text,
    name            text,
    zipcode         int,
    restaurant_id   text,

    PRIMARY KEY (locality, name, restaurant_id)
) WITH CLUSTERING ORDER BY (name DESC);

-- Specification of main table for the last query
DROP TABLE IF EXISTS restaurant_by_street_zipcode;
CREATE TABLE restaurant_by_street_zipcode (
    restaurant_id   text,
    name            text,
    street          text,
    zipcode         int,

    PRIMARY KEY (street, zipcode, restaurant_id)
);

-- Grades table
-- The clustering order simulates the grades list order of each document present in 'retaurants.json'
DROP TABLE IF EXISTS restaurant_grades;
CREATE TABLE restaurant_grades (
    restaurant_id   text,
    name            text,
    grade           ascii,
    score           smallint,
    date            timestamp,

    PRIMARY KEY (grade, date, score, restaurant_id)
) WITH CLUSTERING ORDER BY (date DESC);

-- Grades table by restaurant_id
DROP TABLE IF EXISTS restaurant_grades_by_rid;
CREATE TABLE restaurant_grades_by_rid (
    restaurant_id   text,
    name            text,
    grade           ascii,
    score           smallint,
    date            timestamp,

    PRIMARY KEY (restaurant_id, date, grade, score)
) WITH CLUSTERING ORDER BY (date DESC);

-- Score class (intervals of 10)
DROP TABLE IF EXISTS restaurant_by_score_class;
CREATE TABLE restaurant_by_score_class (
    restaurant_id   text,
    name            text,
    score_class     int,
    score           smallint,
    date            timestamp,

    PRIMARY KEY (score_class, score, date, restaurant_id)
) WITH CLUSTERING ORDER BY (score ASC);

-- Score by name, rid
DROP TABLE IF EXISTS restaurant_by_score_rid_name;
CREATE TABLE restaurant_by_score_rid_name (
    restaurant_id   text,
    name            text,
    score           smallint,
    date            timestamp,

    PRIMARY KEY (restaurant_id, name, date)
);

-- Latitude class (intervals of 15)
DROP TABLE IF EXISTS restaurant_by_latitude_class;
CREATE TABLE restaurant_by_latitude_class (
    restaurant_id   text,
    name            text,
    latitude_class  int,
    latitude        float,

    PRIMARY KEY (latitude_class, latitude, restaurant_id)
) WITH CLUSTERING ORDER BY (latitude ASC);

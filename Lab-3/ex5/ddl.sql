CREATE KEYSPACE IF NOT EXISTS restaurants WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 3};

USE restaurants;

/*
Queries

- List all restaurants
    + TABLE
- Return id, restaurant_id, name, locality and gastronomy for all restaurants
    + TABLE WITH id, restaurant_id, name, locality, gastronomy
- Return restaurant_id, name, locality, gastronomy and zipcode for all restaurants
    + TABLE WITH id, restaurant_id, name, locality, gastronomy, zipcode
- Total number of restaurants in locality 'Bronx'
    + TABLE WITH locality PARTITION KEY locality
- First 15 restaurants in locality 'Bronx', ordered in ascending order by name
    + TABLE WITH locality CLUSTERING KEY name CLUSTERING ORDER (name ASC)
- Find the restaurants that got one or more scores in the interval [80, 100]
    + TABLE WITH score, score_class PARTITION KEY score_class/10 CLUSTERING KEY score
- Return the restaurants with latitude lower than -95.7
    + TABLE WITH latitude, latitude_class PARTITION KEY latitude_class/15 CLUSTERING KEY latitude
- List the id, restaurant_id, name, locality and gastronomy of all restaurants localized in 'Staten Island', 'Queens' or 'Brooklyn'
    + TABLE WITH id, restaurant_id, name, locality, gastronomy PARTITION KEY locality
- List the id, name and the grades of the restaurants that obtained a rating with an 'A' grade, a score of 10 on the date '2014-08-11T00: 00: 00Z' (ISODATE)
    + TABLE WITH id, name, grades PARTITION KEY grades.grade CLUSTERING KEY grades.grade, grades.score, grades.date WHERE grades is map-array
- List the id, restaurant_id, name and score of the restaurants in which the second rating was grade 'A' and occurred in ISODATE '2014-08-11T00: 00: 00Z'
    + TABLE WITH id, restaurant_id, name, grades{score,grade,date} PARTITION KEY grades.grade CLUSTERING KEY grades.grade, grades.date
- List the id, name, gastronomy and locality of all restaurants ordered in ascending order by gastronomy and, in second, in descending order by locality
    + TABLE WITH id, name, gastronomy, locality PARTITION KEY ? CLUSTERING KEY gastronomy, locality CLUSTERING ORDER (gastronomy ASC, locality DESC)
- Count the total of restaurants in each locality
    + TABLE WITH locality PARTITION KEY locality
- Return the id, name and locality of the second, third and fourth restaurants in 'Flatbush Avenue' with a zipcode greater than 10000, ordered by name in descending order
    + TABLE WITH id, name, locality, zipcode PARTITION KEY locality CLUSTERING KEY zipcode
    ? INDEX ON name
- Return the name, restaurant_id, and the sum of scores of the restaurants, ordered by the sum of scores in descending order
    + TABLE WITH name, restaurant_id, sum(score)
    ? INDEX ON sum(score)
*/

DROP TABLE IF EXISTS restaurant;
CREATE TABLE restaurant (
    id              text,
    locality        text,
    gastronomy      text,
    name            text,
    restaurant_id   text,

    PRIMARY KEY (restaurant_id)
);
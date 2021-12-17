USE restaurants;

-- 1. List all restaurants
SELECT * FROM restaurant_by_locality;

-- 2. Return id, restaurant_id, name, locality and gastronomy for all restaurants
SELECT id, restaurant_id, name, locality, gastronomy FROM restaurant_by_locality;

-- 3. Return restaurant_id, name, locality, gastronomy and zipcode for all restaurants
SELECT restaurant_id, name, locality, gastronomy, address.zipcode FROM restaurant_by_locality;

-- 4. Total number of restaurants in locality 'Bronx'
SELECT count(*) FROM restaurant_by_locality WHERE locality='Bronx';

-- 5. First 15 restaurants in locality 'Bronx', ordered in ascending order by name
SELECT * FROM restaurant_by_locality WHERE locality='Bronx' LIMIT 15;

-- 7. Find the restaurants that got one or more scores in the interval [80, 100]
SELECT * FROM restaurant_by_score_class WHERE score_class=4;

-- 8. Return the restaurants with latitude lower than -95.7
SELECT * FROM restaurant_by_latitude_class WHERE latitude_class=-12; -- [-180,-165[
SELECT * FROM restaurant_by_latitude_class WHERE latitude_class=-11; -- [-165,-150[
SELECT * FROM restaurant_by_latitude_class WHERE latitude_class=-10; -- [-150,-135[
SELECT * FROM restaurant_by_latitude_class WHERE latitude_class=-9; -- [-135,-120[
SELECT * FROM restaurant_by_latitude_class WHERE latitude_class=-8; -- [-120,-105[
SELECT * FROM restaurant_by_latitude_class WHERE latitude_class=-7 and latitude < -95.7; -- [-105, 90[
-- Application side: merge

-- 12. List the id, restaurant_id, name, locality and gastronomy of all restaurants localized in 'Staten Island', 'Queens' or 'Brooklyn'
-- This has to be done in 3 separate queries, as the 'or' operator is not supported in Cassandra
SELECT id, restaurant_id, name, locality, gastronomy FROM restaurant_by_locality WHERE locality IN {'Staten Island', 'Queens', 'Brooklyn'};

-- 14. List the id, name and the grades of the restaurants that obtained a rating with an 'A' grade, a score of 10 on the date '2014-08-11T00: 00: 00Z' (ISODATE)
SELECT id, name, grade FROM restaurant_grades WHERE grade='A' and date='2014-08-11 00:00:00' and score=10 ;

-- 15. List the id, restaurant_id, name and score of the restaurants in which the second rating was grade 'A' and occurred in ISODATE '2014-08-11T00: 00: 00Z'
SELECT id, restaurant_id, name, score FROM restaurant_grades WHERE grade='A' and date='2014-08-11 00:00:00';
-- Application side: evaluate the second one

-- 17. List the id, name, gastronomy and locality of all restaurants ordered in ascending order by gastronomy and, in second, in descending order by locality
SELECT id, name, gastronomy, locality FROM restaurant_by_locality;
-- Application side: in ascending order by gastronomy and, in second, in descending order by locality

-- 19. Count the total of restaurants in each locality
SELECT locality, count(*) FROM restaurant_by_locality GROUP BY locality;

-- 27. Return the id, name and locality of the second, third and fourth restaurants in 'Flatbush Avenue' with a zipcode greater than 10000, ordered by name in descending order
SELECT id, name, locality FROM restaurant_by_locality_zipcode WHERE locality='Flatbush Avenue' and zipcode > 10000;
-- Application side: order by name in descending order

-- 30. Return the name, restaurant_id, and the sum of scores of the restaurants, ordered by the sum of scores in descending order
SELECT name, restaurant_id, sum(score) as score_sum FROM restaurant_by_score_name_rid GROUP BY name, restaurant_id;
-- Application side: order by score_sum in descending order
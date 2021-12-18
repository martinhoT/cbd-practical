USE restaurants;

-- NOTE: some of these queries can't be done solely with Cassandra, so an annotation with 'Application side' is used
-- in case the query has been done in the 'loader_n_queries' Java program.

-- 1. List all restaurants
SELECT JSON * FROM restaurant_by_locality;

-- 2. Return restaurant_id, name, locality and gastronomy for all restaurants
SELECT JSON restaurant_id, name, locality, gastronomy FROM restaurant_by_locality;

-- 3. Return restaurant_id, name, locality, gastronomy and zipcode for all restaurants
SELECT JSON restaurant_id, name, locality, gastronomy, zipcode FROM restaurant_by_locality;

-- 4. Total number of restaurants in locality 'Bronx'
SELECT JSON count(*) FROM restaurant_by_locality WHERE locality='Bronx';

-- 5. First 15 restaurants in locality 'Bronx', ordered in ascending order by name
SELECT JSON * FROM restaurant_by_locality WHERE locality='Bronx' LIMIT 15;

-- 7. Find the restaurants that got one or more scores in the interval [80, 100]
SELECT JSON name, restaurant_id FROM restaurant_by_score_class WHERE score_class=8; -- [80, 90[
SELECT JSON name, restaurant_id FROM restaurant_by_score_class WHERE score_class=9; -- [90, 100[
SELECT JSON name, restaurant_id FROM restaurant_by_score_class WHERE score_class=10 and score=100; --[100, 110[
-- Application side: merge

-- 8. Return the restaurants with latitude lower than -95.7
SELECT JSON * FROM restaurant_by_latitude_class WHERE latitude_class=-12; -- [-180,-165[
SELECT JSON * FROM restaurant_by_latitude_class WHERE latitude_class=-11; -- [-165,-150[
SELECT JSON * FROM restaurant_by_latitude_class WHERE latitude_class=-10; -- [-150,-135[
SELECT JSON * FROM restaurant_by_latitude_class WHERE latitude_class=-9; -- [-135,-120[
SELECT JSON * FROM restaurant_by_latitude_class WHERE latitude_class=-8; -- [-120,-105[
SELECT JSON * FROM restaurant_by_latitude_class WHERE latitude_class=-7 and latitude < -95.7; -- [-105, -90[
-- Application side: merge

-- 12. List the restaurant_id, name, locality and gastronomy of all restaurants localized in 'Staten Island', 'Queens' or 'Brooklyn'
SELECT JSON restaurant_id, name, locality, gastronomy FROM restaurant_by_locality WHERE locality IN ('Staten Island', 'Queens', 'Brooklyn');

-- 14. List the name and the grades of the restaurants that obtained a rating with an 'A' grade, a score of 10 on the date '2014-08-11T00: 00: 00Z' (ISODATE)
SELECT JSON name, grade FROM restaurant_grades WHERE grade='A' and date='2014-08-11 00:00:00' and score=10;
-- Application side: obtain all grades from obtained restaurants (with restaurant_grades_by_rid)

-- 15. List the restaurant_id, name and score of the restaurants in which the second rating was grade 'A' and occurred in ISODATE '2014-08-11T00: 00: 00Z'
SELECT JSON restaurant_id, name, score FROM restaurant_grades WHERE grade='A' and date='2014-08-11 00:00:00';
-- Application side: evaluate the second one (with restaurant_grades_by_rid)

-- 17. List the name, gastronomy and locality of all restaurants ordered in ascending order by gastronomy and, in second, in descending order by locality
SELECT JSON name, gastronomy, locality FROM restaurant_by_locality;
-- Application side: in ascending order by gastronomy and, in second, in descending order by locality

-- 19. Count the total of restaurants in each locality
SELECT JSON locality, count(*) FROM restaurant_by_locality GROUP BY locality;

-- 27. Return the name and locality of the second, third and fourth restaurants in street 'Flatbush Avenue' with a zipcode greater than 10000, ordered by name in descending order
SELECT JSON name, street FROM restaurant_by_street_zipcode WHERE street='Flatbush Avenue' and zipcode > 10000;
-- Application side: order by name in descending order and select the second, third and fourth

-- 30. Return the name, restaurant_id, and the sum of scores of the restaurants, ordered by the sum of scores in descending order
SELECT JSON name, restaurant_id, sum(score) as score_sum FROM restaurant_by_score_rid_name GROUP BY restaurant_id;
-- Application side: order by score_sum in descending order
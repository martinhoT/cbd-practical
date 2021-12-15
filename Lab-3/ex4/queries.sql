USE steam_reviews;

-- 1. Games reviewed by user 'hyrancor', ordered by the game's title
SELECT game FROM review_by_user WHERE uname = 'hyrancor' ORDER BY game;

-- 2. Games that the user '9mau' owns ordered alphabetically by title
SELECT * FROM user_owns WHERE uname = '9mau' ORDER BY game;

-- 3. Recommended reviews of 'Beat Saber' ordered by helpfulness
SELECT * FROM review_orderby_helpful WHERE game = 'Beat Saber' and recommended = true;

-- 4. Number of not recommended reviews of 'Dark Souls III' made after 13/10/2021
SELECT count(*) FROM review_orderby_date_posted WHERE game = 'Dark Souls III' and recommended = false and date_posted > '2021-10-13';

-- 5. Most recent review of 'OPUS: Echo of Starsong'
SELECT * FROM review WHERE game = 'OPUS: Echo of Starsong' LIMIT 1;

-- 6. Return recommended reviews for 'Slay the Spire' with a helpful score greater than 1000 and lesser than 1500
SELECT * FROM review_orderby_helpful WHERE game = 'Slay the Spire' and recommended = true and helpful > 1000 and helpful < 1500;

-- 7. Number of games from the developer 'FromSoftware Inc.'
SELECT count(*) FROM game WHERE developer = 'FromSoftware Inc.' GROUP BY developer;

-- 8. Total sum of helpful and funny ratings given to each game's reviews
SELECT game, sum(helpful) as helpful, sum(funny) as funny FROM review GROUP BY game;

-- 9. Total number of poetry awards given from reviews of 'Elden Ring'
SELECT game, sum(awards['poetry']) as poetry_rating FROM review GROUP BY game;

-- 10. Games yet to be released by 'FromSoftware Inc.'
SELECT * FROM game WHERE developer = 'FromSoftware Inc.' and release_date > toDate(now());
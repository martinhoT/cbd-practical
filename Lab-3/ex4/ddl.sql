CREATE KEYSPACE IF NOT EXISTS steam_reviews WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor': 3};

USE steam_reviews;

-- Queries:
/*
review_by_user
✓ Get all the reviews of a given user
    ✓ Get the number of reviews of a given user

user_owns
✓ Get all the owned games of a given user

review
✓ Get all reviews of a game sorted by helpfulness in descending order
✓ Get all reviews of a game sorted by date posted in descending order

review_orderby_helpful
✓ Get all recommended reviews of a game sorted by helpfulness in descending order
✓ Get all not recommended reviews of a game sorted by helpfulness in descending order

review_orderby_date_posted
✓ Get all recommended reviews of a game sorted by date posted in descending order
✓ Get all not recommended reviews of a game sorted by date posted in descending order

set: game awards
list: user alias
map: review awards and their overall count
*/

-- Allows filtering by 'developer'
DROP TABLE IF EXISTS game;
CREATE TABLE game (
    title           text,
    release_date    date,
    developer       text,
    awards          set<text>,

    PRIMARY KEY (developer, release_date, title)
) WITH CLUSTERING ORDER BY (release_date DESC);

-- Allow search by 'uname'
DROP TABLE IF EXISTS user;
CREATE TABLE user (
    uname           text,
    alias           list<text>,

    PRIMARY KEY (uname)
);

-- Allow obtaining the games given a user
DROP TABLE IF EXISTS user_owns;
CREATE TABLE user_owns (
    uname           text,
    game            text,

    PRIMARY KEY (uname, game)
);

-- Generic holder of data
DROP TABLE IF EXISTS review;
CREATE TABLE review (
    uname           text,
    game            text,
    content         text,
    recommended     boolean,
    helpful         int,
    funny           int,
    date_posted     date,
    awards          map<text, int>,

    PRIMARY KEY (game, date_posted, uname)
) WITH CLUSTERING ORDER BY (date_posted DESC);

-- Filter on 'uname'
DROP TABLE IF EXISTS review_by_user;
CREATE TABLE review_by_user (
    uname           text,
    game            text,

    PRIMARY KEY (uname, game)
);

-- Ordered by 'helpful' DESC
-- Filter on 'recommended'
DROP TABLE IF EXISTS review_orderby_helpful;
CREATE TABLE review_orderby_helpful (
    uname           text,
    game            text,
    recommended     boolean,
    helpful         int,

    PRIMARY KEY ((game, recommended), helpful, uname)
) WITH CLUSTERING ORDER BY (helpful DESC);


-- Ordered by 'date_posted' DESC
-- Filter on 'recommended'
DROP TABLE IF EXISTS review_orderby_date_posted;
CREATE TABLE review_orderby_date_posted (
    uname           text,
    game            text,
    recommended     boolean,
    date_posted     date,

    PRIMARY KEY ((game, recommended), date_posted, uname)
) WITH CLUSTERING ORDER BY (date_posted DESC);
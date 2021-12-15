USE steam_reviews;

-- game
INSERT INTO game (title, release_date, developer, awards) VALUES ('Dead by Daylight', '2016-06-14', 'Behaviour Interactive Inc.', {'Fan''s Choice - Best Canadian-made Game 2016'});
INSERT INTO game (title, release_date, developer, awards) VALUES ('Monster Hunger: World', '2018-08-09', 'CAPCOM Co., Ltd.', {});
INSERT INTO game (title, release_date, developer, awards) VALUES ('Rocket League', '2015-06-07', 'Psyonix LLC', {'Most Fun With A Machine Award - Steam 2018'});
INSERT INTO game (title, release_date, developer, awards) VALUES ('Grand Theft Auto V', '2015-04-14', 'Rockstar North', {'Labor Of Love Award - Steam 2018', 'Labor Of Love Award - Steam 2018'});
INSERT INTO game (title, release_date, developer, awards) VALUES ('Slay the Spire', '2019-01-23', 'Mega Crit Games', {});
INSERT INTO game (title, release_date, developer, awards) VALUES ('OPUS: Echo of Starsong', '2021-09-01', 'SIGONO INC.', {'Best Video Games of 2021 So Far - Kotaku 2021', 'RPG Fan Editor''s Choice', 'Indie Live Expo Winter 2021 Showcase', 'Asia Games Awards Excellence In Narrative Finallist - Gamescom', 'Asia Games Awards Winner For Excellence In Design - Gamescom'});
INSERT INTO game (title, release_date, developer, awards) VALUES ('Beat Saber', '2019-05-21', 'Beat Games', {'VR Game Of The Year - Steam 2019'});
INSERT INTO game (title, release_date, developer, awards) VALUES ('Stardew Valley', '2016-02-26', 'ConcernedApe', {'The World Is Grim Enough Let''s Just All Get Along Winner - Steam 2017'});
INSERT INTO game (title, release_date, developer, awards) VALUES ('GUILTY GEAR -STRIVE-', '2021-06-11', 'Arc System Works', {'The Game Awards 2021 Nominee'});
INSERT INTO game (title, release_date, developer, awards) VALUES ('Elden Ring', '2022-02-24', 'FromSoftware Inc.', {'Most Wanted Game - Golden Joystick Awards 39th', 'Best of gamescom - Gamescom 2021'});
INSERT INTO game (title, release_date, developer, awards) VALUES ('DARK SOULS III', '2016-04-11', 'FromSoftware Inc.', {'Best of 2016 Winner - IGN', 'Ultimate Game Of The Year - Golden Joystick Awards 34th', 'Best RPG - Gamescom'});
INSERT INTO game (title, release_date, developer, awards) VALUES ('Hollow Knight', '2017-02-24', 'Team Cherry', {'The PCGamer Platformer Award', 'Editor''s Choice Award - Destructoid'});

-- user
INSERT INTO user (uname, alias) VALUES ('hyrancor', ['hyranco']);
INSERT INTO user (uname, alias) VALUES ('chmanden', []);
INSERT INTO user (uname, alias) VALUES ('MervERYm', ['merverym']);
INSERT INTO user (uname, alias) VALUES ('Dusticke', []);
INSERT INTO user (uname, alias) VALUES ('thalig', []);
INSERT INTO user (uname, alias) VALUES ('enernm', []);
INSERT INTO user (uname, alias) VALUES ('d52a', ['rightnechr']);
INSERT INTO user (uname, alias) VALUES ('9mau', []);
INSERT INTO user (uname, alias) VALUES ('agarayar', ['agar', 'ogor']);
INSERT INTO user (uname, alias) VALUES ('RIBlEThe', []);
INSERT INTO user (uname, alias) VALUES ('anTImYro', []);
INSERT INTO user (uname, alias) VALUES ('ANTROSPe', ['antros', 'antro', 'anthro']);

-- user_owns
-- users: hyrancor,chmanden,MervERYm,Dusticke,thalig,enernm,d52a,9mau,agarayar,RIBlEThe,anTImYro,ANTROSPe
-- games: Dead by Daylight, Monster Hunger: World, Rocket League, Grand Theft Auto V, Slay the Spire, OPUS: Echo of Starsong,Beat Saber, Stardew Valley, GUILTY GEAR -STRIVE-, Elden Ring, DARK SOULS III, Hollow Knight
insert into  user_owns (uname, game) values ('agarayar', 'Beat Saber');
insert into user_owns (uname, game) values ('9mau', 'Rocket League');
insert into user_owns (uname, game) values ('RIBlEThe', 'Beat Saber');
insert into user_owns (uname, game) values ('9mau', 'GUILTY GEAR -STRIVE-');
insert into user_owns (uname, game) values ('9mau', 'GUILTY GEAR -STRIVE-');
insert into user_owns (uname, game) values ('ANTROSPe', 'OPUS: Echo of Starsong');
insert into user_owns (uname, game) values ('9mau', 'OPUS: Echo of Starsong');
insert into user_owns (uname, game) values ('RIBlEThe', 'Elden Ring');
insert into user_owns (uname, game) values ('hyrancor', 'Grand Theft Auto V');
insert into user_owns (uname, game) values ('hyrancor', 'Elden Ring');
insert into user_owns (uname, game) values ('ANTROSPe', 'Rocket League');
insert into user_owns (uname, game) values ('anTImYro', 'Dead by Daylight');
insert into user_owns (uname, game) values ('enernm', 'OPUS: Echo of Starsong');
insert into user_owns (uname, game) values ('chmanden', 'OPUS: Echo of Starsong');
insert into user_owns (uname, game) values ('anTImYro', 'Stardew Valley');
insert into user_owns (uname, game) values ('hyrancor', 'Grand Theft Auto V');
insert into user_owns (uname, game) values ('9mau', 'Grand Theft Auto V');
insert into user_owns (uname, game) values ('thalig', 'Dead by Daylight');
insert into user_owns (uname, game) values ('9mau', 'GUILTY GEAR -STRIVE-');
insert into user_owns (uname, game) values ('thalig', 'Rocket League');
insert into user_owns (uname, game) values ('d52a', 'Elden Ring');
insert into user_owns (uname, game) values ('RIBlEThe', 'Dead by Daylight');
insert into user_owns (uname, game) values ('d52a', 'DARK SOULS III');
insert into user_owns (uname, game) values ('thalig', 'Rocket League');
insert into user_owns (uname, game) values ('MervERYm', 'Grand Theft Auto V');
insert into user_owns (uname, game) values ('9mau', 'Monster Hunger: World');
insert into user_owns (uname, game) values ('RIBlEThe', 'DARK SOULS III');
insert into user_owns (uname, game) values ('9mau', 'DARK SOULS III');
insert into user_owns (uname, game) values ('enernm', 'OPUS: Echo of Starsong');
insert into user_owns (uname, game) values ('anTImYro', 'Dead by Daylight');

-- review
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('hyrancor', 'OPUS: Echo of Starsong', '印', true, 1106, 1821, '2021-09-01', {'treasure':19,'mind_blown':91,'golden_unicorn':23,'deep_thoughts':54,'heartwarming':30,'hilarious':63,'poetry':24});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('agarayar', 'DARK SOULS III', '方', false, 773, 1152, '2021-10-12', {'treasure':74,'mind_blown':54,'golden_unicorn':27,'deep_thoughts':72,'heartwarming':68,'hilarious':31,'poetry':54});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('anTImYro', 'Dead by Daylight', '慕', true, 813, 757, '2021-10-25', {'treasure':0,'mind_blown':46,'golden_unicorn':76,'deep_thoughts':8,'heartwarming':81,'hilarious':93,'poetry':50});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('chmanden', 'Slay the Spire', '单', false, 135, 205, '2021-10-23', {'treasure':4,'mind_blown':64,'golden_unicorn':57,'deep_thoughts':81,'heartwarming':88,'hilarious':98,'poetry':85});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('agarayar', 'Elden Ring', '尚', true, 1978, 810, '2021-12-27', {'treasure':40,'mind_blown':19,'golden_unicorn':39,'deep_thoughts':39,'heartwarming':60,'hilarious':82,'poetry':18});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('hyrancor', 'DARK SOULS III', '咸', true, 1914, 633, '2021-11-29', {'treasure':66,'mind_blown':65,'golden_unicorn':41,'deep_thoughts':74,'heartwarming':72,'hilarious':39,'poetry':65});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('enernm', 'Grand Theft Auto V', '怀', true, 1998, 1617, '2021-11-13', {'treasure':87,'mind_blown':29,'golden_unicorn':55,'deep_thoughts':39,'heartwarming':99,'hilarious':11,'poetry':71});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('thalig', 'OPUS: Echo of Starsong', '祁', true, 1858, 1628, '2021-10-03', {'treasure':83,'mind_blown':10,'golden_unicorn':32,'deep_thoughts':20,'heartwarming':57,'hilarious':29,'poetry':81});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('MervERYm', 'Grand Theft Auto V', '乜', true, 544, 1260, '2021-09-22', {'treasure':19,'mind_blown':28,'golden_unicorn':28,'deep_thoughts':3,'heartwarming':74,'hilarious':92,'poetry':15});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('anTImYro', 'Hollow Knight', '满', true, 738, 1160, '2021-09-19', {'treasure':34,'mind_blown':95,'golden_unicorn':91,'deep_thoughts':63,'heartwarming':10,'hilarious':32,'poetry':88});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('enernm', 'Stardew Valley', '能', false, 1624, 432, '2021-08-18', {'treasure':57,'mind_blown':14,'golden_unicorn':100,'deep_thoughts':30,'heartwarming':46,'hilarious':55,'poetry':62});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('anTImYro', 'Beat Saber', '鞠', true, 1160, 519, '2021-10-04', {'treasure':99,'mind_blown':71,'golden_unicorn':64,'deep_thoughts':57,'heartwarming':46,'hilarious':76,'poetry':90});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('anTImYro', 'Monster Hunger: World', '东', true, 6, 288, '2021-08-06', {'treasure':100,'mind_blown':47,'golden_unicorn':96,'deep_thoughts':35,'heartwarming':33,'hilarious':33,'poetry':53});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('MervERYm', 'Elden Ring', '谷', false, 1880, 130, '2021-12-06', {'treasure':91,'mind_blown':95,'golden_unicorn':19,'deep_thoughts':76,'heartwarming':22,'hilarious':73,'poetry':2});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('MervERYm', 'Beat Saber', '那', false, 1747, 1798, '2021-12-19', {'treasure':93,'mind_blown':24,'golden_unicorn':91,'deep_thoughts':20,'heartwarming':77,'hilarious':18,'poetry':47});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('thalig', 'Slay the Spire', '昌', true, 1457, 182, '2021-12-24', {'treasure':98,'mind_blown':40,'golden_unicorn':47,'deep_thoughts':57,'heartwarming':77,'hilarious':100,'poetry':44});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('anTImYro', 'Rocket League', '贲', true, 704, 1645, '2021-12-13', {'treasure':100,'mind_blown':13,'golden_unicorn':79,'deep_thoughts':22,'heartwarming':64,'hilarious':84,'poetry':84});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('RIBlEThe', 'Monster Hunger: World', '庾', true, 212, 1199, '2021-08-31', {'treasure':28,'mind_blown':58,'golden_unicorn':29,'deep_thoughts':35,'heartwarming':76,'hilarious':66,'poetry':74});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('ANTROSPe', 'DARK SOULS III', '田', false, 543, 1033, '2021-11-18', {'treasure':26,'mind_blown':50,'golden_unicorn':28,'deep_thoughts':49,'heartwarming':0,'hilarious':32,'poetry':18});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('thalig', 'Beat Saber', '卞', true, 123, 1984, '2021-08-31', {'treasure':47,'mind_blown':81,'golden_unicorn':17,'deep_thoughts':43,'heartwarming':19,'hilarious':63,'poetry':73});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('MervERYm', 'Elden Ring', '倪', true, 168, 1474, '2021-10-29', {'treasure':41,'mind_blown':95,'golden_unicorn':43,'deep_thoughts':15,'heartwarming':93,'hilarious':1,'poetry':66});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('Dusticke', 'OPUS: Echo of Starsong', '禄', true, 774, 1920, '2021-11-20', {'treasure':36,'mind_blown':84,'golden_unicorn':5,'deep_thoughts':16,'heartwarming':76,'hilarious':96,'poetry':55});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('agarayar', 'Slay the Spire', '蒲', true, 452, 1313, '2021-09-05', {'treasure':12,'mind_blown':72,'golden_unicorn':84,'deep_thoughts':3,'heartwarming':25,'hilarious':13,'poetry':22});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('agarayar', 'GUILTY GEAR -STRIVE-', '邰', false, 73, 1722, '2021-10-09', {'treasure':61,'mind_blown':76,'golden_unicorn':13,'deep_thoughts':6,'heartwarming':56,'hilarious':100,'poetry':69});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('anTImYro', 'Elden Ring', '尹', false, 5, 354, '2021-12-21', {'treasure':37,'mind_blown':11,'golden_unicorn':63,'deep_thoughts':78,'heartwarming':89,'hilarious':16,'poetry':19});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('hyrancor', 'Beat Saber', '水', false, 592, 1350, '2021-11-02', {'treasure':75,'mind_blown':20,'golden_unicorn':56,'deep_thoughts':29,'heartwarming':70,'hilarious':25,'poetry':49});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('thalig', 'Slay the Spire', '仰', true, 1973, 1793, '2021-09-20', {'treasure':25,'mind_blown':76,'golden_unicorn':95,'deep_thoughts':78,'heartwarming':89,'hilarious':5,'poetry':9});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('RIBlEThe', 'Beat Saber', '吕', true, 515, 1629, '2021-08-26', {'treasure':66,'mind_blown':84,'golden_unicorn':1,'deep_thoughts':9,'heartwarming':0,'hilarious':14,'poetry':42});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('enernm', 'Slay the Spire', '禄', false, 156, 1985, '2021-08-04', {'treasure':9,'mind_blown':38,'golden_unicorn':45,'deep_thoughts':86,'heartwarming':98,'hilarious':91,'poetry':46});
insert into review (uname, game, content, recommended, helpful, funny, date_posted, awards) values ('Dusticke', 'Monster Hunger: World', '包', true, 1855, 1159, '2021-12-14', {'treasure':81,'mind_blown':25,'golden_unicorn':32,'deep_thoughts':72,'heartwarming':34,'hilarious':52,'poetry':41});

-- review_by_user
insert into review_by_user (uname, game) values ('hyrancor', 'OPUS: Echo of Starsong');
insert into review_by_user (uname, game) values ('agarayar', 'DARK SOULS III');
insert into review_by_user (uname, game) values ('anTImYro', 'Dead by Daylight');
insert into review_by_user (uname, game) values ('chmanden', 'Slay the Spire');
insert into review_by_user (uname, game) values ('agarayar', 'Elden Ring');
insert into review_by_user (uname, game) values ('hyrancor', 'DARK SOULS III');
insert into review_by_user (uname, game) values ('enernm', 'Grand Theft Auto V');
insert into review_by_user (uname, game) values ('thalig', 'OPUS: Echo of Starsong');
insert into review_by_user (uname, game) values ('MervERYm', 'Grand Theft Auto V');
insert into review_by_user (uname, game) values ('anTImYro', 'Hollow Knight');
insert into review_by_user (uname, game) values ('enernm', 'Stardew Valley');
insert into review_by_user (uname, game) values ('anTImYro', 'Beat Saber');
insert into review_by_user (uname, game) values ('anTImYro', 'Monster Hunger: World');
insert into review_by_user (uname, game) values ('MervERYm', 'Elden Ring');
insert into review_by_user (uname, game) values ('MervERYm', 'Beat Saber');
insert into review_by_user (uname, game) values ('thalig', 'Slay the Spire');
insert into review_by_user (uname, game) values ('anTImYro', 'Rocket League');
insert into review_by_user (uname, game) values ('RIBlEThe', 'Monster Hunger: World');
insert into review_by_user (uname, game) values ('ANTROSPe', 'DARK SOULS III');
insert into review_by_user (uname, game) values ('thalig', 'Beat Saber');
insert into review_by_user (uname, game) values ('MervERYm', 'Elden Ring');
insert into review_by_user (uname, game) values ('Dusticke', 'OPUS: Echo of Starsong');
insert into review_by_user (uname, game) values ('agarayar', 'Slay the Spire');
insert into review_by_user (uname, game) values ('agarayar', 'GUILTY GEAR -STRIVE-');
insert into review_by_user (uname, game) values ('anTImYro', 'Elden Ring');
insert into review_by_user (uname, game) values ('hyrancor', 'Beat Saber');
insert into review_by_user (uname, game) values ('thalig', 'Slay the Spire');
insert into review_by_user (uname, game) values ('RIBlEThe', 'Beat Saber');
insert into review_by_user (uname, game) values ('enernm', 'Slay the Spire');
insert into review_by_user (uname, game) values ('Dusticke', 'Monster Hunger: World');

-- review_orderby_helpful
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('hyrancor', 'OPUS: Echo of Starsong', true, 1106);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('agarayar', 'DARK SOULS III', false, 773);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('anTImYro', 'Dead by Daylight', true, 813);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('chmanden', 'Slay the Spire', false, 135);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('agarayar', 'Elden Ring', true, 1978);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('hyrancor', 'DARK SOULS III', true, 1914);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('enernm', 'Grand Theft Auto V', true, 1998);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('thalig', 'OPUS: Echo of Starsong', true, 1858);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('MervERYm', 'Grand Theft Auto V', true, 544);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('anTImYro', 'Hollow Knight', true, 738);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('enernm', 'Stardew Valley', false, 1624);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('anTImYro', 'Beat Saber', true, 1160);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('anTImYro', 'Monster Hunger: World', true, 6);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('MervERYm', 'Elden Ring', false, 1880);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('MervERYm', 'Beat Saber', false, 1747);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('thalig', 'Slay the Spire', true, 1457);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('anTImYro', 'Rocket League', true, 704);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('RIBlEThe', 'Monster Hunger: World', true, 212);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('ANTROSPe', 'DARK SOULS III', false, 543);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('thalig', 'Beat Saber', true, 123);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('MervERYm', 'Elden Ring', true, 168);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('Dusticke', 'OPUS: Echo of Starsong', true, 774);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('agarayar', 'Slay the Spire', true, 452);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('agarayar', 'GUILTY GEAR -STRIVE-', false, 73);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('anTImYro', 'Elden Ring', false, 5);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('hyrancor', 'Beat Saber', false, 592);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('thalig', 'Slay the Spire', true, 1973);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('RIBlEThe', 'Beat Saber', true, 515);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('enernm', 'Slay the Spire', false, 156);
insert into review_orderby_helpful (uname, game, recommended, helpful) values ('Dusticke', 'Monster Hunger: World', true, 1855);

-- review_orderby_date_posted
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('hyrancor', 'OPUS: Echo of Starsong', true, '2021-09-01');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('agarayar', 'DARK SOULS III', false, '2021-10-12');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('anTImYro', 'Dead by Daylight', true, '2021-10-25');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('chmanden', 'Slay the Spire', false, '2021-10-23');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('agarayar', 'Elden Ring', true, '2021-12-27');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('hyrancor', 'DARK SOULS III', true, '2021-11-29');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('enernm', 'Grand Theft Auto V', true, '2021-11-13');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('thalig', 'OPUS: Echo of Starsong', true, '2021-10-03');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('MervERYm', 'Grand Theft Auto V', true, '2021-09-22');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('anTImYro', 'Hollow Knight', true, '2021-09-19');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('enernm', 'Stardew Valley', false, '2021-08-18');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('anTImYro', 'Beat Saber', true, '2021-10-04');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('anTImYro', 'Monster Hunger: World', true, '2021-08-06');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('MervERYm', 'Elden Ring', false, '2021-12-06');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('MervERYm', 'Beat Saber', false, '2021-12-19');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('thalig', 'Slay the Spire', true, '2021-12-24');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('anTImYro', 'Rocket League', true, '2021-12-13');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('RIBlEThe', 'Monster Hunger: World', true, '2021-08-31');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('ANTROSPe', 'DARK SOULS III', false, '2021-11-18');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('thalig', 'Beat Saber', true, '2021-08-31');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('MervERYm', 'Elden Ring', true, '2021-10-29');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('Dusticke', 'OPUS: Echo of Starsong', true, '2021-11-20');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('agarayar', 'Slay the Spire', true, '2021-09-05');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('agarayar', 'GUILTY GEAR -STRIVE-', false, '2021-10-09');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('anTImYro', 'Elden Ring', false, '2021-12-21');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('hyrancor', 'Beat Saber', false, '2021-11-02');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('thalig', 'Slay the Spire', true, '2021-09-20');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('RIBlEThe', 'Beat Saber', true, '2021-08-26');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('enernm', 'Slay the Spire', false, '2021-08-04');
insert into review_orderby_date_posted (uname, game, recommended, date_posted) values ('Dusticke', 'Monster Hunger: World', true, '2021-12-14');

-- Secondary indexes
CREATE INDEX game_awards ON game (awards);
SELECT * FROM game WHERE awards CONTAINS 'The Game Awards 2021 Nominee';
CREATE INDEX review_award_type ON review (ENTRIES(awards));
SELECT * FROM review WHERE awards['hilarious'] = 32;

-- Update data
UPDATE user SET alias = alias + ['chmad'] WHERE uname = 'chmanden';
UPDATE game SET awards = awards + {'The Game Awards Most Anticipated Game 2020 & 2021'} WHERE title = 'Elden Ring';
UPDATE user SET alias = [] WHERE uname = 'hyrancor';
UPDATE user SET alias = alias - ['anthro'] WHERE uname = 'ANTROSPe';
UPDATE review SET awards = awards + {'helpful': 1} WHERE game = 'OPUS: Echo of Starsong' and date_posted = '2021-09-01' and uname = 'hyrancor';

-- Delete data
DELETE alias[0] FROM user WHERE uname = 'ANTROSPe';
DELETE awards['heartwarming'] FROM review WHERE game = 'Beat Saber' and date_posted = '2021-08-26' and uname = 'RIBlEThe';
DELETE alias FROM user WHERE uname = 'd52a';
DELETE developer, release_date FROM game WHERE title = 'Rocket League';
DELETE awards FROM game WHERE title = 'Monster Hunter: World';
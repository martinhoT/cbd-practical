USE videos_db;

// DML
INSERT INTO user (username, name, email, register_time) VALUES ('man', 'Manuel', 'manuel@gmail.com', 75192581982);
INSERT INTO user (username, name, email, register_time) VALUES ('__gis', 'Giselle', 'giselle@hotmail.com', 2858197421);
INSERT INTO user (username, name, email, register_time) VALUES ('xX_alpha_Xx', 'John', 'beta@hotmail.com', 5701746184217);
INSERT INTO user (username, name, email, register_time) VALUES ('archangel', 'Michel', 'michel@gmail.com', 5017521895719);
INSERT INTO user (username, name, email, register_time) VALUES ('m1sta', 'Mista', 'hatefour@gmail.com', 2758196521981);
INSERT INTO user (username, name, email, register_time) VALUES ('mike', 'Mike', 'mike@hotmail.com', 2651562125);
INSERT INTO user (username, name, email, register_time) VALUES ('creative_bankruptcy_artifact', 'John', 'alpha@hotmail.com', 11111111111);
INSERT INTO user (username, name, email, register_time) VALUES ('giovanna', 'Giorgio', 'gexperience@gmail.com', 65215128752198);
INSERT INTO user (username, name, email, register_time) VALUES ('aceAttorney', 'Phoenix', 'always.wright@gmail.com', 151759012803);
INSERT INTO user (username, name, email, register_time) VALUES ('rivalAttorney', 'Miles', 'edgeworth@gmail.com', 2751856212267);
INSERT INTO user (username, name, email, register_time) VALUES ('kurigohan_kamehameha', 'Christina', 'kuris@hotmail.com', 6591258197591);

INSERT INTO video_by_author (author, name, description, tags, upload_time) VALUES ('man', 'Me at the zoo', 'Why remove dislikes??', {'Educational', 'Zoo'}, 51789571393729);
insert into video_by_author (author, name, description, tags, upload_time) values ('xX_alpha_Xx', 'Assimilated multi-tasking moratorium', 'productize proactive ROI', {'Action'}, '1562745766');
insert into video_by_author (author, name, description, tags, upload_time) values ('man', 'Customer-focused homogeneous forecast', 'strategize cutting-edge e-markets', {'Homogeneous', 'Forecast', 'Customer'}, '1582876419');
insert into video_by_author (author, name, description, tags, upload_time) values ('xX_alpha_Xx', 'Visionary attitude-oriented hierarchy', 'deploy synergistic relationships', {'Futurology'}, '1553537440');
insert into video_by_author (author, name, description, tags, upload_time) values ('__gis', 'Configurable grid-enabled framework', 'seize revolutionary infomediaries', {'Educational', 'Technology'}, '1522692340');
insert into video_by_author (author, name, description, tags, upload_time) values ('creative_bankruptcy_artifact', 'Grass-roots full-range challenge', 'whiteboard extensible platforms', {'Challenge', 'Aveiro'}, '1567105449');
insert into video_by_author (author, name, description, tags, upload_time) values ('man', 'Customer-focused bandwidth-monitored protocol', 'integrate killer niches', {'Protocol', 'Customer', 'Network'}, '1564837031');
insert into video_by_author (author, name, description, tags, upload_time) values ('xX_alpha_Xx', 'Cross-group high-level capability', 'evolve B2B relationships', {'Relationship'}, '1629898212');
insert into video_by_author (author, name, description, tags, upload_time) values ('rivalAttorney', 'Front-line transitional Graphic Interface', 'innovate holistic supply-chains', {'Graphical interface', 'Supply-chain'}, '1624178698');
insert into video_by_author (author, name, description, tags, upload_time) values ('xX_alpha_Xx', 'Switchable upward-trending website', 'repurpose viral users', {'Website'}, '1523224022');
insert into video_by_author (author, name, description, tags, upload_time) values ('man', 'Reactive disintermediate migration', 'enable world-class e-markets', {'Market', 'Economy'}, '1632357317');
insert into video_by_author (author, name, description, tags, upload_time) values ('xX_alpha_Xx', 'Multi-lateral fault-tolerant collaboration', 'repurpose dynamic partnerships', {'Partnership'}, '1619384885');

insert into comment_by_video (user, video, content, time) values ('m1sta', 'Cross-group high-level capability', 'Sibaropsis hammittii S. Boyd & T.S. Ross', '1563238451');
insert into comment_by_video (user, video, content, time) values ('archangel', 'Assimilated multi-tasking moratorium', 'Potentilla rubella T.J. Sørensen', '1496959746');
insert into comment_by_video (user, video, content, time) values ('m1sta', 'Switchable upward-trending website', 'Penstemon procerus Douglas ex Graham var. formosus (A. Nelson) Cronquist', '1522011903');
insert into comment_by_video (user, video, content, time) values ('kurigohan_kamehameha', 'Assimilated multi-tasking moratorium', 'Pleuroziopsis Kindb. ex E. Britton', '1559196356');
insert into comment_by_video (user, video, content, time) values ('kurigohan_kamehameha', 'Visionary attitude-oriented hierarchy', 'Calochortus gunnisonii S. Watson var. gunnisonii', '1501258027');
insert into comment_by_video (user, video, content, time) values ('__gis', 'Cross-group high-level capability', 'Dimorphocarpa Rollins', '1528823775');
insert into comment_by_video (user, video, content, time) values ('xX_alpha_Xx', 'Configurable grid-enabled framework', 'Collema leptaleum Tuck.', '1541904064');
insert into comment_by_video (user, video, content, time) values ('giovanna', 'Cross-group high-level capability', 'Selaginella pilifera A. Braun', '1612958616');
insert into comment_by_video (user, video, content, time) values ('m1sta', 'Switchable upward-trending website', 'Physaria vitulifera Rydb.', '1625823983');
insert into comment_by_video (user, video, content, time) values ('mike', 'Front-line transitional Graphic Interface', 'Gaylussacia baccata (Wangenh.) K. Koch', '1568689198');
insert into comment_by_video (user, video, content, time) values ('mike', 'Visionary attitude-oriented hierarchy', 'Sicyos angulatus L.', '1616799676');
insert into comment_by_video (user, video, content, time) values ('man', 'Visionary attitude-oriented hierarchy', 'Oenothera heterophylla Spach', '1541503464');
insert into comment_by_video (user, video, content, time) values ('giovanna', 'Visionary attitude-oriented hierarchy', 'Triosteum aurantiacum E.P. Bicknell', '1511573584');
insert into comment_by_video (user, video, content, time) values ('mike', 'Front-line transitional Graphic Interface', 'Penstemon leonardii Rydb. var. patricus (N.H. Holmgren) Neese', '1618946348');
insert into comment_by_video (user, video, content, time) values ('__gis', 'Customer-focused bandwidth-monitored protocol', 'Mauritia flexuosa L. f.', '1622111550');
insert into comment_by_video (user, video, content, time) values ('m1sta', 'Configurable grid-enabled framework', 'Castilleja scabrida Eastw. var. scabrida', '1509263311');
insert into comment_by_video (user, video, content, time) values ('__gis', 'Front-line transitional Graphic Interface', 'Pinus banksiana Lamb.', '1619624027');
insert into comment_by_video (user, video, content, time) values ('__gis', 'Switchable upward-trending website', 'Calystegia malacophylla (Greene) Munz', '1601339317');
insert into comment_by_video (user, video, content, time) values ('creative_bankruptcy_artifact', 'Grass-roots full-range challenge', 'Pinckneya Michx.', '1518321927');
insert into comment_by_video (user, video, content, time) values ('giovanna', 'Grass-roots full-range challenge', 'Piptatherum P. Beauv.', '1522974829');
insert into comment_by_video (user, video, content, time) values ('aceAttorney', 'Assimilated multi-tasking moratorium', 'Tortula laevipila (Brid.) Schwägr.', '1526348052');
insert into comment_by_video (user, video, content, time) values ('creative_bankruptcy_artifact', 'Visionary attitude-oriented hierarchy', 'Verbascum L.', '1526830144');
insert into comment_by_video (user, video, content, time) values ('archangel', 'Cross-group high-level capability', 'Amblystegium serpens (Hedw.) Schimp. var. juratzkanum (Schimp.) Rau & Herv.', '1593866820');
insert into comment_by_video (user, video, content, time) values ('rivalAttorney', 'Reactive disintermediate migration', 'Clermontia peleana Rock', '1520579640');
insert into comment_by_video (user, video, content, time) values ('man', 'Customer-focused homogeneous forecast', 'Strangospora moriformis (Ach.) Stein', '1519351069');
insert into comment_by_video (user, video, content, time) values ('archangel', 'Customer-focused homogeneous forecast', 'Phyllanthus acidus (L.) Skeels', '1632786178');
insert into comment_by_video (user, video, content, time) values ('xX_alpha_Xx', 'Switchable upward-trending website', 'Pyrrocoma hirta (A. Gray) Greene var. lanulosa (Greene) Mayes ex G. Brown & Keil', '1622606621');
insert into comment_by_video (user, video, content, time) values ('aceAttorney', 'Switchable upward-trending website', 'Hulsea algida A. Gray', '1514159407');
insert into comment_by_video (user, video, content, time) values ('m1sta', 'Front-line transitional Graphic Interface', 'Elettaria cardamomum (L.) Maton', '1576356032');
insert into comment_by_video (user, video, content, time) values ('rivalAttorney', 'Cross-group high-level capability', 'Tribulus cistoides L.', '1639018110');

insert into comment_by_user (user, video, content, time) values ('mike', 'Switchable upward-trending website', 'Securigera cretica (L.) Lassen', '1534240000');
insert into comment_by_user (user, video, content, time) values ('mike', 'Grass-roots full-range challenge', 'Psychotria uliginosa Sw.', '1545684684');
insert into comment_by_user (user, video, content, time) values ('xX_alpha_Xx', 'Grass-roots full-range challenge', 'Juniperus phoenicea L.', '1588311704');
insert into comment_by_user (user, video, content, time) values ('man', 'Switchable upward-trending website', 'Sium L.', '1530826804');
insert into comment_by_user (user, video, content, time) values ('rivalAttorney', 'Assimilated multi-tasking moratorium', 'Pinus halepensis Mill.', '1618717863');
insert into comment_by_user (user, video, content, time) values ('mike', 'Me at the zoo', 'Sansevieria trifasciata hort. ex Prain', '1600085898');
insert into comment_by_user (user, video, content, time) values ('aceAttorney', 'Assimilated multi-tasking moratorium', 'Ipomoea batatas (L.) Lam.', '1516393282');
insert into comment_by_user (user, video, content, time) values ('m1sta', 'Customer-focused homogeneous forecast', 'Xanthosoma helleborifolium (Jacq.) Schott', '1606806600');
insert into comment_by_user (user, video, content, time) values ('man', 'Reactive disintermediate migration', 'Cereus Mill.', '1522099275');
insert into comment_by_user (user, video, content, time) values ('giovanna', 'Front-line transitional Graphic Interface', 'Phacelia neomexicana Thurb. ex Torr.', '1598290822');
insert into comment_by_user (user, video, content, time) values ('kurigohan_kamehameha', 'Multi-lateral fault-tolerant collaboration', 'Lupinus arbustus Douglas ex Lindl.', '1580601095');
insert into comment_by_user (user, video, content, time) values ('man', 'Me at the zoo', 'Gonocalyx portoricensis (Urb.) A.C. Sm.', '1617125267');
insert into comment_by_user (user, video, content, time) values ('__gis', 'Front-line transitional Graphic Interface', 'Sterculia urens Roxb.', '1555196578');
insert into comment_by_user (user, video, content, time) values ('aceAttorney', 'Customer-focused bandwidth-monitored protocol', 'Phacelia floribunda Greene', '1553154264');
insert into comment_by_user (user, video, content, time) values ('aceAttorney', 'Front-line transitional Graphic Interface', 'Galium obtusum Bigelow ssp. obtusum', '1585519871');
insert into comment_by_user (user, video, content, time) values ('kurigohan_kamehameha', 'Grass-roots full-range challenge', 'Agrostis pauzhetica Prob.', '1529793725');
insert into comment_by_user (user, video, content, time) values ('__gis', 'Front-line transitional Graphic Interface', 'Erigeron salishii G.W. Douglas & Packer', '1507285804');
insert into comment_by_user (user, video, content, time) values ('aceAttorney', 'Front-line transitional Graphic Interface', 'Solidago ×erskinei B. Boivin', '1635608035');
insert into comment_by_user (user, video, content, time) values ('man', 'Grass-roots full-range challenge', 'Castilleja subinclusa Greene ssp. subinclusa', '1599805724');
insert into comment_by_user (user, video, content, time) values ('archangel', 'Customer-focused bandwidth-monitored protocol', 'Hypnum jutlandicum Holmen & Warncke', '1559783330');
insert into comment_by_user (user, video, content, time) values ('rivalAttorney', 'Grass-roots full-range challenge', 'Tithonia Desf. ex Juss.', '1578472814');
insert into comment_by_user (user, video, content, time) values ('__gis', 'Customer-focused bandwidth-monitored protocol', 'Valeriana scouleri Rydb.', '1584838163');
insert into comment_by_user (user, video, content, time) values ('kurigohan_kamehameha', 'Configurable grid-enabled framework', 'Hackelia diffusa (Lehm.) I.M. Johnst. var. diffusa', '1505401613');
insert into comment_by_user (user, video, content, time) values ('__gis', 'Me at the zoo', 'Orbexilum lupinellum (Michx.) Isely', '1524857405');
insert into comment_by_user (user, video, content, time) values ('aceAttorney', 'Configurable grid-enabled framework', 'Nicandra physalodes (L.) Scop.', '1620568739');
insert into comment_by_user (user, video, content, time) values ('mike', 'Cross-group high-level capability', 'Agrostemma L.', '1546501909');
insert into comment_by_user (user, video, content, time) values ('kurigohan_kamehameha', 'Cross-group high-level capability', 'Buellia lecanoroides H. Magn.', '1555859395');
insert into comment_by_user (user, video, content, time) values ('m1sta', 'Me at the zoo', 'Ancistrocactus scheeri (Salm-Dyck) Britton & Rose', '1604300067');
insert into comment_by_user (user, video, content, time) values ('mike', 'Customer-focused homogeneous forecast', 'Allium fimbriatum S. Watson var. mohavense (Tidestr.) Jeps.', '1541026401');
insert into comment_by_user (user, video, content, time) values ('kurigohan_kamehameha', 'Customer-focused homogeneous forecast', 'Verbena californica Moldenke', '1598295366');

insert into follower (user, video) values ('giovanna', 'Cross-group high-level capability');
insert into follower (user, video) values ('kurigohan_kamehameha', 'Multi-lateral fault-tolerant collaboration');
insert into follower (user, video) values ('mike', 'Grass-roots full-range challenge');
insert into follower (user, video) values ('aceAttorney', 'Multi-lateral fault-tolerant collaboration');
insert into follower (user, video) values ('__gis', 'Configurable grid-enabled framework');
insert into follower (user, video) values ('giovanna', 'Multi-lateral fault-tolerant collaboration');
insert into follower (user, video) values ('archangel', 'Visionary attitude-oriented hierarchy');
insert into follower (user, video) values ('giovanna', 'Reactive disintermediate migration');
insert into follower (user, video) values ('__gis', 'Front-line transitional Graphic Interface');
insert into follower (user, video) values ('archangel', 'Customer-focused homogeneous forecast');
insert into follower (user, video) values ('rivalAttorney', 'Customer-focused bandwidth-monitored protocol');
insert into follower (user, video) values ('mike', 'Reactive disintermediate migration');
insert into follower (user, video) values ('aceAttorney', 'Customer-focused homogeneous forecast');
insert into follower (user, video) values ('giovanna', 'Configurable grid-enabled framework');
insert into follower (user, video) values ('giovanna', 'Configurable grid-enabled framework');
insert into follower (user, video) values ('xX_alpha_Xx', 'Assimilated multi-tasking moratorium');
insert into follower (user, video) values ('mike', 'Grass-roots full-range challenge');
insert into follower (user, video) values ('mike', 'Switchable upward-trending website');
insert into follower (user, video) values ('archangel', 'Front-line transitional Graphic Interface');
insert into follower (user, video) values ('m1sta', 'Front-line transitional Graphic Interface');
insert into follower (user, video) values ('kurigohan_kamehameha', 'Customer-focused homogeneous forecast');
insert into follower (user, video) values ('archangel', 'Grass-roots full-range challenge');
insert into follower (user, video) values ('__gis', 'Reactive disintermediate migration');
insert into follower (user, video) values ('man', 'Configurable grid-enabled framework');
insert into follower (user, video) values ('giovanna', 'Grass-roots full-range challenge');
insert into follower (user, video) values ('mike', 'Multi-lateral fault-tolerant collaboration');
insert into follower (user, video) values ('archangel', 'Me at the zoo');
insert into follower (user, video) values ('xX_alpha_Xx', 'Assimilated multi-tasking moratorium');
insert into follower (user, video) values ('xX_alpha_Xx', 'Me at the zoo');
insert into follower (user, video) values ('archangel', 'Customer-focused bandwidth-monitored protocol');

insert into event (user, video, event, event_time, video_time) values ('aceAttorney', 'Customer-focused bandwidth-monitored protocol', 'pause', '1575943090', 2075);
insert into event (user, video, event, event_time, video_time) values ('mike', 'Assimilated multi-tasking moratorium', 'stop', '1548646932', 2898);
insert into event (user, video, event, event_time, video_time) values ('creative_bankruptcy_artifact', 'Front-line transitional Graphic Interface', 'pause', '1562272121', 3295);
insert into event (user, video, event, event_time, video_time) values ('__gis', 'Visionary attitude-oriented hierarchy', 'pause', '1590486977', 256);
insert into event (user, video, event, event_time, video_time) values ('creative_bankruptcy_artifact', 'Visionary attitude-oriented hierarchy', 'pause', '1538875808', 101);
insert into event (user, video, event, event_time, video_time) values ('archangel', 'Cross-group high-level capability', 'stop', '1530197156', 3138);
insert into event (user, video, event, event_time, video_time) values ('xX_alpha_Xx', 'Grass-roots full-range challenge', 'stop', '1539589266', 1689);
insert into event (user, video, event, event_time, video_time) values ('__gis', 'Multi-lateral fault-tolerant collaboration', 'stop', '1613948576', 3035);
insert into event (user, video, event, event_time, video_time) values ('man', 'Multi-lateral fault-tolerant collaboration', 'play', '1579427070', 61);
insert into event (user, video, event, event_time, video_time) values ('aceAttorney', 'Switchable upward-trending website', 'play', '1515339777', 1086);
insert into event (user, video, event, event_time, video_time) values ('kurigohan_kamehameha', 'Visionary attitude-oriented hierarchy', 'play', '1521588248', 3493);
insert into event (user, video, event, event_time, video_time) values ('mike', 'Grass-roots full-range challenge', 'stop', '1585385888', 309);
insert into event (user, video, event, event_time, video_time) values ('mike', 'Assimilated multi-tasking moratorium', 'pause', '1531176597', 1210);
insert into event (user, video, event, event_time, video_time) values ('xX_alpha_Xx', 'Front-line transitional Graphic Interface', 'play', '1525993614', 497);
insert into event (user, video, event, event_time, video_time) values ('xX_alpha_Xx', 'Me at the zoo', 'pause', '1538511302', 1165);
insert into event (user, video, event, event_time, video_time) values ('kurigohan_kamehameha', 'Me at the zoo', 'play', '1610694493', 2351);
insert into event (user, video, event, event_time, video_time) values ('giovanna', 'Multi-lateral fault-tolerant collaboration', 'pause', '1561996755', 3103);
insert into event (user, video, event, event_time, video_time) values ('creative_bankruptcy_artifact', 'Customer-focused bandwidth-monitored protocol', 'pause', '1554656205', 2866);
insert into event (user, video, event, event_time, video_time) values ('aceAttorney', 'Switchable upward-trending website', 'play', '1519420893', 1532);
insert into event (user, video, event, event_time, video_time) values ('archangel', 'Customer-focused homogeneous forecast', 'play', '1613901461', 518);
insert into event (user, video, event, event_time, video_time) values ('m1sta', 'Switchable upward-trending website', 'stop', '1606270593', 871);
insert into event (user, video, event, event_time, video_time) values ('creative_bankruptcy_artifact', 'Me at the zoo', 'pause', '1607141048', 773);
insert into event (user, video, event, event_time, video_time) values ('xX_alpha_Xx', 'Reactive disintermediate migration', 'pause', '1508134960', 1057);
insert into event (user, video, event, event_time, video_time) values ('creative_bankruptcy_artifact', 'Cross-group high-level capability', 'pause', '1551071135', 1196);
insert into event (user, video, event, event_time, video_time) values ('archangel', 'Configurable grid-enabled framework', 'play', '1543522436', 2548);
insert into event (user, video, event, event_time, video_time) values ('creative_bankruptcy_artifact', 'Reactive disintermediate migration', 'play', '1557395934', 1741);
insert into event (user, video, event, event_time, video_time) values ('giovanna', 'Customer-focused bandwidth-monitored protocol', 'stop', '1620873983', 2625);
insert into event (user, video, event, event_time, video_time) values ('creative_bankruptcy_artifact', 'Me at the zoo', 'play', '1503586577', 3284);
insert into event (user, video, event, event_time, video_time) values ('xX_alpha_Xx', 'Grass-roots full-range challenge', 'stop', '1624049617', 2388);
insert into event (user, video, event, event_time, video_time) values ('mike', 'Grass-roots full-range challenge', 'play', '1609200329', 2399);

insert into rating (id, video, rat) values (now(), 'Reactive disintermediate migration', 2);
insert into rating (id, video, rat) values (now(), 'Multi-lateral fault-tolerant collaboration', 2);
insert into rating (id, video, rat) values (now(), 'Switchable upward-trending website', 1);
insert into rating (id, video, rat) values (now(), 'Customer-focused bandwidth-monitored protocol', 2);
insert into rating (id, video, rat) values (now(), 'Reactive disintermediate migration', 1);
insert into rating (id, video, rat) values (now(), 'Switchable upward-trending website', 2);
insert into rating (id, video, rat) values (now(), 'Grass-roots full-range challenge', 1);
insert into rating (id, video, rat) values (now(), 'Switchable upward-trending website', 2);
insert into rating (id, video, rat) values (now(), 'Configurable grid-enabled framework', 1);
insert into rating (id, video, rat) values (now(), 'Multi-lateral fault-tolerant collaboration', 2);
insert into rating (id, video, rat) values (now(), 'Switchable upward-trending website', 3);
insert into rating (id, video, rat) values (now(), 'Configurable grid-enabled framework', 1);
insert into rating (id, video, rat) values (now(), 'Front-line transitional Graphic Interface', 2);
insert into rating (id, video, rat) values (now(), 'Me at the zoo', 1);
insert into rating (id, video, rat) values (now(), 'Me at the zoo', 4);
insert into rating (id, video, rat) values (now(), 'Customer-focused homogeneous forecast', 4);
insert into rating (id, video, rat) values (now(), 'Assimilated multi-tasking moratorium', 5);
insert into rating (id, video, rat) values (now(), 'Grass-roots full-range challenge', 3);
insert into rating (id, video, rat) values (now(), 'Customer-focused bandwidth-monitored protocol', 4);
insert into rating (id, video, rat) values (now(), 'Customer-focused bandwidth-monitored protocol', 2);
insert into rating (id, video, rat) values (now(), 'Customer-focused bandwidth-monitored protocol', 1);
insert into rating (id, video, rat) values (now(), 'Me at the zoo', 3);
insert into rating (id, video, rat) values (now(), 'Cross-group high-level capability', 4);
insert into rating (id, video, rat) values (now(), 'Me at the zoo', 3);
insert into rating (id, video, rat) values (now(), 'Me at the zoo', 3);
insert into rating (id, video, rat) values (now(), 'Configurable grid-enabled framework', 4);
insert into rating (id, video, rat) values (now(), 'Switchable upward-trending website', 4);
insert into rating (id, video, rat) values (now(), 'Configurable grid-enabled framework', 5);
insert into rating (id, video, rat) values (now(), 'Me at the zoo', 4);
insert into rating (id, video, rat) values (now(), 'Customer-focused homogeneous forecast', 5);

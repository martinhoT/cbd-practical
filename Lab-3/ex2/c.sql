USE videos_db;

-- 1.
SELECT * FROM comment_by_video WHERE video='Switchable upward-trending website' LIMIT 3;

-- 2.
DROP TABLE IF EXISTS video_tags_by_name;
CREATE TABLE video_tags_by_name (
    author          text,
    name            text,
    tags            frozen<set<text>>,
    upload_time     timestamp,

    PRIMARY KEY (name, author, upload_time)
);
INSERT INTO video_tags_by_name (author, name, tags, upload_time) VALUES ('man', 'Me at the zoo', {'Educational', 'Zoo'}, 51789571393729);
insert into video_tags_by_name (author, name, tags, upload_time) values ('xX_alpha_Xx', 'Assimilated multi-tasking moratorium', {'Action'}, '1562745766');
insert into video_tags_by_name (author, name, tags, upload_time) values ('man', 'Customer-focused homogeneous forecast', {'Homogeneous', 'Forecast', 'Customer'}, '1582876419');
insert into video_tags_by_name (author, name, tags, upload_time) values ('xX_alpha_Xx', 'Visionary attitude-oriented hierarchy', {'Futurology'}, '1553537440');
insert into video_tags_by_name (author, name, tags, upload_time) values ('__gis', 'Configurable grid-enabled framework', {'Framework', 'Technology'}, '1522692340');
insert into video_tags_by_name (author, name, tags, upload_time) values ('creative_bankruptcy_artifact', 'Grass-roots full-range challenge', {'Challenge', 'Aveiro'}, '1567105449');
insert into video_tags_by_name (author, name, tags, upload_time) values ('man', 'Customer-focused bandwidth-monitored protocol', {'Protocol', 'Customer', 'Network'}, '1564837031');
insert into video_tags_by_name (author, name, tags, upload_time) values ('xX_alpha_Xx', 'Cross-group high-level capability', {'Relationship'}, '1629898212');
insert into video_tags_by_name (author, name, tags, upload_time) values ('rivalAttorney', 'Front-line transitional Graphic Interface', {'Graphical interface', 'Supply-chain'}, '1624178698');
insert into video_tags_by_name (author, name, tags, upload_time) values ('xX_alpha_Xx', 'Switchable upward-trending website', {'Website'}, '1523224022');
insert into video_tags_by_name (author, name, tags, upload_time) values ('man', 'Reactive disintermediate migration', {'Market', 'Economy'}, '1632357317');
insert into video_tags_by_name (author, name, tags, upload_time) values ('xX_alpha_Xx', 'Multi-lateral fault-tolerant collaboration', {'Partnership'}, '1619384885');

-- 2.
SELECT tags FROM video_tags_by_name WHERE name='Me at the zoo';

-- 3. Não é possível normalmente. A única maneira de realizar uma query destas é fazer com que o atributo 'tags' deixe
-- de ser um conjunto e se passe a armazenar uma 'tag' por row, mas isso envolve adicionar várias rows para um único
-- vídeo (múltiplas INSERT statements). Este problema existe porque a query abaixo não pode ser realizada, já que a
-- partition key deve ser hashed para que se possa saber qual/quais nodes se devem pesquisar no cluster, para obter
-- certos dados. Como a query está a avaliar a existência de um elemento num conjunto, é impossível obter todos os
-- hashes possíveis, ou prever quais são, de todos os conjuntos que possuem esse elemento. Uma outra maneira é
-- recorrendo a um índice secundário, mas costuma não ser a melhor opção por questões de desempenho (neste caso não dá
-- porque 'tags' é um frozen set, podendo apenas ser comparado no seu todo).
DROP TABLE IF EXISTS video_by_tags;
CREATE TABLE video_by_tags (
    author          text,
    name            text,
    description     text,
    tags            frozen<set<text>>,
    upload_time     timestamp,

    PRIMARY KEY (tags, name, author, upload_time)
);
INSERT INTO video_by_tags (author, name, description, tags, upload_time) VALUES ('man', 'Me at the zoo', 'Why remove dislikes??', {'Educational', 'Zoo'}, 51789571393729);
insert into video_by_tags (author, name, description, tags, upload_time) values ('xX_alpha_Xx', 'Assimilated multi-tasking moratorium', 'productize proactive ROI', {'Action'}, '1562745766');
insert into video_by_tags (author, name, description, tags, upload_time) values ('man', 'Customer-focused homogeneous forecast', 'strategize cutting-edge e-markets', {'Homogeneous', 'Forecast', 'Customer'}, '1582876419');
insert into video_by_tags (author, name, description, tags, upload_time) values ('xX_alpha_Xx', 'Visionary attitude-oriented hierarchy', 'deploy synergistic relationships', {'Futurology'}, '1553537440');
insert into video_by_tags (author, name, description, tags, upload_time) values ('__gis', 'Configurable grid-enabled framework', 'seize revolutionary infomediaries', {'Educational', 'Technology'}, '1522692340');
insert into video_by_tags (author, name, description, tags, upload_time) values ('creative_bankruptcy_artifact', 'Grass-roots full-range challenge', 'whiteboard extensible platforms', {'Challenge', 'Aveiro'}, '1567105449');
insert into video_by_tags (author, name, description, tags, upload_time) values ('man', 'Customer-focused bandwidth-monitored protocol', 'integrate killer niches', {'Protocol', 'Customer', 'Network'}, '1564837031');
insert into video_by_tags (author, name, description, tags, upload_time) values ('xX_alpha_Xx', 'Cross-group high-level capability', 'evolve B2B relationships', {'Relationship'}, '1629898212');
insert into video_by_tags (author, name, description, tags, upload_time) values ('rivalAttorney', 'Front-line transitional Graphic Interface', 'innovate holistic supply-chains', {'Graphical interface', 'Supply-chain'}, '1624178698');
insert into video_by_tags (author, name, description, tags, upload_time) values ('xX_alpha_Xx', 'Switchable upward-trending website', 'repurpose viral users', {'Website'}, '1523224022');
insert into video_by_tags (author, name, description, tags, upload_time) values ('man', 'Reactive disintermediate migration', 'enable world-class e-markets', {'Market', 'Economy'}, '1632357317');
insert into video_by_tags (author, name, description, tags, upload_time) values ('xX_alpha_Xx', 'Multi-lateral fault-tolerant collaboration', 'repurpose dynamic partnerships', {'Partnership'}, '1619384885');

--SELECT * FROM video_by_tags WHERE tags CONTAINS 'Aveiro';

-- Abaixo está a solução com inserção de uma row por tag. Também é usada para a query 11.
DROP TABLE IF EXISTS tags_by_tag;
CREATE TABLE tags_by_tag (
    video       text,
    tag         text,

    PRIMARY KEY (tag, video)
);
INSERT INTO tags_by_tag (video, tag) VALUES ('Me at the zoo', 'Educational');
INSERT INTO tags_by_tag (video, tag) VALUES ('Me at the zoo', 'Zoo');
insert into tags_by_tag (video, tag) values ('Assimilated multi-tasking moratorium', 'Action');
insert into tags_by_tag (video, tag) values ('Customer-focused homogeneous forecast', 'Homogeneous');
insert into tags_by_tag (video, tag) values ('Customer-focused homogeneous forecast', 'Forecast');
insert into tags_by_tag (video, tag) values ('Customer-focused homogeneous forecast', 'Customer');
insert into tags_by_tag (video, tag) values ('Visionary attitude-oriented hierarchy', 'Futurology');
insert into tags_by_tag (video, tag) values ('Configurable grid-enabled framework', 'Framework');
insert into tags_by_tag (video, tag) values ('Configurable grid-enabled framework', 'Technology');
insert into tags_by_tag (video, tag) values ('Grass-roots full-range challenge', 'Challenge');
insert into tags_by_tag (video, tag) values ('Grass-roots full-range challenge', 'Aveiro');
insert into tags_by_tag (video, tag) values ('Customer-focused bandwidth-monitored protocol', 'Protocol');
insert into tags_by_tag (video, tag) values ('Customer-focused bandwidth-monitored protocol', 'Customer');
insert into tags_by_tag (video, tag) values ('Customer-focused bandwidth-monitored protocol', 'Network');
insert into tags_by_tag (video, tag) values ('Cross-group high-level capability', 'Relationship');
insert into tags_by_tag (video, tag) values ('Front-line transitional Graphic Interface', 'Graphical interface');
insert into tags_by_tag (video, tag) values ('Front-line transitional Graphic Interface', 'Supply-chain');
insert into tags_by_tag (video, tag) values ('Switchable upward-trending website', 'Website');
insert into tags_by_tag (video, tag) values ('Reactive disintermediate migration', 'Market');
insert into tags_by_tag (video, tag) values ('Reactive disintermediate migration', 'Economy');
insert into tags_by_tag (video, tag) values ('Multi-lateral fault-tolerant collaboration', 'Partnership');

-- 3.
SELECT video FROM tags_by_tag WHERE tag='Aveiro';

-- 4.
SELECT * FROM event WHERE video='Me at the zoo' and user='creative_bankruptcy_artifact' LIMIT 5;

-- 5. Adicionado upload_time à PRIMARY KEY
-- 5.
SELECT * FROM video_by_author WHERE author='man' and upload_time > '1970-01-19 02:05:45.766000+0000' and upload_time < '1970-01-19 21:25:57.317000+0000';

-- 6. Não é possível normalmente. A ordenação efetua-se para uma determinada partição (CLUSTERING ORDER), e não se pode
-- aplicar ao todo dos resultados, já que estão espalhados pelos diferentes nós do cluster. Uma maneira de realizar esta
-- query é fornecer uma PARTITION KEY que agrupa diferentes valores de 'upload_time', uma classe, e assim a ordem já
-- pode ser aplicada a cada classe. Neste caso, uma classe consegue envolver os últimos 10 vídeos, isto é, estão todos
-- na mesma partição, mas se muitas classes necessitarem de ser consultadas, então a ordenação das queries deverá ter de
-- ser feita do lado aplicacional. Esta divisão por classes permite assim filtrar por porções. No entanto, esta solução
-- traz o problema de possível sobrecarregamento de nós se as classes não forem bem estabelecidas. Por exemplo, se cada
-- classe corresponder a um dia e houver uma query que procura imensos dados de hoje, então o nó da classe que
-- corresponde ao dia de hoje ficará abnormalmente sobrecarregado, e a cada dia haverá um nó nesse estado. Abaixo está
-- demonstrado um exemplo desta abordagem, só para mostrar que é possível, mas não é propriamente ideal. A classe é por
-- 2 dias, e o primeiro vídeo tem classe 0.
--SELECT * FROM video_by_author;

DROP TABLE IF EXISTS video_by_utime_class;
CREATE TABLE video_by_utime_class  (
    author              text,
    name                text,
    upload_time_class   bigint,
    upload_time         timestamp,

    PRIMARY KEY (upload_time_class, upload_time)
) WITH CLUSTERING ORDER BY (upload_time DESC);

INSERT INTO video_by_utime_class (author, name, upload_time_class, upload_time) VALUES ('man', 'Me at the zoo', 123456789, 51789571393729);
insert into video_by_utime_class (author, name, upload_time_class, upload_time) values ('xX_alpha_Xx', 'Assimilated multi-tasking moratorium', 0, '1562745766');
insert into video_by_utime_class (author, name, upload_time_class, upload_time) values ('man', 'Customer-focused homogeneous forecast', 0, '1582876419');
insert into video_by_utime_class (author, name, upload_time_class, upload_time) values ('xX_alpha_Xx', 'Visionary attitude-oriented hierarchy', 0, '1553537440');
insert into video_by_utime_class (author, name, upload_time_class, upload_time) values ('__gis', 'Configurable grid-enabled framework', 0, '1522692340');
insert into video_by_utime_class (author, name, upload_time_class, upload_time) values ('creative_bankruptcy_artifact', 'Grass-roots full-range challenge', 0, '1567105449');
insert into video_by_utime_class (author, name, upload_time_class, upload_time) values ('man', 'Customer-focused bandwidth-monitored protocol', 0, '1564837031');
insert into video_by_utime_class (author, name, upload_time_class, upload_time) values ('xX_alpha_Xx', 'Cross-group high-level capability', 0, '1629898212');
insert into video_by_utime_class (author, name, upload_time_class, upload_time) values ('rivalAttorney', 'Front-line transitional Graphic Interface', 0, '1624178698');
insert into video_by_utime_class (author, name, upload_time_class, upload_time) values ('xX_alpha_Xx', 'Switchable upward-trending website', 0, '1523224022');
insert into video_by_utime_class (author, name, upload_time_class, upload_time) values ('man', 'Reactive disintermediate migration', 0, '1632357317');
insert into video_by_utime_class (author, name, upload_time_class, upload_time) values ('xX_alpha_Xx', 'Multi-lateral fault-tolerant collaboration', 0, '1619384885');

-- Obter classe mais recente:
-- 1. obter data do vídeo mais antigo (última entrada de 'SELECT upload_time FROM video_by_utime_class WHERE upload_time_class=0')
-- 2. calcular a classe através da diferença entre a data de hoje e a mais antiga (assume que na data de hoje, ou recentemente, há vídeos inseridos)
-- Para obter o desejado tem de se pesquisar desde a maior classe até a menor até se encontrar 10 registos. Isto pode
-- portanto envolver mais que uma query, e do lado aplicacional deve-se juntar os resultados). Por esta razão, mesmo
-- esta solução não é nada ideal, a não ser que não haja buracos temporais onde vídeos não tenham sido registados.
-- 6.
SELECT author, name, upload_time FROM video_by_utime_class WHERE upload_time_class=123456789 LIMIT 10;
-- ...
SELECT author, name, upload_time FROM video_by_utime_class WHERE upload_time_class=0 LIMIT 9;

-- 7.
SELECT user FROM follower WHERE video='Front-line transitional Graphic Interface';

-- 8. Não é possível. Para poder implementar a query seria necessário uma tabela que ia sendo alterada dinaminacamente
-- à medida que dados eram introduzidos nas tabelas dos followers e dos comentários, o que pode resultar numa quantidade
-- gigantesca de dados introduzidos (mesmo para poucas statements de inserção) e maior complexidade. Isto é um problema
-- porque não é possível fazer JOIN de tabelas em Cassandra, uma vez que tal podia envolver juntar dados que estão em
-- diferentes nós, envolvendo uma coordenação entre nós e maior tempo de execução para que a query possa ser realizada,
-- não tirando qualquer partido da forma como Cassandra armazena os dados. Isto apenas poderia ser realizado do lado
-- aplicacional, mas não é bem fazível simplesmente em CQL.

-- 9. Não é possível. A cláusula ORDER BY deve ser executada em atributos existentes na tabela, e não por atributos
-- criados durante a query (o 'score' final). Uma maneira de realizar esta query envolve uma maior complexidade e menor
-- eficiência: armazenar o atributo 'score' diretamente, com um contador do número de ratings total e a soma dos mesmos,
-- e a cada atualização dos valores os outros serão alterados consoantemente. Isto não tira propriamente partido do
-- modelo de dados em Cassandra, que é melhor em casos de mera inserção/append-only, com praticamente nenhumas remoções.
--SELECT sum(rat)/count(*) as score, video FROM rating GROUP BY video ORDER BY score DESC LIMIT 5;

-- 10. Não é possível. A cláusula ORDER BY requer a especificação da partition key na cláusula WHERE, e a CLUSTERING
-- ORDER especificada na criação da tabela apenas é aplicada a cada partição. O resultado da query abaixo é uma tabela
-- ordenada primeiro pela hash/token da partition key (ou outro método?) e depois pela ordem definida pela CLUSTERING
-- ORDER. Abaixo está apresentado o resultado normal, e nota-se que não está ordenado completamente pela CLUSTERING KEY
-- especificada na CLUSTERING ORDER, visto que múltiplas partições são apresentadas.
-- 10.
SELECT * FROM video_by_author;

-- 11. Reutilizada a tabela criada para efetuar a query 3.
-- 11.
SELECT tag, count(*) as video_count FROM tags_by_tag GROUP BY tag;

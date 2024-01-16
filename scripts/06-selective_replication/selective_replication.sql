
-- Sample:
-- https://www.enterprisedb.com/docs/pgd/latest/repsets/#selective-replication-example

CREATE TABLE attendee (
   id bigserial PRIMARY KEY, 
   email text NOT NULL
);

CREATE TABLE work (
    id int PRIMARY KEY,
    title text NOT NULL,
    author text NOT NULL
);

CREATE TABLE opinion (
    id bigserial PRIMARY KEY,
    work_id int NOT NULL REFERENCES work(id),
    attendee_id bigint NOT NULL REFERENCES attendee(id),
    country text NOT NULL,
    day date NOT NULL,
    score int NOT NULL
);

-- Regions
SELECT node_group_name, default_repset, parent_group_name
FROM bdr.node_group_summary;

-- tables
SELECT relname, set_name FROM bdr.tables ORDER BY relname, set_name;

-- Adding tables to repliciation sets
SELECT bdr.replication_set_add_table('opinion', 'us_east_2_subgroup');
SELECT bdr.replication_set_add_table('opinion', 'us_west_2_subgroup');

SELECT bdr.replication_set_remove_table('opinion', 'pgdcluster');

INSERT INTO work VALUES (1, 'Aida', 'Verdi');
INSERT INTO work VALUES (2, 'Lohengrin', 'Wagner');
INSERT INTO attendee (email) VALUES ('gv@example.com');

-- In node1
INSERT INTO opinion (work_id, attendee_id, country, day, score)
SELECT work.id, attendee.id, 'Italy', '1871-11-19', 3
  FROM work, attendee
 WHERE work.title = 'Lohengrin'
   AND attendee.email = 'gv@example.com';

-- In node2
INSERT INTO opinion (work_id, attendee_id, country, day, score)
SELECT work.id, attendee.id, 'Spain', '2024-01-15', 1
  FROM work, attendee
 WHERE work.title = 'Aida';

-- Select in different instances in east and west
select * from opinion;

SELECT a.email
, o.country
, o.day
, w.title
, w.author
, o.score
FROM opinion o
JOIN work w ON w.id = o.work_id
JOIN attendee a ON a.id = o.attendee_id;

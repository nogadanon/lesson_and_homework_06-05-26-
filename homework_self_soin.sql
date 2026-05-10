CREATE TABLE flights (
  id             INTEGER PRIMARY KEY,
  flight_no      TEXT    NOT NULL,
  origin         TEXT    NOT NULL,
  destination    TEXT    NOT NULL,
  prev_flight_id INTEGER,
  FOREIGN KEY (prev_flight_id) REFERENCES flights(id)
);

INSERT INTO flights VALUES
  (1,'TK101','NYC','London',NULL),
  (2,'TK102','London','Dubai',1),
  (3,'TK103','Dubai','Tokyo',2),
  (4,'TK104','Tokyo','Seoul',3),
  (5,'TK105','Tokyo','Sydney',3),
  (6,'AA201','LA','Chicago',NULL),
  (7,'AA202','Chicago','NYC',6),
  (8,'AA203','NYC','Miami',7),
  (9,'AA204','NYC','Boston',7),
  (10,'BA301','Paris','Rome',NULL),
  (11,'LH401','Frankfurt','Berlin',NULL),
  (12,'LH402','Amsterdam','London',11);


-- Show every flight with its predecessor flight number — use LEFT JOIN so origin flights (no predecessor) appear with NULL
SELECT pf.flight_no AS predecessor_flight, of.flight_no AS onward_flight 
FROM flights pf LEFT JOIN flights of ON pf.id = of.prev_flight_id;

-- Show only flights that directly follow 'TK101' (i.e. where the predecessor flight is TK101)
SELECT pf.flight_no AS predecessor_flight, of.flight_no AS onward_flight 
FROM flights pf LEFT JOIN flights of ON pf.id = of.prev_flight_id
WHERE pf.flight_no = 'TK101';

-- Count how many onward connections each flight has (how many flights list it as predecessor), sorted descending
SELECT pf.id, pf.flight_no, COUNT(of.flight_no) AS onward_connections_each_flight
FROM flights of LEFT JOIN flights pf ON pf.id = of.prev_flight_id
GROUP BY pf.flight_no
ORDER BY onward_connections_each_flight DESC;

-- Find flights where the predecessor's destination doesn't match the current flight's origin — a data-inconsistency check
SELECT pf.flight_no
FROM flights pf LEFT JOIN flights of ON pf.id = of.prev_flight_id
WHERE pf.destination <> of.origin;

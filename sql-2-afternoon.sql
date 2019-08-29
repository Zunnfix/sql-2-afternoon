------------------------
-- / Practice joins / --
------------------------

  --  SELECT [Column names] 
  --  FROM [table] [abbv]
  --  JOIN [table2] [abbv2] 
  --  ON abbv.prop = abbv2.prop 
  --  WHERE [Conditions];

--#1
  SELECT * -- This might not be optimal for larger sites
  FROM invoice i
  JOIN invoice_line il 
  ON il.invoice_id = i.invoice_id
  WHERE il.unit_price > 0.99;

--#2
  SELECT i.invoice_date, c.first_name, c.last_name, i.total
  FROM invoice i 
  JOIN customer c 
  ON i.customer_id = c.customer_id;

--#3
  SELECT c.first_name, c.last_name, e.first_name, e.last_name
  FROM customer c
  JOIN employee e 
  ON c.support_rep_id = e.employee_id;

--#4
  SELECT a.title, ar.name
  FROM album al
  JOIN artist ar 
  ON al.artist_id = ar.artist_id;

--#5
  SELECT pt.track_id
  FROM playlist_track pt
  JOIN playlist p 
  ON p.playlist_id = pt.playlist_id
  WHERE p.name = 'Music';

--#6
  SELECT t.name
  FROM track t
  JOIN playlist_track pt 
  ON pt.track_id = t.track_id
  WHERE pt.playlist_id = 5;

--#7
  SELECT t.name, p.name 
  FROM track t
  JOIN playlist_track pt 
  ON t.track_id = pt.track_id
  JOIN playlist p 
  ON pt.playlist_id = p.playlist_id;

--#8 // No abbreviations to clear up confusion
  SELECT track.name, album.title
  FROM track
  JOIN album 
  ON track.track_id = album.track_id
  JOIN genre 
  ON genre.genre_id = track.genre_id
  Where genre.name = 'Alternative & Punk';

---------------------------------
-- / Practice nested queries / --
---------------------------------

  --  SELECT [column names] 
  --  FROM [table] 
  --  WHERE column_id 
  --  IN ( SELECT column_id 
  --       FROM [table2] 
  --       WHERE [Condition] );

--#1
  SELECT *
  FROM invoice
  WHERE invoice_id 
  IN ( SELECT invoice_id 
       FROM unit_line 
       WHERE unit_price > 0.99 
     );

--#2
  SELECT *
  FROM playlist_track
  WHERE playlist_id 
  IN ( SELECT playlist_id 
       FROM playlist 
       WHERE name = 'Music' 
     );

--#3
  SELECT *
  FROM track
  WHERE track_id 
  IN ( SELECT track_id 
       FROM playlist_track 
       WHERE playlist_id = 5 
     );

--#4
  SELECT *
  FROM track
  WHERE genre_id 
  IN ( SELECT genre_id 
       FROM genre 
       Where name = 'Comedy' 
     );

--#5
  SELECT *
  FROM track
  WHERE album_id 
  IN ( SELECT album_id 
       FROM album 
       Where name = 'Fireball' 
     );

--#6
  SELECT *
  FROM track
  WHERE album_id 
  IN (
    SELECT album_id FROM album WHERE artist_id IN (
      SELECT srtist_id FROM artist WHERE name = 'Queen'
    )
  )

--------------------------------
-- / Practice updating Rows / --
--------------------------------

  --  UPDATE [table] 
  --  SET [column1] = [value1], [column2] = [value2] 
  --  WHERE [Condition];

--#1
  UPDATE customer
  SET fax = null
  WHERE fax IS NOT NULL;

--#2
  UPDATE customer
  SET company = 'self'
  WHERE company IS NULL;

--#3
  UPDATE customer
  SET last_name = 'Tompson'
  WHERE first_name = 'Julia' AND last_name = 'Barnett';

--#4
  UPDATE customer
  SET support_rep_id = 4
  WHERE email = 'luisrojas@yahoo.cl';

--#5
  UPDATE track
  SET composer = 'The darkness around us'
  WHERE genre = 'Metal' AND composer IS NULL;

------------------
-- / Group by / --
------------------

  --  SELECT [column1], [column2]
  --  FROM [table] [abbr]
  --  GROUP BY [column];

--#1
  SELECT count(*), g.name
  FROM track t
  JOIN genre g 
  ON t.genre_id = g.genre_id
  GROUP BY g.name;

--#2
  SELECT count(*), g.name
  FROM track t
  JOIN genre g 
  ON t.genre_id = g.genre_id
  WHERE g.name = 'Pop' OR g.name = 'Rock'
  GROUP BY g.name;

--#3
  SELECT artist.name, count(*)
  FROM album
  JOIN artist 
  ON artist.artist_id = album.artist_id
  GROUP BY artist.name;

----------------------
-- / Use Distinct / --
----------------------
  
  --  SELECT DISTINCT [column]
  --  FROM [table];

--#1
  SELECT DISTINCT composer
  FROM track

--#2
  SELECT DISTINCT billing_postal_code
  FROM invoice 

--#3
  SELECT DISTINCT company
  FROM customer 

---------------------
-- / Delete Rows / --
---------------------

  --  DELETE FROM [table]
  --  WHERE [condition]

------------------------------------------------------------------------------------------
  CREATE TABLE practice_delete ( name TEXT, type TEXT, value INTEGER );
  INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
  INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
  INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
  INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
  INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
  INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
  INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
  INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
  INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
------------------------------------------------------------------------------------------

--#1
DELETE FROM practice_delete 
WHERE type = 'bronze';

--#2
DELETE FROM practice_delete 
WHERE type = 'silver';

--#3
DELETE FROM practice_delete 
WHERE value = 150;

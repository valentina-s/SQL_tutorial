Complex spatial queries and joins cont'd
========================================

A common task is dealing with incomplete or inaccurate data. For example, the
stated location of a crime may not perfectly overlap with its address, so we
need to do a distance-based query rather than checking for perfect overlap.

Spatial SQL also lets you ask complicated questions about how data are related.
In this document, we will show some questions and how they can be answered with
spatial SQL queries.

### Example 0 - indexing

We often have to ask many-to-many questions in spatial queries, relating, for
example, an entire table's geometries to another table's geometries. As you
might imagine, by default it takes a very long time (M x N results for T1 with
M rows and T2 with N rows).

Spatial indices can speed up these queries, however. The basic principle of a
spatial index is that a new table (actually an index) is made knows how the
geometries are ordered on the X direction as well as the Y direction, and can
therefore make simplifying assumptions about when to stop searching for, e.g.,
the closest point.

http://revenant.ca/www/postgis/workshop/indexing.html

#### Question: How do I create a spatial index for a geometry column in a table?

CREATE INDEX seattlecrimeincidents_gix ON seattlecrimeincidents USING GIST (geom);

### Example 1 - closest N thefts

#### Question: What is the distance between our location and the closest N thefts, using the Seattle crime dataset?

SELECT ST_Distance(sc.geom, ST_SetSRID(ST_MakePoint(-122.3072131, 47.6212378), 4326))
  FROM seattlecrimeincidents sc
 WHERE "Offense Type" = 'THEFT-OTH'
 ORDER BY sc.geom <-> ST_SetSRID(ST_MakePoint(-122.3072131, 47.6212378), 4326)
 LIMIT 5;

If you've used PostGIS distance queries before, you might be wondering what's up
with that <-> thing. That's a distance operator, roughly equivalent to
ST_Distance, but is "index-assisted" and is fast in an ORDER BY clause.

More info: http://postgis.net/docs/manual-2.2/geometry_distance_knn.html

## Example 2 - Many-to-many joining on a spatial condition

Joins! You can use JOIN to make a query that combines info between tables.
Often, the tables being joined are defined under separate names+schemas, but
you can also join on subqueries, as the output of a SELECT is still a table
(algebra of SQL!).

You may have previously seen left/right joins, where you can combine tables
based on something like a shared attribute. This implies a 1-to-1 relationship
between the two tables. In the following examples, we are more interested in
doing many-to-many comparisons, which is facilitated well by a CROSS JOIN.

A CROSS JOIN generates the cartesian product of the two tables, so e.g.
for T1 CROSS T2, row 1 in T1 will be compared to every row in T2, and then the
same will happen for row 2, and so on.

    SELECT sc1.*,
           ST_Distance(sc1.geom, sc2.geom)
      FROM (SELECT *
              FROM seattlecrimeincidents
             WHERE "Offense Type" = 'THEFT-OTH') sc1
CROSS JOIN (SELECT *
              FROM seattlecrimeincidents
             WHERE "Offense Type" = 'TRESPASS') sc2
     LIMIT 5

Note: you would remove the last 'LIMIT 5' to get the full result. You could
also add another 'WHERE' clause at the end to filter the result to a more
specific question.

### Example 3 - Nearest Neighbors and Lateral Join
We could also do this for a set of points (e.g. another table). Let's say we're
interested in knowing how close together thefts and trespasses are reported.

#### Question: What is the distance between all trespassing events and the nearest theft?

This will involve the use of a new feature as of Postgres 9.3: Lateral joins.
In previous versions / other databases, you would use a stored procedure
(basically a function) that finds the closest trespass for a given point, but
the lateral joins lets you do it on the fly.

First, let's just look at the query we would run if there was only one trespass
event that we cared about:

// This won't run - sc1 is not defined
  SELECT geom
    FROM seattlecrimeincidents
   WHERE "Offense Type" = 'TRESPASS'
ORDER BY sc1.geom <-> geom
   LIMIT 1

This query can be turned into a subquery in a lateral join such that it runs on
every row in sc1.

            SELECT sc1.*,
                   ST_Distance(sc1.geom, sc2.geom)
              FROM (SELECT *
                      FROM seattlecrimeincidents
                     WHERE "Offense Type" = 'THEFT-OTH') sc1
CROSS JOIN LATERAL (  SELECT geom
                        FROM seattlecrimeincidents
                       WHERE "Offense Type" = 'TRESPASS'
                    ORDER BY sc1.geom <-> geom
                       LIMIT 1) sc2
             LIMIT 5

Note: you would remove the last 'LIMIT 5' to get the full result.

### Example 4 - Tweaking subqueries for hypothesis testing

Maybe we want to use the numbers we got in the last query in an analysis. Do
those events co-occur (or at least, occur in the same vicinity) more often than
average?

#### Question: What is the distance between a given trespassing event and any other crime?

            SELECT sc1.*,
                   ST_Distance(sc1.geom, sc2.geom)
              FROM (SELECT *
                      FROM seattlecrimeincidents
                     WHERE "Offense Type" = 'THEFT-OTH') sc1
CROSS JOIN LATERAL (  SELECT geom
                        FROM seattlecrimeincidents
                       WHERE "Offense Type" != 'THEFT-OTH'
                    ORDER BY sc1.geom <-> geom
                       LIMIT 1) sc2
             LIMIT 5

### Example 4 - Aggregation functions

Aggregation functions are a useful way to summarize columsn. For example, we
could take our previous results and compute averages:

// Should be ~.003005
            SELECT AVG(ST_Distance(sc1.geom, sc2.geom))
              FROM (SELECT *
                      FROM seattlecrimeincidents
                     WHERE "Offense Type" = 'THEFT-OTH') sc1
CROSS JOIN LATERAL (  SELECT geom
                        FROM seattlecrimeincidents
                       WHERE "Offense Type" = 'TRESPASS'
                    ORDER BY sc1.geom <-> geom
                       LIMIT 1) sc2

// Should be ~.0001877
            SELECT AVG(ST_Distance(sc1.geom, sc2.geom))
              FROM (SELECT *
                      FROM seattlecrimeincidents
                     WHERE "Offense Type" = 'THEFT-OTH') sc1
CROSS JOIN LATERAL (  SELECT geom
                        FROM seattlecrimeincidents
                       WHERE "Offense Type" != 'THEFT-OTH'
                    ORDER BY sc1.geom <-> geom
                       LIMIT 1) sc2

Okay, well that's pretty good. We can compute averages, but that glosses over a
lot of details.

### Example 5 - chaining joins
But since we're using SQL, we can ask a more specific question
in the same vein: for every trespassing event, what is its closest theft and
its closest crime in general? That will give us a dataset for which we could
explore a distribution of phenomena, much more interesting!

            SELECT sc1.*,
                   ST_Distance(sc1.geom, sc3.geom) / NULLIF(ST_Distance(sc1.geom, sc2.geom))
              FROM (SELECT *
                      FROM seattlecrimeincidents
                     WHERE "Offense Type" = 'THEFT-OTH') sc1
CROSS JOIN LATERAL (  SELECT geom
                        FROM seattlecrimeincidents
                       WHERE "Offense Type" = 'TRESPASS'
                    ORDER BY sc1.geom <-> geom
                       LIMIT 1) sc2
CROSS JOIN LATERAL (  SELECT geom
                        FROM seattlecrimeincidents
                       WHERE "Offense Type" != 'THEFT-OTH'
                    ORDER BY sc1.geom <-> geom
                       LIMIT 1) sc3

### Example 6 - exporting

We will want a snippet of data for the next lesson. This will involve running
an SQL query, then saving it with QGIS.

#### Step 1
In QGIS, connect to the database with the seattlecrimes dataset (if not already
done).

#### Step 2
In QGIS, click (in menu) Database > DB manager, select the dssg2016 database,
and open the SQL Window using File > SQL Window, clicking its icon, or hitting 'F2'.

#### Step 3

Input this into the SQL Query form:

SELECT * FROM seattlecrimeincidents LIMIT 100;

Then click 'Execute'. By default, we get back the result as a table.

#### Step 4

To save the query's result to a QGIS layer, check 'Load as new layer', choose
'gid' as the 'Column with unique integer values', 'geom' as the 'Geometry Column',
and 'first100' as the Layer name (prefix).

Click 'Load now!'

The should now be a new layer in your QGIS session. Note that it has not been
saved to file yet.

#### Step 5

Export by right clicking on the layer ('first100'), clicking 'Save as', and
choosing 'Format' to be GeoJSON.

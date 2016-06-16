# Exercise 4

In this exercise we will explore spatial relationships with our dataset.

### Question to answer:
What is the most common crime within 1 km of my house?

#### Step 1: Find the coordinates of your house (or some other feature in the Seattle region).

* HINT: you can use google maps to find the latitude and longitude of any map location, e.g.:

<img src = "images/googlemaps.png" width = 600>

#### Step 2: Build the SQL query. You will need to nest 4 different functions to do this:

* ST_MakePoint: to make a vector point geometry from your lat/long coordinate pair
* ST_SetSRID: to tell the database which SRID your lat/long pair conforms to
* ST_Transform: to transform your point geomtery to a projected coordinate system
* ST_Distance: to calculate the distance between all the geometries in the database and your single point

Create the point geometry using a geographic coordinate system (SRID = 4326). Transform the coordinates to UTM Zone 10 (SRID = 3717). You will need a WHERE clause to check if the distance between your point and all "geom_utm".

### Additional tasks, if you have time! 

#### Plotting your data on a map:

* download the [QGIS](http://qgis.org/en/site/) software
* run the software and connect to the database:
   * click on "layer/add PostGIS layers"
   * click on the "new" button and enter the connection information (similar to what you did in exercise 1 for the pgadmin software)
   * click on the "connect" button
   * you should now see the database tables we've been working with. Add one of these and it should appear on the map.
* things to explore next:
   * change the symbology of the points, coloring them by a specific attribute so that the colors illustrate grouping in the data
   * add a background map "web\QuickMapServices\OSM"
   * issue the SQL query you built above to select only those points within 1 km of a point
     * click on "database\DBmanager" and you will see the database you which you have already connected.
     * issue a SQL query in the SQL command window (blue arrow in this screen capture):
<img src = "images/dbmanager.png" width = 600>
 
#### Interfacing with the database from Python:

We will use [pandas](pandas.pydata.org) which is a fantastic data analysis toolkit that happens to have some very simple methods for moving data to and from a database. The datbase connections are handled through pandas using [sqlalchemy](www.sqlalchemy.org).

```Python
import pandas as pd
from sqlalchemy import create_engine
import sqlalchemy.types as types
```
Our next step is to pass some database connection information to pandas/sqlalchemy so that we can establish a connection. We create a database "engine" object that is then used in subsequent operations as a portal to/from the database.

```Python
host = 'dssg2016.c5k9fqonks28.us-east-1.rds.amazonaws.com'
user = 'dssg_student'
password = 'dssg2016'
port = '5432'
dbname = 'dssg2016'
engine = create_engine('postgresql://' + user + ':' + password + '@' + host + ':' + port + '/' + dbname)
```
Now we can issue a query to the database as follows:

```Python
df =pd.read_sql('SELECT * FROM seattlecrimeincidents LIMIT 100', engine)
```

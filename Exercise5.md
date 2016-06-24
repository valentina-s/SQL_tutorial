# Exercise 5

In this exercise we will explore data in QGIS and do more complex spatial queries.

## Visualizing Census Data

We will start by interfacing the crimes dataset with census tracts. For this we will need the census tract data that includes geospatial encoding (vector polygons) so we can import these into a GIS.


* download the King county tracts (zip file) ArcGIS shapefiles at the bottom of the [city of Seattle census data website](http://www.seattle.gov/dpd/cityplanning/populationdemographics/geographicfilesmaps/2010census/default.htm). Unzip the file and copy the shapefiles into a folder on your computer.
* open a blank map in QGIS. Choose "Layer/add layer/ add vector layer" and browse to the shapefile location (hint: only choose the file with the '.shp' extension).
* open the attributes of the layer (right click on the layer and choose "open attribute table")
* note that this shapefile only contains basic information on the census tract, but no population or other demographic data that we need to generate a useful map. So, we need to join these polygons with our census table from Exercise 4.
* To accomplish this we imported this census boundary shapefile into the database and called the table "census_tracts". Connect to the database as shown in Exercise 4.
* issue the following query:

```SQL
SELECT c2.id, c1.population, c1.popdensity, c1.vacant_housing, c2.geom FROM
(SELECT "Census Tract"::float/100 AS CT, 
  "Total Population, 2010" AS population, 
  "Persons per Square Mile, 2010" AS popdensity,
  "Vacant Housing Units, 2010" AS vacant_housing
  FROM census_data) AS c1,
(SELECT id, name10::float AS CT, geom FROM census_tracts) AS c2
WHERE c1.CT = c2.CT;
```
* now import that layer into the GIS, giving it an arbitrary name. You can now symbolize this polygon layer according to population density, housing vacancy, etc. Explore with different color schemes and visualizations.
* suppose we want to show a similar map, but coloring the polygons by the number of crimes in each tract. We already know how to count numbers of crimes grouping by census tract using SQL, however we would not be able to put those on a map without joining to the census tract polygon layer. Let's use a GIS approach to do this:
    * add the seattlecrimeincidents table to the GIS
    * choose "vector/data management tools/join attributes by location"
    * the "target vector layer" is the census tract polygon layer generated from our query above. The "join vector layer" is the seattlecrimesincidents layer 
    * for "attribute summary" choose "take summary of intersecting features". You can choose any statistic. We're only interested in the "count" statistic that gets returned from this calculation.
    * specify a shapefile name and location
    * for "output table" select "only keep matching records"
    * click OK and OK again to include the joined shapefile as a new layer
    * examine the attribute table of the joined layer 

## Visualizing ORCA transfer data

The ORCA team has been exploring a .csv file containing information on ORCA transfers. Each row has a lat/long value that we can use to build a map visualization. Here is an example of how we can import data in csv format to a GIS:

* choose "layer/add vector layer/add delimited text layer". Browse to the orca_transfers.csv file.
* provide a layer name and check that the X field and Y field contain longitude and latitude columns, respectively
* click OK to load the data into the GIS




 

# Exercise 5

In this exercise we will explore data in QGIS and do more complex spatial queries.

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





 

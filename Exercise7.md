GIS polygon transformations with Dropchop
=========================================

### Step 0 - export a (small) set of points from QGIS, e.g. the last query of Exercise 6

### Step 1 - go to dropchop.io

### Step 2 - Load the first 100 rows from the seattle crime dataset in geojson format (exported from QGIS in Exercise 6).
To load a file, click the 'plus' button on the top left, then click the top (upload) option in the submenu.

### Step 3 - zoom to layer
Right click on the first100 layer and click 'view extent of layers'

### Step 4 - buffer
Buffer takes any shape (point, line, or polygon) and creates a new polygon
that is basically an outline of the input shape, but 'buffered' out by some
distance.

Click 'Buffer' in dropchop.io with your first100 layer selected.

Select '500' for distance, and change the unit to meters.

Click Execute.

### Step 5 - Center and Centroid

Uncheck 'first100' to make it invisible

Click 'Center' and hit 'Execute'. This calculates the 'center of mass' of the
overall shape.

Click 'Centroid' and hit execute. This calculates another form of 'center'.

### Step 6 - Envelope

Click 'Envelope'. This generates a minimal bounding rectangle of your geometries.

### Step 7 - Union / Intersection

This is not well-supported in Dropchop.io - chalk talk


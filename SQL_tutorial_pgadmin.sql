-- use SQL_Tutorial;
-- show tables;

-- show all columns in a table
select * from seattlecrimeincidents limit 100;
select * from census;
select gid from census;

-- ------------------ Selection ----------------------

-- show a column from the table
select geom_utm from seattlecrimeincidents;

-- show  two columns at the same time
select longitude,latitude from SeattleCrimeIncidents;

-- some columns have spaces in the name - enclose them with quotes
-- suggestion: if you are the one creating a table do not use spaces!!!
select "Offense Type" from SeattleCrimeIncidents;

-- Let's order the rows:
select "Offense Type","Zone/Beat" from SeattleCrimeIncidents order by "Zone/Beat" ASC;


-- selecting specific rows (use where):

-- rows for which the Offence Type is equal to 'Theft-Bicycle'
select * from SeattleCrimeIncidents 
	where "Offense Type" = 'THEFT-BICYCLE';

-- rows for which the Offence Type is not 'THEFT-BICYCLE'
select * from SeattleCrimeIncidents 
	where "Offense Type" <> 'THEFT-BICYCLE';
    
-- Check if there are rows with missing locations
select * from SeattleCrimeIncidents
	where latitude is NULL;

-- Finding all rows which contain Offense types which start with Theft
select * from SeattleCrimeIncidents
	where "Offense Type" like 'THEFT%';


-- --------------- Functions ------------------------------------   

-- Functions act on columns
select count(*) from SeattleCrimeIncidents;
select min(longitude), max(longitude),min(latitude),max(latitude) from SeattleCrimeIncidents
	where "Offense Type" = 'THEFT-BICYCLE';

-- Other functions: sum, avg, round, etc, ...


-- ----------------------------------------------------------------------------------------------------


-- Applying functions within categories

-- count how many offenses are for each Offense Type
select "Offense Type",count(*) from SeattleCrimeIncidents 
	group by "Offense Type";

-- Note: for homicide we see there are a lot of types of homicides -> use summarized offense description
    
-- count how many offenses are for each Summarized Offense Description
select "Summarized Offense Description", count(*) from SeattleCrimeIncidents 
	group by "Summarized Offense Description";

select year, count(*) from SeattleCrimeIncidents
	group by year;

-- ------------- Working with two tables -----------------------------------------

-- create a table of Crime Incidents by Census Tract and order by descending count
-- (need to round and divide by hundred to match the census tracts in the other data) 
select round("census tract 2000")/100 as CT, count(*) as count from SeattleCrimeIncidents 
	group by "census tract 2000" order by count DESC;

-- create a table of Population by Census Tract (remove the string Census tract to extract the number of the tract)
select "Total Population, 2010" as population, "Census Tract" as CT from census;

-- create a table with population and incident number for each census tract
select crimeTable.CT,crimeTable.count,censusTable.population as crime_rate from 
	(select round("census tract 2000")/100 as CT, count(*) as count from SeattleCrimeIncidents group by "census tract 2000") crimeTable
    left join 
    (select "Total Population, 2010" as population,"Census Tract"as CT from census) censusTable
    on crimeTable.CT = censusTable.CT;

-- create a table with incident per capita rate for each tract and order by the descending rate
select crimeTable.CT,crimeTable.count::float/censusTable.population::float as crime_rate from 
	(select round("census tract 2000") as CT, count(*) as count from SeattleCrimeIncidents group by "census tract 2000") crimeTable
    join 
    (select "Total Population, 2010" as population,"Census Tract" as CT from census) censusTable
    on crimeTable.CT = censusTable.CT order by "crime_rate" DESC;


-- create a table with incident per capita rate for each tract and order by the descending rate
select crimeTable.CT,crimeTable.count::float/censusTable.population::float as crime_rate from 
	(select round("census tract 2000") as CT, count(*) as count from SeattleCrimeIncidents group by "census tract 2000") as crimeTable,
    (select "Total Population, 2010" as population,"Census Tract" as CT from census) as censusTable
    where crimeTable.CT = censusTable.CT order by "crime_rate" DESC;
    
select "Total Population, 2010" as population,"Census Tract" from census;
select round("census tract 2000") as CT, count(*) as count from SeattleCrimeIncidents group by "census tract 2000" order by "census tract 2000";


--  Your turn: 

--  find the census tract with highest rate of bike thefts:

-- Are there more bike thefts in the summer than the winter months?

--  How are drug crimes associated with vacant housing?

--  ...

-- 

SELECT "census tract 2000",count(*) FROM seattlecrimeincidents group by "census tract 2000" order by "census tract 2000" DESC;

select "Total Population, 2010" as population,"Census Tract" as CT from census;
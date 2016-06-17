-- simple queries after connecting to database

SELECT * FROM seattlecrimeincidents LIMIT 100;
SELECT count(*) FROM seattlecrimeincidents LIMIT 100;

-- Exercise 1 Practice Problems Answers:

-- number of all TRESPASS crimes
SELECT count(*) FROM seattlecrimeincidents WHERE "Offense Type" = 'TRESPASS'

-- range of latitude and longitude coordinates
SELECT min(longitude), max(longitude),min(latitude),max(latitude) FROM seattlecrimeincidents

-- count of the bike thefts in the month of january
SELECT count(*) FROM seattlecrimeincidents
	WHERE "Offense Type" = 'THEFT-BICYCLE' and month = 1

-- ---------------------------------------------------------------------------------
-- Grouping discussion

-- count how many offenses are for each Offense Type
select "Offense Type",count(*) from SeattleCrimeIncidents
	group by "Offense Type" order by count ASC;

-- Note: for homicide we see there are a lot of types of homicides -> use summarized offense description

-- count how many offenses are for each Summarized Offense Description
select "Summarized Offense Description", count(*) from SeattleCrimeIncidents
	group by "Summarized Offense Description";

select year, count(*) from SeattleCrimeIncidents
	group by year;


-- ---------------------------------------------------------------------------------
-- Exercise 2 Practice Problem Answers:

-- crimes for each month
SELECT month,count(*) FROM seattlecrimeincidents GROUP BY month ORDER BY month ASC


-- month with highest number of bike thefts
SELECT month,count(*) FROM seattlecrimeincidents
	WHERE "Offense Type" = 'THEFT-BICYCLE'
	GROUP BY month
	ORDER BY count DESC

-- number of crimes per census tract
SELECT "census tract 2000",count(*) FROM seattlecrimeincidents
	group by "census tract 2000"
	ORDER BY "census tract 2000" ASC;

-- idea of nesting and aliasing

-- ----------------------------------------------------------------------------------

-- Exercise 3 Practice Problem Answers:

-- table: tract | crime_count
SELECT round("census tract 2000"),count(*) FROM seattlecrimeincidents
	group by "census tract 2000"
	ORDER BY "census tract 2000" ASC;

-- table: tract | population
SELECT "Census Tract","Total Population, 2010" as population from census
	ORDER BY "Census Tract" ASC;


-- joining query

SELECT crimeTable.CT,cast(crimeTable.count as float)/censusTable.population as crime_rate from
	(select round("census tract 2000") as CT, count(*) as count from SeattleCrimeIncidents group by "census tract 2000") as crimeTable,
    (select "Total Population, 2010" as population,"Census Tract" as CT from census) as censusTable
    where crimeTable.CT = censusTable.CT order by "crime_rate" DESC;

## Combining tables

The goal of this exercise is to find the census tract with highest crime rate.

We have all already calculated the number of crimes in each census tract:
```sql
SELECT "census tract 2000",count(*) FROM seattlecrimeincidents group by "census tract 2000"
```

But we are interested in the crime *rate*, i.e. we want to normalize by the population of each tract.

For need to use additional information from the census table.

* Write a query which displays the population for each tract

Now we have two tables: one with census tract and crime count and one with census tract and population.

crimeTable:

|census tract 2000|crime_count|
|-----------------|-----------|
|                 |           | 
|                 |           |
|                 |           |

censusTable:

|Census Tract|Population|
|------------|----------|
|            |          | 
|            |          |
|            |          |


* Discuss with your neighbor how we can combine those two tables to create a new table with columns: census tract, crime_rate

|Census Tract|Crime_rate|
|------------|----------|
|            |          | 
|            |          |
|            |          |

* Are there any issues you are encountering?
* How can you fix them?

Let's write the final query let's write the final query 

```sql
SELECT <>, <> FROM 
	(<>) as crimeTable,
    (<>) as censusTable
    where crimeTable.CT = censusTable.CT;

```

Hint: 
* Insert the two queries which create the tables in the appropriate place 
* What are the final columns that you want to have in the table?



 











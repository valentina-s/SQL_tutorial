# Exercise 1

In this exercise we will work on connecting to a database hosted on Amazon Web Services. Then we will practice issuing a few queries and start experimenting with SQL.

## Step 1: Connecting to the DSSG tutorial database

#### Download software
We will use the [pgAdmin](https://www.pgadmin.org/download/) software to connect to the database.

* Windows - [click here](https://www.postgresql.org/ftp/pgadmin3/release/v1.22.1/win32/) and download pgadmin3-1.22.1.zip to install the application

* Mac OSX - [click here](https://www.postgresql.org/ftp/pgadmin3/release/v1.22.1/osx/) and download the file pgadmin3-1.22.1.dmg to install the application

* Linux - sudo apt-get install pgadmin3

Start pgAdmin.

#### Connect to the database

1. click on the connection icon:
<br><br>
<img src="images/toolbar.png" width = "400" border = "10">
<br><br><br><br>
2. fill in the connection information. 
* The host name is: dssg2016.c5k9fqonks28.us-east-1.rds.amazonaws.com 
* The port is: 5432
* The username is: dssg_student
* The password is: dssg2016
<br><br>
<img src="images/connection.PNG" width="400"> 
<br><br><br><br>
3. Click "OK". You will see the following. We only need to access the tables (see blue arrow), so click to expand that.
<br><br>
<img src="images/dbview.png" width = "400" border = "1">
<br><br><br><br>
4. Continue to expand to see all the columns of the "seattlecrimeincidents" table:
<br><br>
<img src="images/fullView.png" width = "600" border = "1">
<br><br><br><br>
5. Most of the pgadmin interface contains information on the structure of the data tables (e.g. column names), but where are the actual data? Let's take a look: 
* Right click _Valentina, how to do this on a MAC??_ on the "seattlecrimeincidents" table, choose "View Data" and then "View Top 100 Rows" or "View Bottom 100 Rows" (Note: don't choose "View All Rows" because this will take a long time to load given the large size of the table).
<br>
<img src="images/viewingData.png" width = "400" border = "10">
<br>
A new window should appear allowing you to browse through some of the data. Take some time to become familiar with the contents of the table.
<br>
6. For future reference, these instructions are also summarized on [this AWS tutorial page](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ConnectToPostgreSQLInstance.html) 

## Step 2: Issuing your first queries

* Queries can be issued to the database in many different ways. Here we'll use the SQL query window in pg_admin. This is a great way to test out ideas before implementing your SQL queries in a script.
<br>
1. click on the "Execute Arbitrary SQL Queries" button:
<br><br>
<img src="images/toolbarSQL.png" width = "400" border = "10">
<br><br>
2. This should bring up a new window: 
<br><br>
<img src="images/SQLeditor.png" width = "400" border = "10">
<br><br>
The upper pane is where we will issue our query, and the results of the query will be shown in the output pane below.
<br><br>
3. Submit your first query by typing the following into the SQL pane:
<br><br>
```sql
SELECT * FROM seattlecrimeincidents LIMIT 100;
```

<br><br>
__NOTE:__ The "LIMIT" command restricts the database to return only the first 100 rows.
<br>
* the "*" is a wildcard requesting all columns from the database. 
<br><br>

For example, we can apply the count function to all the columns:
<br><br>
```sql
SELECT count(*) FROM seattlecrimeincidents LIMIT 100;
```
<br><br>

This gives us the number of the rows in the table.


## Step 3: Practice problems
1. Try to write a query to answer our first question from our data exploration effort with the original .csv file:
_How many "TRESPASS" offenses occurred in total?_
Here's a hint to get you started. (substitude < > with the appropriate variable or SQL command).
```sql
SELECT < > FROM seattlecrimeincidents WHERE < > = < > 
```
2. Can you obtain the range of the latitude and longitude coordinates of all crimes? 

Hint: use "max" and "min" functions.

3. Extra. Combine a few conditions together:
_What is the number of bike thefts in the month of january?_

You can use this [cheatsheet](http://www.sql-tutorial.net/sql-cheat-sheet.pdf) to look up the different SQL commands.



 



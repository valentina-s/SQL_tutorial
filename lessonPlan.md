## Lesson Plan for SQL tutorial

### 9 - 12, Friday June 17

#### Data exploration: 15 minutes

* _Method_:
    * Seattle crimes .csv file available before class begins. Students arrive with dataset stored locally.
    * On the whiteboard we write out 3 simple questions to explore the data:
    * We ask the students how they would begin to answer these questions with what they know now. We do not provide any instructions on software or how to accomplish this. We ask students to sketch out ideas, not try to answer the specific questions but focus on HOW to step through the process.
    * We give students 1 minute to explore on their own, 2 minutes in groups of 2, 4 minutes in groups of 4, then report out, with ideas written on whiteboard. Anthony/Valentina moderate.
* _Purpose_:
    * students gain immediate experience with a typical DSSG dataset
    * students quickly recognize scope of their own toolkit for exploring the data
    * instructors get a sense of the current state of student knowledge
* _Potential Challenges_:
    * Problems accessing the data - too large or students don't know what a .csv is and how to open it. We should be able to move around the class helping with this.
    * Students don't understand the purpose and don't come up with ideas. We can feed some ideas to start the conversation if this happens.
* _Possible Outcomes_:
    * It's likely students will load the data into a spreadsheet. They might manually group cells, sort the data, make simple plots and may realize this is time consuming.
    * Others will think right away about writing code. We can briefly explore with them what this might look like.
    * Some students may wonder what the "X" means in some of the columns, in general what do the different column names mean? We can use this to illustrate challenges in working with these kinds of statistics. It is very common to that we lack metadata, that null values are not treated correctly, that the data are not normalized or consistent.

#### Database Lecture 1: 20 minutes

* _Content_:
    * What is a database?
        * software system for storing and analyzing data that exist row/column format
        * there are numerous flavors of databases, but we will focus on Relational Database Systems
    * Motivation for using a database
        * fast searching
        * powerful methods for performing analysis on groups of data
        * capability of joining information between datasets
        * data types have unique functionality (e.g. dates are not just integers but have methods related to year, month, day)
        * centralized repository, minimizes duplication, controlled access across multiple users
        * optional: geospatial encoding  
    * Structured Query Language (SQL):
        * standard language for relational databases
        * across different databases the core syntax is similar but there are small differences in some function names
        * structure of a SQL statement, some example table creations and selections using the crimes database
    * Database implementations:
        * multiple software packages (list examples); many commercial vendors
        * open source options are improving rapidly
        * databases usually reside on a server but can be deployed locally for testing
        * either way: connecting to a database is done via a connection string (show format)
        * interface: GUI, command line, embedded in scripts

#### Exercise Set 1: 20 minutes

* _Purpose_:
    * students gain direct experience in connecting to database
    * students get introduction to the pgadmin inerface and learn to run simple queries
    * students learn to create own queries to answer relevant questions
    
* _Method_:
    * instructors show the pgadmin interface and run a simple command - students repeat by following instructions in [Exercise 1] (Exercise1.md) 
    * students answer the practice questions using a [cheat sheet](http://www.sql-tutorial.net/sql-cheat-sheet.pdf) and lecture notes



#### Exercise Set 2: ?? minutes
* _Purpose_:
  * Students practice grouping queries
* _Method_: 
   *  answer questions in [Exercise 2](Exercise2.md)
   
* _Potential Challenges_:
  * there are crimes from older years
  * type of crimes may refer to all types of offenses or only summarized offenses



#### Discussion: 15 minutes
* ordering
* aliasing
* nesting


#### Exercise Set 3: 30 minutes

* _Purpose_:
    * learn to work with two tables
      * identify a common key on which to join the tables
      * do preprocessing to match the keys
* _Method_:
   * go through steps in [Exercise 3](Exercise3.md) with instructors' help 
   
* _Challenges_:
   * Census Tract column names do not have the same title
   * The Census Tract values in the crime table are more refined than in the census table
   * division of integer gives zero

#### Geospatial Lecture: 20 minutes
* _Content_:
    * intro to mapping, coordinate systems, 3 types of vector data
    * how location is encoded in a database; GIS as a front end to a relational database with geospatial encoding
    * a new data type: geometry
    * implementation: in PostgreSQL, a simple extension called "PostGIS"
         * how to build a geometry from lat/long
         * a few spatial query functions in PostGIS (ST_Contains, ST_
    * intro to other implementations (Tableau, etc)
    * common misconceptions with spatial data: geographic coordinates cannot just be subtracted: concept of spherical versus projected data

#### Exercise Set 3: Exploring geospatial concepts
* _Purpose_:
     * students include spatial queries

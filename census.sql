CREATE TABLE census (
	`County Name` VARCHAR(11) NOT NULL, 
	`Census Tract` VARCHAR(19) NOT NULL, 
	`Total Population, 2010` float NOT NULL, 
	`Population Density (Persons / Square Mile), 2010` FLOAT, 
	`Total Housing Units, 2010` INTEGER NOT NULL, 
	`Occupied Housing Units, 2010` INTEGER NOT NULL, 
	`Vacant Housing Units, 2010` INTEGER NOT NULL, 
	`Occupancy Rate (%%), 2010` FLOAT, 
	`Vacancy Rate (%%), 2010` FLOAT, 
	`Land Area (Square Miles), 2010` FLOAT NOT NULL, 
	`Total Area (Square Miles), 2010` FLOAT NOT NULL, 
	`Water Area (%%), 2010` FLOAT NOT NULL, 
	`Geoid` BIGINT NOT NULL
);

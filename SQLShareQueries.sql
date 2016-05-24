SELECT year, month, [Offense Type], count(*) as incident_count
  FROM [billhowe].[Seattle_Police_Department_Police_Report_Incident.csv]
 GROUP BY [Offense Type], year, month
 ORDER BY incident_count desc​
  ​
  ​
  ​SELECT year, month, [Offense Type]
FROM [billhowe].[Seattle_Police_Department_Police_Report_Incident.csv]
WHERE [Offense Type] = 'THEFT-CARPROWL' 
   OR [Offense Type] = 'VEH-THEFT-AUTO'
   

SELECT year, month, [Offense Type]
  FROM [billhowe].[table_Seattle_Police_Department_Police_Report_Incident.csv]​
 
 
 

SELECT count(*) FROM [billhowe].[Seattle_Police_Department_Police_Report_Offense.csv] o
 --  705114
   
 SELECT count(*) FROM [billhowe].[table_Seattle_Police_Department_Police_Report_Incident.csv] i  ​​​​​​​​
--   621361
   
   
   
SELECT count(*) 
  FROM [billhowe].[Seattle_Police_Department_Police_Report_Offense.csv] o
     , [billhowe].[table_Seattle_Police_Department_Police_Report_Incident.csv] i
 WHERE o.[CDW Incident ID] = i.[RMS CDW ID]
-- 667308


   
 SELECT i.[RMS CDW ID], count(*) 
  FROM [billhowe].[Seattle_Police_Department_Police_Report_Offense.csv] o
     , [billhowe].[table_Seattle_Police_Department_Police_Report_Incident.csv] i
 WHERE o.[CDW Incident ID] = i.[RMS CDW ID]
 GROUP BY i.[RMS CDW ID]
  HAVING count(*) > 1
  ORDER BY count(*) DESC
  
  

SELECT o.*
  FROM [billhowe].[Seattle_Police_Department_Police_Report_Offense.csv] o
     , [billhowe].[table_Seattle_Police_Department_Police_Report_Incident.csv] i
 WHERE o.[CDW Incident ID] = i.[RMS CDW ID]
 AND [RMS CDW ID] = 647908​
  
  
  
 SELECT i.[RMS CDW ID], count(*) 
  FROM [billhowe].[Seattle_Police_Department_Police_Report_Offense.csv] o
     , [billhowe].[table_Seattle_Police_Department_Police_Report_Incident.csv] i
 WHERE o.[CDW Incident ID] = i.[RMS CDW ID]
 GROUP BY i.[RMS CDW ID]
  HAVING count(*) = 0 -- will this work?
  
  
SELECT i.*
  FROM [billhowe].[table_Seattle_Police_Department_Police_Report_Incident.csv] i
 WHERE NOT EXISTS (
 SELECT * 
   FROM [billhowe].[Seattle_Police_Department_Police_Report_Offense.csv] o
  WHERE o.[CDW Incident ID] = i.[RMS CDW ID]
)


  
SELECT year, count(*)
  FROM [billhowe].[table_Seattle_Police_Department_Police_Report_Incident.csv] i
 WHERE NOT EXISTS (
 SELECT * 
   FROM [billhowe].[Seattle_Police_Department_Police_Report_Offense.csv] o
  WHERE o.[CDW Incident ID] = i.[RMS CDW ID]
) 
GROUP BY​  year 
  ORDER BY count(*) DESC​
  
  
  
  
  

# SQLAlteredStateProject
Final project for SQL/ETL 2023

Altered State is a formal wear alteration studio specializing in high-end alterations of women’s special occasion outfits such as wedding gowns, prom gowns, bridesmaid dresses, and cocktail dresses. The purpose of this database is to track formalwear projects through the fitting and alteration processes, with tracked data including client information, dates of fittings and of sewing work completed, employees involved, and billable hours for each project.

To set up database:
1)	Create new ‘C:\tmp\’ folder (if does not already exist)
2)	Download and save CSV and SQL files from GitHub to ‘C:\tmp\’ folder
3)	Run AlteredStateCreate: Creates database, table, user, login, and grants permissions for user
4)	Run Talend job: imports CSV files to database
5)	Run AlteredStateFixes: Changes erroneous datatypes for 2 tables
6)	Run AlteredStateFunction: Creates function
7)	Run AlteredStateProcedure: Creates stored procedure
8)	Run AlteredStateView: Creates view
9)	Run AlteredStateExamples: Example queries using view, function, procedure

To remove database:
1)	Run AlteredStateCleanUp: Removes database and user
2)	Delete CSV and SQL files from C:\tmp\ folder

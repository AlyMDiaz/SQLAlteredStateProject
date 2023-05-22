# SQLAlteredStateProject
Final project for SQL/ETL 2023

To set up database:
1)	Create new ‘C:\tmp\’ folder (if does not already exist)
2)	Download and save CSV and SQL files from GitHub to ‘C:\tmp\’ folder
3)	Run AlteredStateCreate: Creates database, table, user, login, and grants permissions for user
4)	Run Talend job: imports CSV files to database
5)	Run AlteredStateFixes: Changes erroneous datatypes for 2 tables
6)	Run AlteredStateFunction: Creates function, usage example
7)	Run AlteredStateView: Creates view, usage example
8)	Run AlteredStateProcedure: Creates stored procedure, usage example

To remove database:
1)	Run AlteredStateCleanUp: Removes database and user
2)	Delete CSV and SQL files from C:\tmp\ folder

This mock database has been created for Altered State, which is a formal wear alteration studio specializing in high-end alterations of women’s special occasion outfits such as wedding gowns, prom gowns, bridesmaid dresses, and cocktail dresses. The purpose of this database is to track formalwear projects through the fitting and alteration processes using data that includes client information, dates of fittings and of sewing work completed, employees involved, and billable hours and prices for each project.

First, we create the database AlteredState along with a user, login, and permissions to allow the user to interact with the database. Then we create the table Pricing and insert basic pricing data, which will later allow the user to calculate the price to charge for specific projects.

The remaining tables will contain data on Projects, Clients, and Employees. The ClientsInfo and EmployeeInfo tables include basic contact information for each, with each client and employee identified by a unique ClientID and EmployeeID, respectively. The ProjectInfo table identifies each project by a unique ProjectID, and contains key dates, project descriptors, and the ClientID for whom the project is being completed. The Fittings and SewingWork tables contain information on employees involved and the date on which work of each type was executed.

To obtain the data and create these tables, a Talend job imports several CSV files of mock data with details for 10 projects, 100 clients, and 15 employees. We then ALTER SewingWork and Fittings tables to correct the HoursBilled data type from REAL to DECIMAL in order to avoid calculation errors later.

Now we create a FUNCTION ProjectWorkHours, which uses JOIN and UNION ALL on ProjectFittings, ProjectSewingWork, and EmployeeInfo to return a table of work dates, full names of employees involved, hours billed, and work types for the user-input ProjectID. In the usage example, the function, along with an ORDER BY clause, produces a table of all work completed on the chosen project in chronological order, which is useful for answering client inquiries about the status of their projects.

We then create a VIEW ProjectsBilling to display a summary table of billing infomation for all projects. We JOIN ProjectFittings, ProjectSewingWork, and ProjectInfo, GROUP BY ProjectID, use SUM to calculate the total hours billed by work type, and use SELECT subqueries to calculate total cost by work type for each project. The usage example uses SELECT INTO to create a new table ProjectsTotalPrices, which includes the information returned in the ProjectsBilling view as well as the total price for each project and the date the price was calculated. This summary table could be useful for monitoring whether or not each project is on track to be completed for the price initially quoted (not listed in database), or with use of ORDER BY, to view highest or lowest-priced projects.

In order to enable the user to easily update the Pricing table with new prices and/or pricing tiers, we create STORED PROCEDURE UpdatePricingTier. The user enters the WorkCode, WorkType, and PricePerHour for the pricing tier they would like to update (if the tier already exists), or add (if the tier does not already exist). The procedure uses EXISTS within an IF ELSE statement to check if the given WorkCode is already in the table; if so, the PricePerHour for that pricing tier is updated. If the WorkCode is not already in the table, the values are inserted into the table as a new pricing tier. An additional stored procedure RemovePricingTier allows the user to DELETE unwanted entries.

--Create view to display billing information of all projects: hours billed for each type of work
--and price for work completed to date

USE AlteredState;
GO

CREATE VIEW ProjectsBilling
AS
	SELECT Info.ProjectID, SUM(Sew.HoursBilled) AS SewingHoursBilled, SUM(Fit.HoursBilled) AS FittingHoursBilled,
		   CAST(SUM(Sew.HoursBilled) * (SELECT PricePerHour FROM Pricing WHERE WorkCode = 'SEW') AS DECIMAL(6,2))
		   AS SewingPrice,
		   CAST(SUM(Fit.HoursBilled) * (SELECT PricePerHour FROM Pricing WHERE WorkCode = 'FIT') AS DECIMAL(6,2)) 
		   AS FittingPrice
	FROM ProjectInfo AS Info
	INNER JOIN ProjectSewingWork AS Sew ON Info.ProjectID = Sew.ProjectID
	INNER JOIN ProjectFittings AS Fit ON Sew.ProjectID = Fit.ProjectID
	GROUP BY Info.ProjectID;
GO

--Test billing view
SELECT * FROM ProjectsBilling;
GO

--USE CASE: What has been billed for each project to date for fitting and sewing,
--  and what is the total price for each project to date, ordered from highest to lowest-priced projects?
SELECT *, (FittingPrice + SewingPrice) AS TotalPrice, GETDATE() AS DateCalculated
INTO ProjectsTotalPrices
FROM ProjectsBilling;
GO

SELECT * FROM ProjectsTotalPrices
ORDER BY TotalPrice DESC;
GO
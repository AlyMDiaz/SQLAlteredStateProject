--Create view to display billing information of all projects: hours billed for each type of work
--and price for work completed to date

USE AlteredState;
GO

CREATE VIEW ProjectsBilling
AS
	SELECT Info.ProjectID, SUM(Sew.HoursBilled) AS SewingHoursBilled, SUM(Fit.HoursBilled) AS FittingHoursBilled,
		   CAST(SUM(Fit.HoursBilled) * (SELECT PricePerHour FROM Pricing WHERE WorkCode = 'FIT') AS DECIMAL(6,2)) 
		   AS FittingPrice, 
		   CAST(SUM(Sew.HoursBilled) * (SELECT PricePerHour FROM Pricing WHERE WorkCode = 'SEW') AS DECIMAL(6,2))
		   AS SewingPrice
	FROM ProjectInfo AS Info
	INNER JOIN ProjectSewingWork AS Sew ON Info.ProjectID = Sew.ProjectID
	INNER JOIN ProjectFittings AS Fit ON Sew.ProjectID = Fit.ProjectID
	GROUP BY Info.ProjectID;
GO

--Test billing view
SELECT * FROM ProjectsBilling;


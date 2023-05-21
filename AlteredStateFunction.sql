--Create function to show all instances of date of work, billable hours,
--work types, and names of employees who worked on a given project

USE AlteredState;
GO

CREATE FUNCTION ProjectWorkHours(@ProjectID INT)
RETURNS TABLE
AS
RETURN
	SELECT DateCompleted AS DateOfWork, CONCAT(Emp.FirstName, ' ', Emp.LastName) AS EmployeeName,
		HoursBilled, 'FIT' AS WorkCode
	FROM ProjectFittings AS Fit
	LEFT JOIN EmployeeInfo AS Emp ON Fit.EmployeeID = Emp.EmployeeID
	WHERE @ProjectID = ProjectID
	UNION ALL
	SELECT DateCompleted AS DateOfWork, CONCAT(Emp.FirstName, ' ', Emp.LastName) AS EmployeeName,
		HoursBilled, 'SEW' AS WorkCode
	FROM ProjectSewingWork AS Sew 
	LEFT JOIN EmployeeInfo AS Emp ON Sew.EmployeeID = Emp.EmployeeID
	WHERE @ProjectID = ProjectID;
GO

--Test run function: data for projectID #5
SELECT * FROM ProjectWorkHours(5);
--Example use cases and queries for view, function, stored procedure--
USE AlteredState;
GO

--View--
--What has been billed for each project to date for fitting and sewing,
--  and what is the total price for each project to date, ordered from highest to lowest-priced projects?
SELECT *, (FittingPrice + SewingPrice) AS TotalPrice, GETDATE() AS DateCalculated
INTO ProjectsTotalPrices
FROM ProjectsBilling;
GO

SELECT * FROM ProjectsTotalPrices
ORDER BY TotalPrice DESC;
GO


--Function--
--How can I see all instances of billable hours of each type (fitting and sewing)
--  that have accrued so far for projectID #10, in chronological order of the date work was performed?
SELECT * FROM ProjectWorkHours(10)
ORDER BY DateOfWork ASC;
GO


--Stored procedure--
--How can I update the pricing list with new prices for each pricing tier,
--  or add a new pricing tier if it does not already exist?

--Change SEW price from 50.00 to 60.00
EXEC UpdatePricingTier @WorkCode = 'SEW', @WorkType = 'Sewing', @PricePerHour = 60.00;
GO

SELECT * FROM Pricing;

--Update Pricing table with new work type: finishing work PAS (Pressing And Steaming)
EXEC UpdatePricingTier @WorkCode = 'PAS', @WorkType = 'Pressing/steaming', @PricePerHour = 20.00;
GO

SELECT * FROM Pricing;
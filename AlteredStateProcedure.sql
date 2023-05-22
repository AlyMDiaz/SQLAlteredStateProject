--1) Procedure to either update existing pricing tier or create new if tier does not already exist

USE AlteredState;
GO

CREATE PROCEDURE UpdatePricingTier
	@WorkCode VARCHAR(3), @WorkType VARCHAR(25), @PricePerHour DECIMAL(5,2)
AS
BEGIN
	IF EXISTS(SELECT * FROM Pricing WHERE WorkCode = @WorkCode)
		BEGIN
		UPDATE Pricing 
		SET PricePerHour = @PricePerHour 
		WHERE WorkCode = @WorkCode
		END
	ELSE
		BEGIN
		INSERT INTO Pricing (WorkCode, WorkType, PricePerHour)
		VALUES (@WorkCode, @WorkType, @PricePerHour)
		END
END;
GO

--USE CASE: How can I update the pricing list with new prices for each pricing tier,
--  or add a new pricing tier if it does not already exist?

--Original table
SELECT * FROM Pricing;

--Change SEW price from 50.00 to 60.00
EXEC UpdatePricingTier @WorkCode = 'SEW', @WorkType = 'Sewing', @PricePerHour = 60.00;
GO

SELECT * FROM Pricing;

--Update Pricing table with new work type: finishing work PAS (Pressing And Steaming)
EXEC UpdatePricingTier @WorkCode = 'PAS', @WorkType = 'Pressing/steaming', @PricePerHour = 20.00;
GO

SELECT * FROM Pricing;
GO

--2) Procedure to remove pricing tier from Pricing table
CREATE PROCEDURE RemovePricingTier @WorkCode VARCHAR(3)
AS
	DELETE FROM Pricing
	WHERE WorkCode = @WorkCode;
GO

--USE CASE: How do I delete an unused pricing tier so I can update the pricing system?

--Original table
SELECT * FROM Pricing;

--Delete work type PAS (Pressing And Steaming)
EXEC RemovePricingTier @WorkCode = 'PAS';

SELECT * FROM Pricing;
GO
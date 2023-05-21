--Procedure to either update existing pricing tier or create new if tier does not already exist

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
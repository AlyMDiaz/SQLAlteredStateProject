--Create database: sewing project tracking system for formalwear alterations business
CREATE DATABASE AlteredState;
GO


--Create login for use with Altered State database
USE AlteredState;
GO

CREATE LOGIN ASLogin
WITH PASSWORD = 'sqletl2023';
GO

--Create user for use with Altered State database
CREATE USER ASUser
FOR LOGIN ASLogin;

--Grant permissions to ASUser by assigning role db_owner
ALTER ROLE db_owner ADD MEMBER ASUser;


--Create Pricing table and insert data
USE AlteredState;
GO

CREATE TABLE Pricing(
	WorkCode VARCHAR(3) PRIMARY KEY,
	WorkType VARCHAR(25) NOT NULL,
	PricePerHour DECIMAL(5,2) NOT NULL
);
GO

INSERT INTO Pricing
VALUES ('SEW', 'Sewing', 50),
		('FIT', 'Fitting', 20);
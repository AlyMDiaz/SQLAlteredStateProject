--Alter datatype for HoursBilled from REAL to DECIMAL(3,1)
USE AlteredState;
GO

ALTER TABLE ProjectSewingWork
ALTER COLUMN HoursBilled DECIMAL(3,1) NOT NULL;
GO

ALTER TABLE ProjectFittings
ALTER COLUMN HoursBilled DECIMAL(3,1) NOT NULL;
GO
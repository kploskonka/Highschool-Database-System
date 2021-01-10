CREATE PROCEDURE restore_database
AS
EXEC disconnect
RESTORE DATABASE Szkola
    FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\Backup\Szkola.bak'
    WITH REPLACE
GO 

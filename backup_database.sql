CREATE PROCEDURE backup_database
AS
BACKUP DATABASE Szkola
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\Backup\Szkola.bak'
GO

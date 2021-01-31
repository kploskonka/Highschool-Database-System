CREATE PROCEDURE add_grade_to_student @AccountLogin NVARCHAR(50), @Password NVARCHAR(50), @StudentId INTEGER, @Grade FLOAT, @GradeType NVARCHAR(50)
AS
    DECLARE @TeacherId INT
    IF EXISTS(SELECT TeacherId FROM Teachers T JOIN Accounts A ON T.AccountId = A.AccountId WHERE A.Login = @AccountLogin AND A.Password = @Password) BEGIN
        SET @TeacherId = (SELECT TeacherId FROM Teachers T JOIN Accounts A ON T.AccountId = A.AccountId WHERE A.Login = @AccountLogin AND A.Password = @Password)
        BEGIN TRANSACTION
            INSERT INTO Grades VALUES
                (@TeacherId, @StudentId, @Grade, GETDATE(), @GradeType)
        COMMIT TRANSACTION
    END
    ELSE BEGIN
        PRINT N'Nie ma nauczyciela o takim haśle/loginie';
    END

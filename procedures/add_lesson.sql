CREATE PROCEDURE add_lesson @AccountLogin NVARCHAR(50), @Password NVARCHAR(50), @CourseName NVARCHAR(50), @ClassLabel NVARCHAR(2), @Date DATE, @Topic NVARCHAR(150)
AS
    IF EXISTS(SELECT TeacherId FROM Teachers T JOIN Accounts A ON T.AccountId = A.AccountId WHERE A.Login = @AccountLogin AND A.Password = @Password)
    AND EXISTS(SELECT CourseId FROM Courses WHERE CourseName = @CourseName)
    AND EXISTS(SELECT ClassId FROM Classes WHERE ClassLabel = @ClassLabel) 
    BEGIN
        DECLARE @CourseId INT, @ClassId INT
        SET @CourseId = (SELECT CourseId FROM Courses WHERE CourseName = @CourseName)
        SET @ClassId = (SELECT ClassId FROM Classes WHERE ClassLabel = @ClassLabel)

        BEGIN TRANSACTION
            INSERT INTO Lessons VALUES
                (@CourseId, @ClassId, @Date, @Topic)
        COMMIT TRANSACTION
    END
    ELSE BEGIN
        PRINT N'Co najmniej jeden z podanych parametrów jest nieprawidłowy';
    END

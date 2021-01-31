CREATE PROCEDURE move_student_to_class @AccountLogin NVARCHAR(50), @Password NVARCHAR(50), @StudentFirstName NVARCHAR(50), @StudentLastName NVARCHAR(50), @ClassLabel NVARCHAR(2)
AS
    IF EXISTS(SELECT TeacherId FROM Teachers T JOIN Accounts A ON T.AccountId = A.AccountId WHERE A.Login = @AccountLogin AND A.Password = @Password)
    AND EXISTS(SELECT StudentId FROM Students WHERE FirstName = @StudentFirstName AND LastName = @StudentLastName)
    AND EXISTS(SELECT ClassId FROM Classes WHERE ClassLabel = @ClassLabel) 
    BEGIN
        Declare @ClassId INT
        SET @ClassId = (SELECT ClassId FROM Classes WHERE ClassLabel = @ClassLabel)

        IF NOT EXISTS(SELECT StudentId FROM Students WHERE FirstName = @StudentFirstName AND LastName = @StudentLastName AND ClassId = @ClassID)
        BEGIN
            BEGIN TRANSACTION
                UPDATE Students
                SET ClassId = @ClassId
                WHERE FirstName = @StudentFirstName AND LastName = @StudentLastName
            COMMIT TRANSACTION
        END
        ELSE BEGIN
            PRINT N'Uczeń należy już do tej klasy!'
        END
    END
    ELSE BEGIN
        PRINT N'Co najmniej jeden z podanych parametrów jest nieprawidłowy';
    END

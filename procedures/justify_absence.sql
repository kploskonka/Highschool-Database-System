CREATE PROCEDURE justify_absence @AccountLogin nvarchar(30), @Password nvarchar(30), @AbsenceId INTEGER
AS
    IF EXISTS(SELECT AccountId FROM Accounts WHERE Login = @AccountLogin AND Password = @Password) BEGIN
        UPDATE Absences
            SET Status = 'Usprawiedliwione'
        WHERE AbsenceId = @AbsenceId
    END
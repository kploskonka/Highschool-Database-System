CREATE TRIGGER absences_for_note ON Absences
    AFTER INSERT AS
        IF ((SELECT Status FROM inserted) = 'Nieusprawiedliwione' AND
        (SELECT count(*) FROM Absences WHERE StudentId = (SELECT StudentId FROM inserted) AND Status = 'Nieusprawiedliwione')%5 = 0)
            BEGIN
                DECLARE @TeacherId INT
                DECLARE @ClassId INT
                SET @ClassId = (SELECT ClassId FROM Students WHERE Students.StudentId = (SELECT StudentID FROM inserted))
                SET @TeacherId = (SELECT HeadTeacherId FROM Classes WHERE Classes.ClassId = @ClassId)
                INSERT INTO Notes VALUES
                    (@TeacherId, (SELECT StudentId FROM inserted), GETDATE(), 'Piec nieusprawiedliwionych nieobecnosci')
            END

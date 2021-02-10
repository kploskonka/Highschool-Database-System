CREATE TRIGGER grade_for_activity ON Grades
    AFTER INSERT
        IF((SELECT Description FROM inserted) = '+' AND (SELECT count(*) FROM Grades WHERE StudentId = (SELECT StudentId FROM inserted)
                                            AND Description = '+')%5 = 0)
        BEGIN
            INSERT INTO Grades((SELECT StudentId from inserted),
                               (SELECT TeacherId from inserted),
                                5, GETDATE(), 'Aktywność')
        END

    END
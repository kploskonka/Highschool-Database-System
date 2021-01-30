CREATE TRIGGER grade_for_activity ON Grades
    AFTER INSERT
        if(inserted.Description = '+' AND (SELECT count(*) FROM Grades WHERE StudentId = inserted.StudentId 
                                            AND Description = '+')%5 = 0)
        BEGIN
            INSERT INTO Grades(inserted.TeacherId, inserted.StudentId, 5, 'Aktywność')
        END

    END
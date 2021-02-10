CREATE TRIGGER tr_grade_for_notes
ON Notes
AFTER INSERT
AS
    IF(SELECT count(*) FROM Notes WHERE StudentId = (SELECT StudentId FROM inserted)) >= 3
        BEGIN
            INSERT INTO Grades VALUES
                ((SELECT StudentId FROM inserted),
                (SELECT TeacherId FROM inserted),1, GETDATE(), 'Trzy uwagi')
        END
GO
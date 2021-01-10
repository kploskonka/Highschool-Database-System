CREATE FUNCTION get_overdue_exams (
    @TeacherId INT
)
RETURNS TABLE
AS
RETURN
    SELECT DISTINCT Classes.ClassLabel [Klasa], Courses.CourseName [Kurs], Exams.ExamDate [Data sprawdzianu]
    FROM Exams
    JOIN Classes ON Exams.ClassId = Classes.ClassId
    JOIN Courses ON Exams.CourseId = Courses.CourseId
    WHERE @TeacherId = Courses.TeacherId AND NOT EXISTS (SELECT * FROM ExamResults WHERE Exams.ExamId = ExamResults.ExamId)

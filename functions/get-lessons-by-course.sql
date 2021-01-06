CREATE FUNCTION get_lessons (
    @CourseId INT
)
RETURNS TABLE
AS 
RETURN
    SELECT
        L.ClassLabel,
        L.Date,
        L.Topic
    FROM Lessons L
    JOIN Courses C ON C.CourseId = L.CourseId
    WHERE @CourseId = C.CourseId
    ORDER BY L.Date DESC

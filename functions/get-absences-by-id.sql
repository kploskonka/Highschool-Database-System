CREATE FUNCTION get_absences (
    @StudentId INT 
)
RETURNS TABLE
AS 
RETURN
    SELECT
        S.FirstName,
        S.LastName,
        A.Date
    FROM Students S
    JOIN Absences A 
    ON A.StudentId = S.StudentId
    WHERE @StudentId = S.StudentId AND A.Status = 'Nieusprawiedliwione'
CREATE FUNCTION get_schedule (
    @ClassId
)
RETURNS TABLE
AS 
RETURN
    SELECT
        H.Hours [*],
        P.CourseName [Poniedziałek],
        T.CourseName [Wtorek],
        W.CourseName [Środa],
        TH.CourseName [Czwartek],
        F.CourseName [Piątek]
    FROM (SELECT FORMAT(Date,'HH:mm') Hours From Lessons
           WHERE ClassId = 1) H
		JOIN (SELECT C.CourseName, FORMAT(Date,'HH,mm') Hours 
			FROM Lessons L 
			JOIN Courses C ON C.CourseId = L.CourseId
			WHERE ClassId = @ClassId AND DATENAME(DW, L.Date) = 'Monday' ) P ON H.Hours = P.Hours
		JOIN (SELECT C.CourseName, FORMAT(Date,'HH,mm') Hours 
			FROM Lessons L 
			JOIN Courses C ON C.CourseId = L.CourseId
			WHERE ClassId = @ClassId AND DATENAME(DW, L.Date) = 'Tuesday' ) T ON H.Hours = T.Hours
		JOIN (SELECT C.CourseName, FORMAT(Date,'HH,mm') Hours 
			FROM Lessons L 
			JOIN Courses C ON C.CourseId = L.CourseId
			WHERE ClassId = @ClassId AND DATENAME(DW, L.Date) = 'Wednesday' ) W ON H.Hours = W.Hours
		JOIN (SELECT C.CourseName, FORMAT(Date,'HH,mm') Hours 
			FROM Lessons L 
			JOIN Courses C ON C.CourseId = L.CourseId
			WHERE ClassId = @ClassId AND DATENAME(DW, L.Date) = 'Thursday' ) TH ON H.Hours = TH.Hours
		JOIN (SELECT C.CourseName, FORMAT(Date,'HH,mm') Hours 
			FROM Lessons L 
			JOIN Courses C ON C.CourseId = L.CourseId
			WHERE ClassId = ClassId AND DATENAME(DW, L.Date) = 'Friday' ) F ON H.Hours = F.Hours

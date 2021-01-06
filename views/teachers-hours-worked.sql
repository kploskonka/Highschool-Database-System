--widok pokazuje ilość przepracowanych godzin lekcyjnych

CREATE VIEW hours_worked_per_teacher AS
    SELECT T.FirstName Imie, T.LastName Nazwisko, SUM(P.hours) [Przepracowane godziny] 
    FROM Teachers T 
    JOIN Courses C ON T.TeacherId = C.TeacherId
    JOIN (SELECT CourseId, COUNT(*) hours FROM Lessons GROUP BY CourseId) P ON P.CourseId = C.CourseId
    GROUP BY T.FirstName, T.LastName
    
--widok pokazuje liste studentow ktorzy otrzymaja swiadectwo z wyroznieniem (ich srednia ocen wynosi co najmniej 4.75)

CREATE VIEW students_with_honours AS
    SELECT S.FirstName [Imię], S.LastName [Nazwisko], ROUND(AVG(Grade), 2) [Średnia]
    FROM Grades G
    JOIN Students S ON S.StudentId = G.StudentId
    GROUP BY S.FirstName, S.LastName
    HAVING ROUND(AVG(Grade), 2) >= 4.75

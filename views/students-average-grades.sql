--widok pokazuje liste uczniow wraz z ich srednia ocen
--jezeli uczen nie ma ocen, kolumna ze srednia przyjmuje wartosc NULL

CREATE VIEW students_average_grades AS
    SELECT S.FirstName [Imię], S.LastName [Nazwisko], ROUND(AVG(Grade), 2) [Średnia]
    FROM Students S
    LEFT JOIN Grades G ON S.StudentId = G.StudentId
    GROUP BY S.FirstName, S.LastName

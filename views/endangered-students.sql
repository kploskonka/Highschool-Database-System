--pokazuje studentów z zagrożeniem wraz z przedmiotem z którego to zagrożenie występuje
--jako zagrożenie uznaje średnią poniżej 2.0

CREATE VIEW endangered_students AS
    SELECT S.FirstName [Imię], S.LastName [Nazwisko],C.CourseName [Przedmiot], ROUND(AVG(Mark),2) [srednia]
    FROM ExamResults ER
    JOIN Students S ON S.StudentId = ER.StudentId
    JOIN Exams E ON ER.ExamId = E.ExamId
    JOIN Courses C ON E.CourseId = C.CourseId
    GROUP BY S.FirstName, S.LastName, C.CourseName
    HAVING ROUND(AVG(Mark),2) < 2.0

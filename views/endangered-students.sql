--pokazuje studentów z zagrożeniem wraz z przedmiotem z którego to zagrożenie występuje
--jako zagrożenie uznaje średnią poniżej 2.0

CREATE VIEW endangered_students AS
    SELECT S.Name Imię, S.Surname Nazwisko,CourseName Przedmiot, ROUND(AVG(Mark),2) srednia
    FROM ExamResults ER
    JOIN Students S ON S.StudentId = ER.StudentId
    GROUP BY Imię, Nazwisko, CourseName
    HAVING ROUND(AVG(Mark),2) < 2.0

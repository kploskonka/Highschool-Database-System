CREATE FUNCTION get_overdue_books (
    @StudentId INT
)
RETURNS TABLE
AS
RETURN
    SELECT S.FirstName [Imię], S.LastName [Nazwisko], B.TakenDate [Data wypożyczenia], Books.Title [Tytuł]
    FROM Students S
    JOIN Borrows B ON S.StudentId = B.StudentId
    JOIN Books ON B.BookId = Books.BookId
    WHERE @StudentId = S.StudentId AND B.ReturnDate IS NULL
GO

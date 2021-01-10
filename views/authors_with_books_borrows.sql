--widok pokazuje liste autorow wraz z ich ksiazkami oraz liczba wypozyczen kazdej z ksiazek

CREATE VIEW authors_with_books_borrows AS
    SELECT A.Name [Imię], A.Surname [Nazwisko], B.Title [Tytuł], COUNT(Borrows.BookId) [Liczba wypożyczeń]
    FROM Borrows
    RIGHT JOIN Books B ON Borrows.BookID = B.BookId
    JOIN Authors A ON A.AuthorId = B.AuthorId
    GROUP BY A.Name, A.Surname, B.Title

CREATE PROCEDURE borrow_book @AccountLogin nvarchar(30), @Password nvarchar(30), @Title nvarchar(30)
AS
    IF EXISTS(SELECT AccountId FROM Accounts WHERE Login = @AccountLogin AND Password = @Password) BEGIN
            BEGIN TRANSACTION
                IF (SELECT Amount FROM Books WHERE Title = @Title) > 0 BEGIN
                    INSERT INTO Borrows VALUES
                        ((SELECT StudentId FROM Students S JOIN Accounts A ON S.AccountId = A.AccountId WHERE A.Login = @AccountLogin),
                        (SELECT BookId FROM Books WHERE Title = @Title),
                        GETDATE(),
						NULL
                        )
                    UPDATE Books
                        SET Amount = (SELECT Amount FROM Books WHERE Title = @Title) - 1
                        WHERE Title = @Title
                    END
                ELSE PRINT N'Nie wystarczająca liczba książek w bibliotece o podanym tytule';
            COMMIT TRANSACTION
    END
    ELSE BEGIN
            PRINT N'Nie ma użytkownika o takim haśle/loginie';
        END
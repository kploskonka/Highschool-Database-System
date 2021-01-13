CREATE PROCEDURE return_book @AccountLogin nvarchar(30), @Password nvarchar(30), @Title nvarchar(30)
AS
    IF EXISTS(SELECT AccountId FROM Accounts WHERE Login = @AccountLogin AND Password = @Password) BEGIN
            BEGIN TRANSACTION
					UPDATE Borrows
						SET ReturnDate = GETDATE()
					FROM Borrows B
					JOIN Students S ON B.StudentId = S.StudentId
					JOIN Accounts A ON A.AccountId = S.AccountId
					JOIN Books Bo on Bo.BookId = B.BookId
					WHERE @AccountLogin = A.Login AND Bo.Title = @Title

                    UPDATE Books
                        SET Amount = (SELECT Amount FROM Books WHERE Title = @Title) + 1
                        WHERE Title = @Title
            COMMIT TRANSACTION
    END
    ELSE BEGIN
            PRINT N'Nie ma użytkownika o takim haśle/loginie';
        END
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
                   
                    DECLARE @duration INT
		            DECLARE @penalty_amount  FLOAT 
		            DECLARE @TakenDate DATE
		            DECLARE @ReturnDate DATE

		            SELECT @TakenDate = (SELECT TakenDate FROM Borrows B
					JOIN Students S ON B.StudentId = S.StudentId
					JOIN Accounts A ON A.AccountId = S.AccountId
					JOIN Books Bo on Bo.BookId = B.BookId
					WHERE @AccountLogin = A.Login AND Bo.Title = @Title)

		            SET @ReturnDate = GETDATE()
		            SET @duration  = DATEDIFF(DAY, @TakenDate, @ReturnDate) 
		            SET @penalty_amount = (@duration - 28) * 2.7
		
		IF (@duration > 28)
			BEGIN
			PRINT N'Kara do zapłaty za opoźnienie: ' + CONVERT(varchar(100),@wynik)
			END
		ELSE
			BEGIN
			PRINT N'Książka oddana w terminie' 

                    UPDATE Books
                        SET Amount = (SELECT Amount FROM Books WHERE Title = @Title) + 1
                        WHERE Title = @Title
            COMMIT TRANSACTION
    END
    ELSE BEGIN
            PRINT N'Nie ma użytkownika o takim haśle/loginie';
        END
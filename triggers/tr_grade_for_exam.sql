CREATE TRIGGER grade_from_exam ON ExamResults
		FOR INSERT 
		AS 
			INSERT INTO Grades VALUES (inserted.StudentId, (
									SELECT T.TeacherId FROM Teachers 
									JOIN Coruses C ON C.TeacherId = T.TeacherId
									JOIN Exams E ON E.CourseId = C.CourseId
									JOIN ExamResults ER ON ER.ExamId = inserted.ExamId)
									)
			END

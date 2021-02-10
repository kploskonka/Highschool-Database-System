CREATE TRIGGER grade_from_exam ON ExamResults
		FOR INSERT 
		AS 
			INSERT INTO Grades VALUES ((SELECT StudentId FROM inserted), (
									SELECT T.TeacherId FROM Teachers 
									JOIN Courses C ON C.TeacherId = T.TeacherId
									JOIN Exams E ON E.CourseId = C.CourseId
									JOIN ExamResults ER ON ER.ExamId = (SELECT ExamId FROM inserted)),
									(SELECT Mark FROM inserted),
									(SELECT ResultDate from inserted),
									'Sprawdzian',							
									)
			END

CREATE TRIGGER exam_announcement ON Exams
    FOR INSERT, UPDATE AS
    IF ((SELECT ExamDate FROM inserted) < GETDATE() + 7)
        PRINT 'Sprawdzian zostal zapowiedziany za pozno. Najblizszy mozliwy termin sprawdzianu to: ' + CONVERT(VARCHAR(100), GETDATE() + 7)

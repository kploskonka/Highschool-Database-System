IF OBJECT_ID('ExamResults', 'U') IS NOT NULL DROP TABLE ExamResults 
IF OBJECT_ID('Lessons', 'U') IS NOT NULL DROP TABLE Lessons
IF OBJECT_ID('Notes', 'U') IS NOT NULL DROP TABLE Notes
IF OBJECT_ID('Absences', 'U') IS NOT NULL DROP TABLE Absences
IF OBJECT_ID('Meetings', 'U') IS NOT NULL DROP TABLE Meetings
IF OBJECT_ID('Exams', 'U') IS NOT NULL DROP TABLE Exams
IF OBJECT_ID('Borrows', 'U') IS NOT NULL DROP TABLE Borrows
IF OBJECT_ID('Books', 'U') IS NOT NULL DROP TABLE Books
IF OBJECT_ID('Authors', 'U') IS NOT NULL DROP TABLE Authors
IF OBJECT_ID('Parents', 'U') IS NOT NULL DROP TABLE Parents
IF OBJECT_ID('Grades', 'U') IS NOT NULL DROP TABLE Grades
IF OBJECT_ID('Students', 'U') IS NOT NULL DROP TABLE Students
IF OBJECT_ID('Classes', 'U') IS NOT NULL DROP TABLE Classes
IF OBJECT_ID('Courses', 'U') IS NOT NULL DROP TABLE Courses
IF OBJECT_ID('Teachers', 'U') IS NOT NULL DROP TABLE Teachers
IF OBJECT_ID('Accounts', 'U') IS NOT NULL DROP TABLE Accounts

GO

CREATE TABLE Accounts (
    AccountId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    Login NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Type NVARCHAR(1) NOT NULL,
    ActivationDate DATE NOT NULL
)
GO

CREATE TABLE Teachers (
    TeacherId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender NVARCHAR(1) NOT NULL,
    PhoneNumber VARCHAR(9) NOT NULL,
    AccountId INTEGER NOT NULL UNIQUE,
    CONSTRAINT TeachersFK FOREIGN KEY(AccountId) REFERENCES Accounts(AccountId)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
)
GO

CREATE TABLE Courses (
    CourseId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    CourseName NVARCHAR(50) NOT NULL,
    TeacherId INTEGER NOT NULL
    CONSTRAINT CoursesFK FOREIGN KEY(TeacherId) REFERENCES Teachers(TeacherId)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)
GO

CREATE TABLE Classes (
    ClassId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    ClassLabel NVARCHAR(2) NOT NULL,
    HeadTeacherId INTEGER NULL,
    Classroom INTEGER NOT NULL,
    CONSTRAINT HeadTeacherFK FOREIGN KEY(HeadTeacherId) REFERENCES Teachers(TeacherId) 
)
GO

CREATE TABLE Students (
    StudentId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender NVARCHAR(1) NOT NULL,
    PhoneNumber VARCHAR(9) NOT NULL,
    AccountId INTEGER NOT NULL UNIQUE,
    ClassId INTEGER NOT NULL
    CONSTRAINT StudentsFK FOREIGN KEY(AccountId) REFERENCES Accounts(AccountId)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    CONSTRAINT StudentClassFK FOREIGN KEY(ClassId) REFERENCES Classes(ClassId)
)
GO
CREATE TABLE Grades (
    GradeId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    StudentId INTEGER NOT NULL,
    TeacherId INTEGER NOT NULL,
    Grade FLOAT,
    Date DATE NOT NULL,
    Type NVARCHAR(50),
    CONSTRAINT StudentGradeFK FOREIGN KEY(StudentId) REFERENCES Students(StudentId),
    CONSTRAINT TeacherGradeFK FOREIGN KEY(TeacherId) REFERENCES Teachers(TeacherId),

)
GO
CREATE TABLE Parents (
    ParentId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    ChildId INTEGER NOT NULL,
    AccountId INTEGER NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender NVARCHAR(1) NOT NULL,
    PhoneNumber VARCHAR(9) NOT NULL,
    CONSTRAINT ParentFk FOREIGN KEY(AccountId) REFERENCES Accounts(AccountId),
    CONSTRAINT ChildFK FOREIGN KEY(ChildId) REFERENCES Students(StudentId)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)
GO

CREATE TABLE Meetings (
    ClassId INTEGER NOT NULL,
    MeetingDate DATE NOT NULL,
    Classroom INTEGER NOT NULL,
    Topic NVARCHAR(50) NOT NULL,
	CONSTRAINT MeetingPK PRIMARY KEY(ClassId, MeetingDate),
    CONSTRAINT MeetingFK FOREIGN KEY(ClassId) REFERENCES Classes(ClassId) 
)
GO

CREATE TABLE Exams (
    ExamId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    ClassId INTEGER NOT NULL,
    CourseId INTEGER NOT NULL,
    ExamDate DATE NOT NULL,
    CONSTRAINT ExamsFK FOREIGN KEY(ClassId) REFERENCES Classes(ClassId),
    CONSTRAINT CourseFK FOREIGN KEY(CourseId) REFERENCES Courses(CourseId)
)

GO
CREATE TABLE ExamResults (
    ExamId INTEGER NOT NULL,
    StudentId INTEGER NOT NULL,
    Mark FLOAT NOT NULL,
    ResultDate DATE NOT NULL,
	CONSTRAINT ExamResultsPK PRIMARY KEY(ExamId, StudentId),
    CONSTRAINT ExamsResultsFK FOREIGN KEY(ExamId) REFERENCES Exams(ExamId),
)
GO

CREATE TABLE Authors (
    AuthorId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    Surname NVARCHAR(50) NOT NULL,
)
GO

CREATE TABLE Books (
    BookId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    AuthorId INTEGER NOT NULL,
    Title NVARCHAR(50) NOT NULL,
    Amount INTEGER NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    CONSTRAINT AuthorFK FOREIGN KEY(AuthorId) REFERENCES Authors(AuthorId)
)
GO

CREATE TABLE Borrows (
    BorrowId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    StudentId INTEGER NOT NULL,
    BookId INTEGER NOT NULL,
    TakenDate DATE NOT NULL,
    ReturnDate DATE,
    CONSTRAINT BookFK FOREIGN KEY(BookId) REFERENCES Books(BookId),
    CONSTRAINT StudentBorrowsFK FOREIGN KEY(StudentId) REFERENCES Students(StudentId)
)
GO

CREATE TABLE Absences (
    AbsenceId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    StudentId INTEGER NOT NULL,
    Date DATE NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    CONSTRAINT AbsentStudentFK FOREIGN KEY(StudentId) REFERENCES Students(StudentId)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)
GO

CREATE TABLE Notes (
    NoteId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    TeacherId INTEGER NOT NULL,
    StudentId INTEGER NOT NULL,
    Date DATE NOT NULL,
    Description NVARCHAR(150) NOT NULL,
    CONSTRAINT NotingTeacherId FOREIGN KEY(TeacherId) REFERENCES Teachers(TeacherId),
    CONSTRAINT NotedStudentId FOREIGN KEY(StudentId) REFERENCES Students(StudentId)
)
GO

CREATE TABLE Lessons (
    LessonId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    CourseId INTEGER NOT NULL,
    ClassId INTEGER NOT NULL,
    Date DATETIME NOT NULL,
    Topic NVARCHAR(150) NOT NULL,
    CONSTRAINT LessonCourseId FOREIGN KEY(CourseId) REFERENCES Courses(CourseId),
    CONSTRAINT LessonClassId FOREIGN KEY(ClassId) REFERENCES Classes(ClassId)
)
GO

ALTER TABLE Accounts
ADD CONSTRAINT is_password_valid CHECK(LEN(Password) > 7)

ALTER TABLE Students
ADD CONSTRAINT is_student_phone_valid CHECK(ISNUMERIC(PhoneNumber) = 1 AND LEN(PhoneNumber) = 9)

ALTER TABLE Teachers
ADD CONSTRAINT is_teacher_phone_valid CHECK(ISNUMERIC(PhoneNumber) = 1 AND LEN(PhoneNumber) = 9)

ALTER TABLE ExamResults
ADD CONSTRAINT is_mark_valid CHECK(Mark BETWEEN 1 AND 6)

GO

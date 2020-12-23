DROP TABLE Students
DROP TABLE Teachers
DROP TABLE Accounts

CREATE TABLE Accounts (
    AccountId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    Login NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Type NVARCHAR(1) NOT NULL,
    ActivationDate DATE NOT NULL
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
    CONSTRAINT StudentsFK FOREIGN KEY (AccountId) REFERENCES Accounts(AccountId)
)
GO

CREATE TABLE Teachers (
    TeacherId INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender NVARCHAR(1) NOT NULL,
    PhoneNumber VARCHAR(9) NOT NULL,
    AccountID INTEGER NOT NULL UNIQUE,
    CONSTRAINT TeachersFK FOREIGN KEY (AccountID) REFERENCES Accounts(AccountId) 
)
GO

ALTER TABLE Accounts
ADD CONSTRAINT is_password_valid CHECK(LEN(Password) > 7)

ALTER TABLE Students
ADD CONSTRAINT is_student_phone_valid CHECK(ISNUMERIC(PhoneNumber) = 1 AND LEN(PhoneNumber) = 9)

ALTER TABLE Teachers
ADD CONSTRAINT is_teacher_phone_valid CHECK(ISNUMERIC(PhoneNumber) = 1 AND LEN(PhoneNumber) = 9)

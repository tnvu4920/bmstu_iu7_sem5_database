-- Рубежный контроль 2
-- Вариант 3

USE MASTER 
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'RK2')
DROP DATABASE RK2
GO

CREATE DATABASE RK2
GO

USE RK2

CREATE TABLE Teacher (
    ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Degree INT NOT NULL,
    Position NVARCHAR(100),
    Kafedra INT NOT NULL,
)
GO

INSERT INTO Teacher(Name, Degree, Position, Kafedra) values
('Hazard', '2', '2', '1'),
('Mount', '3', '3', '5'),
('Drogba', '5', '3', '5'),
('Lampard', '4', '5', '6'),
('Havertz', '3', '4', '6'),
('Cech', '5', '6', '7'),
('Terry', '1', '8', '7'),
('Cole', '1', '2', '7'),
('Werner', '1', '2', '4'),
('Sterling', '1', '5', '4'),
('Kante', '1', '2', '9');

CREATE TABLE Subject(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(100) NOT NULL,
	NumberOfHours INT,
	Semester INT,
	Rating INT
)
GO

INSERT INTO Subject(Name, NumberOfHours, Semester, Rating) values
('Math', '108', '1', '8'),
('Math', '156', '3', '9'),
('Physics', '108', '2', '10'),
('Physics', '108', '3', '7'),
('Information', '56', '1', '5'),
('Math', '108', '4', '6'),
('Language', '108', '2', '7'),
('Languege', '108', '3', '8'),
('Biology', '256', '2', '9'),
('History', '108', '3', '8'),
('English', '108', '5', '6'),
('English', '108', '6', '10');

CREATE TABLE Kafedra
(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(100) NOT NULL,
	Description NVARCHAR(100),
)
GO

INSERT INTO Kafedra(Name, Description) values
('IU1', 'This is IU1'),
('IU2', 'This is IU2'),
('IU3', 'This is IU3'),
('IU4', 'This is IU4'),
('IU5', 'This is IU5'),
('IU6', 'This is IU6'),
('IU7', 'This is IU7'),
('IU8', 'This is IU8'),
('IU9', 'This is IU9'),
('FN1', 'This is FN1'),
('FN2', 'This is FN2');


ALTER TABLE dbo.Teacher ADD CONSTRAINT 
    FK_Kafedra FOREIGN KEY(Kafedra) REFERENCES dbo.Kafedra(ID)

CREATE TABLE TeacherSubject
(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDTeacher INT,
	IDSubject INT
)
GO

INSERT INTO TeacherSubject(IDTeacher, IDSubject) values
('1', '1'),
('1', '2'),
('2', '3'),
('2', '4'),
('3', '5'),
('4', '5'),
('5', '5'),
('5', '6'),
('6', '6'),
('7', '1'),
('8', '1'),
('9', '5'),
('9', '1'),
('10', '10');

ALTER TABLE dbo.TeacherSubject ADD CONSTRAINT
	FK_Teacher FOREIGN KEY(IDTeacher) REFERENCES dbo.Teacher(ID)

ALTER TABLE dbo.TeacherSubject ADD CONSTRAINT
	FK_Subject FOREIGN KEY(IDSubject) REFERENCES dbo.Subject(ID)
GO

/*
возвращает предметы, у которых количество часов больше, чем количество часов по любой математике
*/
SELECT *
FROM Subject S
WHERE S.NumberOfHours > SOME(SELECT NumberOfHours
					 FROM Subject
					 WHERE Name = 'Math')
                     
/*
Number of teachers in Kafedra
*/

SELECT K.ID, K.Name, TMP.SUM
FROM Kafedra K JOIN
(SELECT K.ID AS ID, SUM(K.ID) AS SUM 
FROM Teacher T JOIN Kafedra K ON T.Kafedra = K.ID
GROUP BY K.ID) TMP
ON K.ID = TMP.ID

/*
Select all Teachers From IU
*/
IF OBJECT_ID('tempdb..#TmpTab') IS NOT NULL
	DROP TABLE #TmpTab
GO

CREATE TABLE #TmpTab (
    Name NVARCHAR(100),
    Kafedra NVARCHAR(100)
);
GO

INSERT INTO #TmpTab
SELECT T.Name, K.Name
FROM Teacher T, Kafedra K
WHERE T.Kafedra = K.ID AND K.Name LIKE 'IU%'
GO

SELECT *
FROM #TmpTab
GO


-- TASK 3

CREATE OR REPLACE PROCEDURE deleteDouble(tablename varchar)
AS
$$
BEGIN
    EXECUTE 'create table new_table as select distinct * 
                                        from ' || tablename;
    EXECUTE 'drop table ' || tablename;
    EXECUTE 'alter table new_table rename to ' || tablename;
END
$$
LANGUAGE plpgsql;
CALL delete_double('Teacher');


/* Рубежный контроль №2. Вариант 3 */

USE master
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'RK2')
DROP DATABASE RK2
GO

CREATE DATABASE RK2
GO

USE RK2

CREATE TABLE Teacher
(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(100) NOT NULL,
	Degree INT NOT NULL,
	Position NVARCHAR(100),
	Kafedra INT NOT NULL,
)
GO

CREATE TABLE Sub
(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(100) NOT NULL,
	Hours INT,
	Semester INT,
	Rating INT
)
GO

CREATE TABLE Kafedra
(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(100) NOT NULL,
	Infor NVARCHAR(100),

)
GO

ALTER TABLE dbo.Teacher ADD CONSTRAINT
	FK_Kafedra FOREIGN KEY(Kafedra) REFERENCES  dbo.Kafedra(ID)


CREATE TABLE TS
(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	IDTeacher INT,
	IDSub INT

)
GO

ALTER TABLE dbo.TS ADD CONSTRAINT
	FK_Teacher FOREIGN KEY(IDTeacher) REFERENCES  dbo.Teacher(ID)

ALTER TABLE dbo.TS ADD CONSTRAINT
	FK_Sub FOREIGN KEY(IDSub) REFERENCES  dbo.Sub(ID)
GO


BULK INSERT dbo.Teacher
FROM '/Teacher.TXT'
WITH (FIRSTROW = 2,FIELDTERMINATOR = '|', ROWTERMINATOR ='\n');
GO

BULK INSERT dbo.Sub
FROM '/Sub.TXT'
WITH (FIRSTROW = 2,FIELDTERMINATOR = '|', ROWTERMINATOR ='\n');
GO

BULK INSERT dbo.Kafedra
FROM '/Kafedra.TXT'
WITH (FIRSTROW = 2,FIELDTERMINATOR = '|', ROWTERMINATOR ='\n');
GO

BULK INSERT dbo.TS
FROM '/TS.TXT'
WITH (FIRSTROW = 2,FIELDTERMINATOR = '|', ROWTERMINATOR ='\n');
GO

/*
возвращает предметы, у которых количество часов больше, чем количество часов по любой математике
*/
SELECT *
FROM Sub S
WHERE S.Hours < SOME(SELECT Hours
					 FROM Sub
					 WHERE Name = 'Math')
                     
/*
NUmber Teacher in Kafedra
*/

SELECT K.ID, K.Name, TMP.SUM
FROM Kafedra K JOIN
(SELECT K.ID AS ID, SUM(K.ID) AS SUM 
FROM Teacher T JOIN Kafedra K ON T.Kafedra = K.ID
GROUP BY K.ID) TMP
ON K.ID = TMP.ID

/*
Select All Teacher From IU
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

CREATE PROCEDURE ShowIndex @TableName NVARCHAR(50)
AS
BEGIN
	DECLARE @Name AS NVARCHAR(100);
	SET @Name = 'RK2.dbo.' + @TableName;
	SELECT *
	FROM sys.indexes
	WHERE object_id = OBJECT_ID(@Name);
END
GO

EXEC ShowIndex 'Teacher'


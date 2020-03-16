IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TableA')
BEGIN
    DROP TABLE [dbo].[TableA]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TableB')
BEGIN
    DROP TABLE [dbo].[TableB]
END
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TableMAP')
BEGIN
    DROP TABLE [dbo].[TableMAP]
END

CREATE TABLE TableA (
dimension_1 VARCHAR(1),
dimension_2 VARCHAR(1),
dimension_3 VARCHAR(1),
measure_1 INT
)
INSERT INTO TableA (dimension_1, dimension_2, dimension_3, measure_1)
VALUES ('a', 'I', 'K', 1),
	   ('a', 'J', 'L', 7),
	   ('b', 'I', 'M', 2),
	   ('c', 'J', 'N', 5)

CREATE TABLE TableB (
dimension_1 VARCHAR(1),
dimension_2 VARCHAR(1),
measure_2 INT
)
INSERT INTO TableB (dimension_1, dimension_2, measure_2)
VALUES ('a', 'J', 7),
	   ('b', 'J', 10),
	   ('d', 'J', 4)

CREATE TABLE TableMAP (
dimension_1 VARCHAR(1),
correct_dimension_2 VARCHAR(1)
)
INSERT INTO TableMAP (dimension_1, correct_dimension_2)
VALUES ('a', 'W'),
	   ('b', 'X'),
	   ('c', 'Y'),
	   ('d', 'Z')

;WITH TASK AS(
SELECT
	A.[dimension_1],
	MAP.[correct_dimension_2] [dimension_2],
	A.[measure_1],
	0 [measure_2]
FROM [dbo].[TableA] A 
JOIN [dbo].[TableMAP] MAP ON A.[dimension_1]=MAP.[dimension_1]

UNION

SELECT
	B.[dimension_1],
	MAP.[correct_dimension_2] [dimension_2],
	0 [measure_1],
	B.[measure_2]
FROM [dbo].[TableB] B
JOIN [dbo].[TableMAP] MAP ON B.[dimension_1]=MAP.[dimension_1]
)
SELECT * FROM TASK
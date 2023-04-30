-- 1. Să se creeze baza de date "Universitate" cu collate-ul SQL_Romanian_CP1250_CS_AS
CREATE DATABASE Universitate COLLATE SQL_Romanian_CP1250_CS_AS;
GO

USE Universitate;
GO

-- 2. Să se creeze tabelele din baza "Universitate".
-- 3. Să se realizeze integritatea bazei de date prin crearea de constrângeri pentru cele 4 relații prezentate.
CREATE TABLE Orase (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Denumire NVARCHAR(255) NOT NULL
	CONSTRAINT UQ_Orase_Denumire UNIQUE (Denumire)
);
GO

CREATE TABLE Grupa (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Denumire NVARCHAR(255) NOT NULL
	CONSTRAINT UQ_Grupa_Denumire UNIQUE (Denumire)
);
GO

CREATE TABLE Student (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    GrupaDenumire NVARCHAR(255) NOT NULL,
    OrasDenumire NVARCHAR(255) NOT NULL,
    Nume NVARCHAR(255) NOT NULL,
    Prenume NVARCHAR(255) NOT NULL,
    CONSTRAINT FK_Student_Grupa FOREIGN KEY (GrupaDenumire)
        REFERENCES Grupa(Denumire),
    CONSTRAINT FK_Student_Orase FOREIGN KEY (OrasDenumire)
        REFERENCES Orase(Denumire)
);
GO

CREATE TABLE Materie (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nume NVARCHAR(255) NOT NULL,
	CONSTRAINT UQ_Materie_Nume UNIQUE (Nume)
);
GO

CREATE TABLE Note (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    StudentId INT NOT NULL,
    MaterieDenumire NVARCHAR(255) NOT NULL,
    NotaObtinuta FLOAT NOT NULL,
    CONSTRAINT FK_Note_Student FOREIGN KEY (StudentId)
        REFERENCES Student(Id),
);
GO


-- 4. Să se introducă în baza de date următoarele informații:

BEGIN TRANSACTION OraseAdaugate

INSERT INTO Orase (Denumire)
VALUES 
    ('Ploiești'),
    ('Pitești'),
    ('Constanța'),
    ('București'),
    ('Călărași'),
    ('Iași'),
    ('Slobozia'),
    ('Sibiu'),
    ('Cluj-Napoca'),
    ('Brașov'),
    ('Fetești'),
    ('Satu-Mare'),
    ('Oradea'),
    ('Cernavodă')

COMMIT TRANSACTION OraseAdaugate

BEGIN TRANSACTION GrupeAdaugate

INSERT INTO Grupa(Denumire)
VALUES 
    ('A'),
    ('B'),
    ('C'),
    ('D')

COMMIT TRANSACTION GrupeAdaugate

BEGIN TRANSACTION MateriiAdaugate

INSERT INTO Materie (Nume)
VALUES 
    ('Geometrie'),
    ('Algebră'),
    ('Statistică'),
    ('Trigonometrie'),
    ('Muzică'),
    ('Desen'),
    ('Sport'),
    ('Filozofie'),
    ('Literatură'),
    ('Engleză'),
    ('Fizică'),
    ('Franceză')

COMMIT TRANSACTION MateriiAdaugate	 

BEGIN TRANSACTION StudentiAdaugati

INSERT INTO Student (GrupaDenumire, OrasDenumire, Nume, Prenume)
VALUES 
    ('A', 'Ploiești', 'Popescu', 'Mihai'), 
    ('A', 'București', 'Ionescu', 'Andrei'), 
    ('A', 'Constanța', 'Ionescu', 'Andreea'), 
    ('A', 'Călărași', 'Dinu', 'Nicolae'), 
    ('B', 'Cernavodă', 'Constantin', 'Ionuț'), 
    ('B', 'Iași', 'Simion', 'Mihai'), 
    ('B', 'Cernavodă', 'Constantinescu', 'Ana-Maria'),
    ('B', 'Iași', 'Amăriuței', 'Eugen'),
    ('B', 'Sibiu', 'Știrbei', 'Alexandru'),
    ('C', 'Brașov', 'Dumitru', 'Angela'),
    ('C', 'Oradea', 'Dumitrache', 'Ion'),
    ('C', 'Oradea', 'Șerban', 'Maria-Magdalena'),
    ('C', 'Cluj-Napoca', 'Chelaru', 'Violeta'),
    ('C', 'Cluj-Napoca', 'Sandu', 'Daniel'),
    ('D', 'Satu-Mare', 'Marinache', 'Alin'),
    ('D', 'Satu-Mare', 'Panait', 'Vasile'),
    ('D', 'Fetești', 'Popa', 'Mirela'),
    ('D', 'Fetești', 'Dascălu', 'Daniel Ștefan'),
    ('D', 'Fetești', 'Georgescu', 'Marian'),
    ('D', 'Ploiești', 'Dumitrașcu', 'Marius'),
    ('D', 'București', 'Dinu', 'Ionela')

COMMIT TRANSACTION StudentiAdaugati


BEGIN TRANSACTION NoteAdaugate

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (1, 'Chimie', 7), (1, 'Fizică', 6), (1, 'Franceză', 7)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (1, 'Fizică', 4)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (2, 'Algebră', 5), (2, 'Statistică', 9), (2, 'Muzică', 6);

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (2, 'Fizică', 9), (2, 'Chimie', 10), (2, 'Sport', 8)


INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (3, 'Sport', 1), (3, 'Literatură', 2), (3, 'Franceză', 9)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (3, 'Sport', 5), (3, 'Literatură', 4), (3, 'Literatură', 7)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (4, 'Chimie', 8),(4, 'Algebră', 9),(4, 'Statistică', 10)


INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (5, 'Algebră', 10), (5, 'Sport', 10), (5, 'Fizică', 8)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (6, 'Fizică', 8), (6, 'Algebră', 8), (6, 'Sport', 3)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES(6, 'Sport', 1)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES(6, 'Sport', 1)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (7, 'Sport', 5), (7, 'Fizică', 8), (7, 'Algebră', 2)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (7, 'Algebră', 5)


INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (8, 'Algebră', 6), (8, 'Sport', 10), (8, 'Franceză', 7)


INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (9, 'Chimie', 9),(9, 'Fizică', 2),(9, 'Sport', 1)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES(9, 'Fizică', 5), (9, 'Sport', 6)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (10, 'Desen', 9),(10, 'Filozofie', 7),(10, 'Engleză', 9)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (11, 'Desen', 8), (11, 'Statistică', 2), (11, 'Filozofie', 7)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (11, 'Statistică', 6)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (12, 'Engleză', 7), (12, 'Filozofie', 4), (12, 'Desen', 8)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (12, 'Filozofie', 4), (12, 'Filozofie', 4)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (13, 'Franceză', 1), (13, 'Desen', 3), (13, 'Engleză', 10)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES(13, 'Franceză', 6), (13, 'Desen', 1)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (14, 'Desen', 3), (14, 'Filozofie', 9), (14, 'Franceză', 4)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES(14, 'Desen', 8), (14, 'Franceză', 5)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta) 
VALUES (15, 'Desen', 7), (15, 'Fizică', 8), (15, 'Engleză', 5)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta) 
VALUES (16, 'Sport', 5), (16, 'Desen', 7), (16, 'Statistică', 10) 
	   
INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (16, 'Fizică', 8), (16, 'Literatură', 6), (16, 'Filozofie', 9)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta) 
VALUES (17, 'Engleză', 3), (17, 'Filozofie', 6), (17, 'Desen', 6)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES (17, 'Engleză', 6)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta) 
VALUES (18, 'Fizică', 4), (18, 'Franceză', 9), (18, 'Statistică', 10)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES(18, 'Fizică', 2)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES(18, 'Fizică', 1)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES(18, 'Fizică', 3)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES(18, 'Fizică', 5)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta) 
VALUES (19, 'Franceză', 10), (19, 'Engleză', 10), (19, 'Fizică', 8)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta) 
VALUES (20, 'Sport', 5), (20, 'Algebră', 6), (20, 'Chimie', 2)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta)
VALUES(20, 'Chimie', 5)

INSERT INTO Note (StudentId, MaterieDenumire, NotaObtinuta) 
VALUES (21, 'Muzică', 9), (21, 'Literatură', 8), (21, 'Sport', 8)

COMMIT TRANSACTION NoteAdaugate


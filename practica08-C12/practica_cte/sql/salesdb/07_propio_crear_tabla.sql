USE SalesDB;
GO

-- Ejemplo propio: árbol de géneros musicales (autorreferencia: PadreID apunta a GeneroID)
IF OBJECT_ID('dbo.Generos', 'U') IS NOT NULL DROP TABLE dbo.Generos;
GO

CREATE TABLE dbo.Generos
(
    GeneroID INT          NOT NULL PRIMARY KEY,
    Nombre   VARCHAR(50)  NOT NULL,
    PadreID  INT          NULL REFERENCES dbo.Generos(GeneroID)
);
GO

INSERT INTO dbo.Generos (GeneroID, Nombre, PadreID) VALUES
(1,  'Música',           NULL),
(2,  'Electrónica',      1),
(3,  'Rock',             1),
(4,  'Hip hop',          1),
(5,  'House',            2),
(6,  'Techno',           2),
(7,  'Deep House',       5),
(8,  'Tech House',       5),
(9,  'Rock alternativo', 3),
(10, 'Indie',            9),
(11, 'Trap',             4);
GO

SELECT * FROM dbo.Generos ORDER BY GeneroID;

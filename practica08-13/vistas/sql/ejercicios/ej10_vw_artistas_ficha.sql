USE SonoraDB;
GO

-- a)
CREATE OR ALTER VIEW dbo.vw_artistas_ficha
WITH SCHEMABINDING
AS
SELECT a.artista_id,
       a.nombre AS artista,
       a.pais,
       g.nombre AS genero
FROM dbo.artistas AS a
JOIN dbo.generos  AS g ON g.genero_id = a.genero_id;
GO

SELECT artista, pais, genero
FROM dbo.vw_artistas_ficha
WHERE pais = 'ES'
ORDER BY artista;
GO

-- b) Falla con Msg 5074 y 4922
ALTER TABLE dbo.artistas ALTER COLUMN nombre nvarchar(150) NOT NULL;
GO

-- c)
SELECT referencing_schema_name, referencing_entity_name
FROM sys.dm_sql_referencing_entities(N'dbo.artistas', N'OBJECT')
ORDER BY referencing_entity_name;

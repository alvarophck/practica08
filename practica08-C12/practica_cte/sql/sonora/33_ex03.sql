USE SonoraDB;
GO

-- Ejercicio 3. Artistas sin ninguna canción publicada (NOT EXISTS)
SELECT a.nombre
FROM dbo.artistas AS a
WHERE NOT EXISTS (SELECT 1
                  FROM dbo.canciones AS c
                  WHERE c.artista_id = a.artista_id);

USE SonoraDB;
GO

-- Ejemplo 6. EXISTS
SELECT a.nombre, a.pais
FROM dbo.artistas AS a
WHERE EXISTS (
    SELECT 1
    FROM dbo.canciones AS c
    WHERE c.artista_id = a.artista_id
      AND c.fecha_lanzamiento >= '2026-01-01'
)
ORDER BY a.nombre;

USE SonoraDB;
GO

-- Ejercicio 11. Canciones de Urbano y de todos sus subgéneros
WITH subgeneros AS (
    SELECT genero_id, nombre
    FROM dbo.generos
    WHERE nombre = N'Urbano'

    UNION ALL

    SELECT g.genero_id, g.nombre
    FROM dbo.generos AS g
    JOIN subgeneros AS s ON g.genero_padre_id = s.genero_id
)
SELECT c.titulo, s.nombre AS genero, a.nombre AS artista
FROM subgeneros AS s
JOIN dbo.canciones AS c ON c.genero_id = s.genero_id
JOIN dbo.artistas  AS a ON a.artista_id = c.artista_id
ORDER BY s.nombre, c.titulo;

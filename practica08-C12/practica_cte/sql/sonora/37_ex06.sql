USE SonoraDB;
GO

-- Ejercicio 6. Reproducciones totales de las canciones de Nébula y DJ Coral
SELECT c.titulo,
       (SELECT COUNT(*)
        FROM dbo.reproducciones AS r
        WHERE r.cancion_id = c.cancion_id) AS total_reproducciones
FROM dbo.canciones AS c
WHERE c.artista_id IN (SELECT artista_id
                       FROM dbo.artistas
                       WHERE nombre IN (N'Nébula', N'DJ Coral'))
ORDER BY total_reproducciones DESC, c.titulo;

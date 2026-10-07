USE SonoraDB;
GO

-- Ejercicio 1. Canciones más largas que la más larga de Luna Roja
SELECT titulo, duracion_seg
FROM dbo.canciones
WHERE duracion_seg > (SELECT MAX(c.duracion_seg)
                      FROM dbo.canciones AS c
                      JOIN dbo.artistas AS a ON a.artista_id = c.artista_id
                      WHERE a.nombre = N'Luna Roja')
ORDER BY duracion_seg DESC;

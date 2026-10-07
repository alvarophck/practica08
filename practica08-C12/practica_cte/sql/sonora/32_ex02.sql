USE SonoraDB;
GO

-- Ejercicio 2. Canciones reproducidas desde un Smart TV (subconsulta de lista)
SELECT titulo
FROM dbo.canciones
WHERE cancion_id IN (SELECT cancion_id
                     FROM dbo.reproducciones
                     WHERE dispositivo = N'Smart TV')
ORDER BY titulo;

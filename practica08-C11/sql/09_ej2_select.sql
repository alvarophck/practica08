USE SonoraDB;
GO

-- Ejemplo 2. Subconsulta escalar en SELECT
SELECT titulo,
       duracion_seg,
       (SELECT AVG(duracion_seg) FROM dbo.canciones) AS media_catalogo,
       duracion_seg - (SELECT AVG(duracion_seg) FROM dbo.canciones) AS diferencia
FROM dbo.canciones
WHERE artista_id = 1;

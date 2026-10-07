USE SonoraDB;
GO

-- Ejemplo 10. Equivalente con tres tablas derivadas anidadas
SELECT genero, reproducciones, minutos
FROM (SELECT genero,
             COUNT(*) AS reproducciones,
             CAST(SUM(segundos_escuchados) / 60.0 AS decimal(6,1)) AS minutos
      FROM (SELECT l.segundos_escuchados, g.nombre AS genero
            FROM (SELECT cancion_id, segundos_escuchados
                  FROM dbo.reproducciones
                  WHERE tipo_contenido = N'Canción'
                    AND segundos_escuchados >= 30) AS l
            JOIN dbo.canciones AS c ON c.cancion_id = l.cancion_id
            JOIN dbo.generos   AS g ON g.genero_id  = c.genero_id) AS enriquecidas
      GROUP BY genero) AS agregadas
ORDER BY minutos DESC, genero;

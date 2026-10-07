USE SonoraDB;
GO

-- Ejemplo 9. Equivalente con tabla derivada
SELECT TOP (3) c.titulo, COUNT(*) AS reproducciones_validas
FROM (SELECT cancion_id
      FROM dbo.reproducciones
      WHERE tipo_contenido = N'Canción'
        AND segundos_escuchados >= 30) AS v
JOIN dbo.canciones AS c ON c.cancion_id = v.cancion_id
GROUP BY c.titulo
ORDER BY reproducciones_validas DESC, c.titulo;

USE SonoraDB;
GO

-- Ejemplo 9. CTE simple: top 3 canciones con más reproducciones válidas
WITH validas AS (
    SELECT cancion_id
    FROM dbo.reproducciones
    WHERE tipo_contenido = N'Canción'
      AND segundos_escuchados >= 30
)
SELECT TOP (3) c.titulo, COUNT(*) AS reproducciones_validas
FROM validas AS v
JOIN dbo.canciones AS c ON c.cancion_id = v.cancion_id
GROUP BY c.titulo
ORDER BY reproducciones_validas DESC, c.titulo;

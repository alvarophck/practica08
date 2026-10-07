USE SonoraDB;
GO

-- Ejemplo 12. CTE recursiva con agregación: reproducciones válidas por género principal
WITH arbol AS (
    SELECT genero_id, genero_id AS raiz_id
    FROM dbo.generos
    WHERE genero_padre_id = (SELECT genero_id FROM dbo.generos WHERE genero_padre_id IS NULL)

    UNION ALL

    SELECT g.genero_id, a.raiz_id
    FROM dbo.generos AS g
    JOIN arbol AS a ON g.genero_padre_id = a.genero_id
)
SELECT gr.nombre AS genero_principal,
       COUNT(r.reproduccion_id) AS reproducciones_validas
FROM arbol AS a
JOIN dbo.generos AS gr ON gr.genero_id = a.raiz_id
LEFT JOIN dbo.canciones AS c ON c.genero_id = a.genero_id
LEFT JOIN dbo.reproducciones AS r
       ON r.cancion_id = c.cancion_id
      AND r.tipo_contenido = N'Canción'
      AND r.segundos_escuchados >= 30
GROUP BY gr.nombre
ORDER BY reproducciones_validas DESC;

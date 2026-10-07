USE SonoraDB;
GO

-- Ejemplo 11. Alternativa sin recursión: profundidad fija (4 niveles) con autouniones
-- Solo sirve si se conoce la profundidad máxima; una CTE recursiva no tiene ese límite
SELECT genero_id, nombre, nivel, ruta
FROM (
    SELECT g0.genero_id, g0.nombre, 0 AS nivel,
           CAST(g0.nombre AS nvarchar(200)) AS ruta
    FROM dbo.generos AS g0
    WHERE g0.genero_padre_id IS NULL

    UNION ALL
    SELECT g1.genero_id, g1.nombre, 1,
           CAST(g0.nombre + N' > ' + g1.nombre AS nvarchar(200))
    FROM dbo.generos AS g1
    JOIN dbo.generos AS g0 ON g1.genero_padre_id = g0.genero_id
    WHERE g0.genero_padre_id IS NULL

    UNION ALL
    SELECT g2.genero_id, g2.nombre, 2,
           CAST(g0.nombre + N' > ' + g1.nombre + N' > ' + g2.nombre AS nvarchar(200))
    FROM dbo.generos AS g2
    JOIN dbo.generos AS g1 ON g2.genero_padre_id = g1.genero_id
    JOIN dbo.generos AS g0 ON g1.genero_padre_id = g0.genero_id
    WHERE g0.genero_padre_id IS NULL

    UNION ALL
    SELECT g3.genero_id, g3.nombre, 3,
           CAST(g0.nombre + N' > ' + g1.nombre + N' > ' + g2.nombre + N' > ' + g3.nombre AS nvarchar(200))
    FROM dbo.generos AS g3
    JOIN dbo.generos AS g2 ON g3.genero_padre_id = g2.genero_id
    JOIN dbo.generos AS g1 ON g2.genero_padre_id = g1.genero_id
    JOIN dbo.generos AS g0 ON g1.genero_padre_id = g0.genero_id
    WHERE g0.genero_padre_id IS NULL
) AS arbol
ORDER BY ruta;

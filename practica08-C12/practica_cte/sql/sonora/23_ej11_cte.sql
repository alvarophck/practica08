USE SonoraDB;
GO

-- Ejemplo 11. CTE recursiva: árbol de géneros con nivel y ruta
WITH arbol AS (
    SELECT genero_id, nombre, genero_padre_id,
           0 AS nivel,
           CAST(nombre AS nvarchar(200)) AS ruta
    FROM dbo.generos
    WHERE genero_padre_id IS NULL

    UNION ALL

    SELECT g.genero_id, g.nombre, g.genero_padre_id,
           a.nivel + 1,
           CAST(a.ruta + N' > ' + g.nombre AS nvarchar(200))
    FROM dbo.generos AS g
    JOIN arbol AS a ON g.genero_padre_id = a.genero_id
)
SELECT genero_id, nombre, nivel, ruta
FROM arbol
ORDER BY ruta;

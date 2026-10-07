USE SalesDB;
GO

-- CTE recursiva propia: árbol completo con nivel y ruta
WITH Arbol AS
(
    -- Ancla: el género raíz (sin padre)
    SELECT GeneroID, Nombre, PadreID,
           1 AS Nivel,
           CAST(Nombre AS VARCHAR(200)) AS Ruta
    FROM dbo.Generos
    WHERE PadreID IS NULL

    UNION ALL

    -- Recursivo: hijos de los géneros ya obtenidos
    SELECT g.GeneroID, g.Nombre, g.PadreID,
           a.Nivel + 1,
           CAST(a.Ruta + ' > ' + g.Nombre AS VARCHAR(200))
    FROM dbo.Generos AS g
    INNER JOIN Arbol AS a ON g.PadreID = a.GeneroID
)
SELECT GeneroID,
       REPLICATE('    ', Nivel - 1) + Nombre AS Genero,
       Nivel,
       Ruta
FROM Arbol
ORDER BY Ruta;

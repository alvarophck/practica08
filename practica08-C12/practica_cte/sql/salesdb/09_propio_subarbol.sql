USE SalesDB;
GO

-- Mismo patrón, pero partiendo de un género concreto (Electrónica): su subárbol
WITH Subarbol AS
(
    SELECT GeneroID, Nombre, PadreID, 1 AS Nivel
    FROM dbo.Generos
    WHERE Nombre = 'Electrónica'          -- ancla: nodo elegido

    UNION ALL

    SELECT g.GeneroID, g.Nombre, g.PadreID, s.Nivel + 1
    FROM dbo.Generos AS g
    INNER JOIN Subarbol AS s ON g.PadreID = s.GeneroID
)
SELECT GeneroID, Nombre, Nivel
FROM Subarbol
ORDER BY Nivel, Nombre;

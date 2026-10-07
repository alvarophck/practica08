USE SonoraDB;
GO

-- Ejemplo 13. CTE recursiva para generar fechas, con MAXRECURSION
WITH dias AS (
    SELECT CAST('2026-09-14' AS date) AS dia
    UNION ALL
    SELECT DATEADD(DAY, 1, dia)
    FROM dias
    WHERE dia < '2026-09-22'
)
SELECT d.dia, COUNT(r.reproduccion_id) AS reproducciones
FROM dias AS d
LEFT JOIN dbo.reproducciones AS r
       ON CAST(r.fecha_hora AS date) = d.dia
      AND r.tipo_contenido = N'Canción'
GROUP BY d.dia
ORDER BY d.dia
OPTION (MAXRECURSION 400);

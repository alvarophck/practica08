USE SonoraDB;
GO

-- Ejemplo 13. Alternativa con tabla derivada de números fijos (9 días)
SELECT d.dia, COUNT(r.reproduccion_id) AS reproducciones
FROM (SELECT DATEADD(DAY, n.n, CAST('2026-09-14' AS date)) AS dia
      FROM (VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8)) AS n(n)) AS d
LEFT JOIN dbo.reproducciones AS r
       ON CAST(r.fecha_hora AS date) = d.dia
      AND r.tipo_contenido = N'Canción'
GROUP BY d.dia
ORDER BY d.dia;

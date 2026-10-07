USE SonoraDB;
GO

-- Ejercicio 9. Pipeline de tres CTE: país y plan, reproducciones válidas y minutos
WITH limpias AS (
    SELECT usuario_id, segundos_escuchados
    FROM dbo.reproducciones
    WHERE tipo_contenido = N'Canción'
      AND segundos_escuchados >= 30
),
enriquecidas AS (
    SELECT u.pais, u.plan_suscripcion, l.segundos_escuchados
    FROM limpias AS l
    JOIN dbo.usuarios AS u ON u.usuario_id = l.usuario_id
),
agregadas AS (
    SELECT pais, plan_suscripcion,
           COUNT(*) AS reproducciones,
           CAST(SUM(segundos_escuchados) / 60.0 AS decimal(6,1)) AS minutos
    FROM enriquecidas
    GROUP BY pais, plan_suscripcion
)
SELECT pais, plan_suscripcion, reproducciones, minutos
FROM agregadas
ORDER BY minutos DESC;

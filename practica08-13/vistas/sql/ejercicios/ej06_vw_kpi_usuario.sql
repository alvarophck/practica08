USE SonoraDB;
GO

CREATE OR ALTER VIEW dbo.vw_kpi_usuario
AS
SELECT u.usuario_id,
       u.nombre_usuario,
       u.plan_suscripcion,
       u.pais,
       COUNT(v.reproduccion_id) AS reproducciones_validas,
       CAST(COALESCE(SUM(v.segundos_escuchados), 0) / 60.0 AS decimal(6,1)) AS minutos,
       MAX(v.fecha_hora) AS ultima_reproduccion_valida
FROM dbo.usuarios AS u
LEFT JOIN dbo.vw_reproducciones_validas AS v ON v.usuario_id = u.usuario_id
GROUP BY u.usuario_id, u.nombre_usuario, u.plan_suscripcion, u.pais;
GO

-- a)
SELECT nombre_usuario, plan_suscripcion, reproducciones_validas, minutos, ultima_reproduccion_valida
FROM dbo.vw_kpi_usuario
WHERE reproducciones_validas = 0;

-- b)
SELECT nombre_usuario, plan_suscripcion, reproducciones_validas, minutos
FROM dbo.vw_kpi_usuario
WHERE plan_suscripcion IN (N'Premium', N'Familiar')
ORDER BY minutos DESC;

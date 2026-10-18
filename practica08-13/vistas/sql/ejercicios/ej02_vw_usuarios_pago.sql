USE SonoraDB;
GO

CREATE OR ALTER VIEW dbo.vw_usuarios_pago
AS
SELECT usuario_id, nombre_usuario, pais, plan_suscripcion, fecha_alta
FROM dbo.usuarios
WHERE plan_suscripcion IN (N'Premium', N'Familiar');
GO

SELECT usuario_id, nombre_usuario, pais, plan_suscripcion, fecha_alta
FROM dbo.vw_usuarios_pago
ORDER BY fecha_alta;

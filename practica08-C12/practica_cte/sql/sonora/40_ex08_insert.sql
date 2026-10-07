USE SonoraDB;
GO

-- Ejercicio 8, paso 2. Carga idempotente. Se ejecuta dos veces: 2 filas y luego 0
INSERT INTO dbo.usuarios (usuario_id, nombre_usuario, email, pais, plan_suscripcion, fecha_alta)
SELECT s.usuario_id, s.nombre_usuario, s.email, s.pais, s.plan_suscripcion, s.fecha_alta
FROM dbo.stg_usuarios AS s
WHERE NOT EXISTS (SELECT 1
                  FROM dbo.usuarios AS u
                  WHERE u.usuario_id = s.usuario_id);

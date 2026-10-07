USE SonoraDB;
GO

-- Ejercicio 8, paso 1. Usuarios del staging que aún no están en usuarios
SELECT s.usuario_id, s.nombre_usuario, s.plan_suscripcion
FROM dbo.stg_usuarios AS s
WHERE NOT EXISTS (SELECT 1
                  FROM dbo.usuarios AS u
                  WHERE u.usuario_id = s.usuario_id);

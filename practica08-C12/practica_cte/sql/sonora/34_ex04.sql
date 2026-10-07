USE SonoraDB;
GO

-- Ejercicio 4. Usuarios que han escuchado al menos un anuncio (EXISTS)
SELECT u.nombre_usuario, u.plan_suscripcion
FROM dbo.usuarios AS u
WHERE EXISTS (SELECT 1
              FROM dbo.reproducciones AS r
              WHERE r.usuario_id = u.usuario_id
                AND r.tipo_contenido = N'Anuncio')
ORDER BY u.nombre_usuario;

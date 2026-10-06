USE SonoraDB;
GO

-- Ejemplo 4. Tabla derivada en FROM
SELECT u.nombre_usuario, u.plan_suscripcion, t.num_reproducciones
FROM (
    SELECT usuario_id, COUNT(*) AS num_reproducciones
    FROM dbo.reproducciones
    WHERE tipo_contenido = N'Canción'
    GROUP BY usuario_id
) AS t
JOIN dbo.usuarios AS u ON u.usuario_id = t.usuario_id
WHERE t.num_reproducciones >= 5
ORDER BY t.num_reproducciones DESC, u.nombre_usuario;

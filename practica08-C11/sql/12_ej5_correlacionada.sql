USE SonoraDB;
GO

-- Ejemplo 5. Subconsulta correlacionada
SELECT u.nombre_usuario, r.fecha_hora, c.titulo
FROM dbo.reproducciones AS r
JOIN dbo.usuarios AS u ON u.usuario_id = r.usuario_id
LEFT JOIN dbo.canciones AS c ON c.cancion_id = r.cancion_id
WHERE r.fecha_hora = (
    SELECT MAX(r2.fecha_hora)
    FROM dbo.reproducciones AS r2
    WHERE r2.usuario_id = r.usuario_id
)
ORDER BY r.fecha_hora;

USE SonoraDB;
GO

CREATE OR ALTER VIEW dbo.vw_saltos
AS
SELECT reproduccion_id, usuario_id, cancion_id, fecha_hora, segundos_escuchados
FROM dbo.reproducciones
WHERE tipo_contenido = N'Canción'
  AND segundos_escuchados < 30;
GO

SELECT u.nombre_usuario, c.titulo, s.segundos_escuchados, s.fecha_hora
FROM dbo.vw_saltos AS s
JOIN dbo.usuarios  AS u ON u.usuario_id = s.usuario_id
JOIN dbo.canciones AS c ON c.cancion_id = s.cancion_id
ORDER BY s.fecha_hora;

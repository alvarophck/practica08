USE SonoraDB;
GO

-- Ejercicio 5, versión 1. Usuarios con 4 o más reproducciones válidas (tabla derivada)
SELECT u.nombre_usuario, t.reproducciones_validas
FROM (SELECT usuario_id, COUNT(*) AS reproducciones_validas
      FROM dbo.reproducciones
      WHERE tipo_contenido = N'Canción'
        AND segundos_escuchados >= 30
      GROUP BY usuario_id) AS t
JOIN dbo.usuarios AS u ON u.usuario_id = t.usuario_id
WHERE t.reproducciones_validas >= 4
ORDER BY t.reproducciones_validas DESC, u.nombre_usuario;

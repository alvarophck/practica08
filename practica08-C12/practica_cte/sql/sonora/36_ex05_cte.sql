USE SonoraDB;
GO

-- Ejercicio 5, versión 2. La misma consulta con una CTE
WITH validas AS (
    SELECT usuario_id, COUNT(*) AS reproducciones_validas
    FROM dbo.reproducciones
    WHERE tipo_contenido = N'Canción'
      AND segundos_escuchados >= 30
    GROUP BY usuario_id
)
SELECT u.nombre_usuario, v.reproducciones_validas
FROM validas AS v
JOIN dbo.usuarios AS u ON u.usuario_id = v.usuario_id
WHERE v.reproducciones_validas >= 4
ORDER BY v.reproducciones_validas DESC, u.nombre_usuario;

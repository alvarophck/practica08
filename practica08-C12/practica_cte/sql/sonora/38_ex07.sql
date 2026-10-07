USE SonoraDB;
GO

-- Ejercicio 7. Canciones que ningún usuario Free ha escuchado, con NOT EXISTS
-- La versión con NOT IN devuelve 0 filas: la subconsulta incluye NULL (anuncios sin cancion_id)
SELECT c.titulo
FROM dbo.canciones AS c
WHERE NOT EXISTS (SELECT 1
                  FROM dbo.reproducciones AS r
                  JOIN dbo.usuarios AS u ON u.usuario_id = r.usuario_id
                  WHERE r.cancion_id = c.cancion_id
                    AND u.plan_suscripcion = N'Free')
ORDER BY c.titulo;

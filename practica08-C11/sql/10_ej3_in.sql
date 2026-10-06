USE SonoraDB;
GO

-- Ejemplo 3. Subconsulta de lista con IN (anidadas)
SELECT nombre_usuario, plan_suscripcion
FROM dbo.usuarios
WHERE usuario_id IN (
    SELECT usuario_id
    FROM dbo.reproducciones
    WHERE cancion_id IN (
        SELECT cancion_id
        FROM dbo.canciones
        WHERE artista_id = (SELECT artista_id FROM dbo.artistas WHERE nombre = N'Nébula')
    )
)
ORDER BY nombre_usuario;

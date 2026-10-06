USE SonoraDB;
GO

-- Ejemplo 7, paso 3. NOT EXISTS: la version correcta
SELECT c.cancion_id, c.titulo
FROM dbo.canciones AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.reproducciones AS r
    WHERE r.cancion_id = c.cancion_id
);

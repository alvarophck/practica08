USE SonoraDB;
GO

-- Ejemplo 7, paso 1. NOT IN con NULL: devuelve 0 filas
SELECT cancion_id, titulo
FROM dbo.canciones
WHERE cancion_id NOT IN (SELECT cancion_id FROM dbo.reproducciones);

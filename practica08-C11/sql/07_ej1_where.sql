USE SonoraDB;
GO

-- Ejemplo 1, paso 2. Subconsulta escalar en WHERE
SELECT titulo, duracion_seg
FROM dbo.canciones
WHERE duracion_seg > (SELECT AVG(duracion_seg) FROM dbo.canciones)
ORDER BY duracion_seg DESC;

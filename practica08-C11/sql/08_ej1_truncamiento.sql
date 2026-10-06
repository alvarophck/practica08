USE SonoraDB;
GO

-- Ejemplo 1, extra. AVG sobre int trunca los decimales
SELECT AVG(duracion_seg)       AS media_int,
       AVG(duracion_seg * 1.0) AS media_decimal
FROM dbo.canciones;

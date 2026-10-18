USE SonoraDB;
GO

CREATE OR ALTER VIEW dbo.vw_canciones_por_dispositivo
AS
SELECT dispositivo, COUNT(*) AS reproducciones
FROM dbo.reproducciones
WHERE tipo_contenido = N'Canción'
GROUP BY dispositivo;
GO

SELECT dispositivo, reproducciones
FROM dbo.vw_canciones_por_dispositivo
ORDER BY reproducciones DESC;

USE SonoraDB;
GO

CREATE OR ALTER VIEW dbo.vw_anuncios
AS
SELECT reproduccion_id, usuario_id, fecha_hora, dispositivo
FROM dbo.reproducciones
WHERE tipo_contenido = N'Anuncio';
GO

SELECT dispositivo,
       COUNT(*)                   AS anuncios,
       COUNT(DISTINCT usuario_id) AS usuarios
FROM dbo.vw_anuncios
GROUP BY dispositivo
ORDER BY anuncios DESC, dispositivo;

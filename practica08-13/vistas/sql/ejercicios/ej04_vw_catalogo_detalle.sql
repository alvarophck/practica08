USE SonoraDB;
GO

CREATE OR ALTER VIEW dbo.vw_catalogo_detalle
AS
SELECT c.cancion_id,
       c.titulo,
       a.nombre AS artista,
       a.pais   AS pais_artista,
       g.nombre AS genero,
       c.duracion_seg,
       CAST(c.duracion_seg / 60.0 AS decimal(4,1)) AS duracion_min
FROM dbo.canciones AS c
JOIN dbo.artistas  AS a ON a.artista_id = c.artista_id
JOIN dbo.generos   AS g ON g.genero_id  = c.genero_id;
GO

SELECT titulo, artista, genero, duracion_seg, duracion_min
FROM dbo.vw_catalogo_detalle
WHERE pais_artista = 'ES'
ORDER BY titulo;

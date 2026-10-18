USE SonoraDB;
GO

BEGIN TRAN;
GO
-- a)
UPDATE dbo.vw_catalogo_detalle SET duracion_seg = 205 WHERE titulo = N'Neón';
GO
-- b)
UPDATE dbo.vw_catalogo_detalle
SET titulo = N'Neón (Remix)', artista = N'Luna Roja & DJ Coral'
WHERE titulo = N'Neón';
GO
-- c)
UPDATE dbo.vw_catalogo_detalle SET duracion_min = 3.5 WHERE titulo = N'Neón';
GO
-- d)
UPDATE dbo.vw_catalogo_detalle SET artista = N'Luna Roja Oficial' WHERE titulo = N'Neón';
GO
SELECT titulo, artista, duracion_seg
FROM dbo.vw_catalogo_detalle
WHERE artista LIKE N'Luna Roja%'
ORDER BY titulo;
GO
ROLLBACK;

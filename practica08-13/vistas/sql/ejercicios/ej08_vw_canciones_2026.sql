USE SonoraDB;
GO

CREATE OR ALTER VIEW dbo.vw_canciones_2026
AS
SELECT cancion_id, titulo, artista_id, genero_id, duracion_seg, fecha_lanzamiento
FROM dbo.canciones
WHERE fecha_lanzamiento >= '2026-01-01'
WITH CHECK OPTION;
GO

BEGIN TRAN;
GO
UPDATE dbo.vw_canciones_2026 SET duracion_seg = 170 WHERE titulo = N'Humo Violeta';
GO
UPDATE dbo.vw_canciones_2026 SET fecha_lanzamiento = '2025-12-15' WHERE titulo = N'Humo Violeta';
GO
UPDATE dbo.vw_canciones_2026 SET duracion_seg = 210 WHERE titulo = N'Neón';
GO
INSERT INTO dbo.vw_canciones_2026 (cancion_id, titulo, artista_id, genero_id, duracion_seg, fecha_lanzamiento)
VALUES (116, N'Eco Antiguo', 9, 2, 190, '2025-10-01');
GO
INSERT INTO dbo.vw_canciones_2026 (cancion_id, titulo, artista_id, genero_id, duracion_seg, fecha_lanzamiento)
VALUES (117, N'Primer Vuelo', 9, 2, 195, '2026-10-02');
GO
ROLLBACK;
GO

SELECT COUNT(*) AS canciones FROM dbo.canciones;
SELECT titulo, duracion_seg FROM dbo.canciones WHERE titulo = N'Humo Violeta';

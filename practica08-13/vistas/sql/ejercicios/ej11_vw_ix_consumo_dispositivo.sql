USE SonoraDB;
GO

-- a) y b)
DROP VIEW IF EXISTS dbo.vw_ix_consumo_dispositivo;
GO

CREATE VIEW dbo.vw_ix_consumo_dispositivo
WITH SCHEMABINDING
AS
SELECT dispositivo,
       COUNT_BIG(*)             AS reproducciones_validas,
       SUM(segundos_escuchados) AS segundos
FROM dbo.reproducciones
WHERE tipo_contenido = N'Canción'
  AND segundos_escuchados >= 30
GROUP BY dispositivo;
GO

CREATE UNIQUE CLUSTERED INDEX IX_vw_ix_consumo_dispositivo
    ON dbo.vw_ix_consumo_dispositivo (dispositivo);
GO

SELECT dispositivo,
       reproducciones_validas,
       CAST(segundos / 60.0 AS decimal(6,1))                          AS minutos,
       CAST(segundos * 1.0 / reproducciones_validas AS decimal(6,1)) AS media_segundos
FROM dbo.vw_ix_consumo_dispositivo WITH (NOEXPAND)
ORDER BY reproducciones_validas DESC, dispositivo;
GO

-- c)
BEGIN TRAN;

INSERT INTO dbo.reproducciones
    (reproduccion_id, usuario_id, cancion_id, fecha_hora, segundos_escuchados, dispositivo, tipo_contenido)
VALUES (44, 6, 102, '2026-09-22 21:00', 201, N'Smart TV', N'Canción');

SELECT dispositivo, reproducciones_validas, segundos
FROM dbo.vw_ix_consumo_dispositivo WITH (NOEXPAND)
WHERE dispositivo = N'Smart TV';

ROLLBACK;

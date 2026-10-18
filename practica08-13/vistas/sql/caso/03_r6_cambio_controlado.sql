USE SonoraDB;
GO

BEGIN TRAN;

-- 1. Quitar temporalmente el enlace
EXEC (N'CREATE OR ALTER VIEW dbo.vw_bi_consumo_pais_plan
AS
SELECT u.pais AS pais_usuario, u.plan_suscripcion,
       COUNT_BIG(*) AS reproducciones_validas,
       CAST(SUM(r.segundos_escuchados) / 60.0 AS decimal(6,1)) AS minutos
FROM dbo.reproducciones AS r
JOIN dbo.usuarios AS u ON u.usuario_id = r.usuario_id
WHERE r.tipo_contenido = N''Canción'' AND r.segundos_escuchados >= 30
GROUP BY u.pais, u.plan_suscripcion;');

-- 2. Ampliar la columna
ALTER TABLE dbo.usuarios ALTER COLUMN plan_suscripcion nvarchar(30) NOT NULL;

-- 3. Volver a enlazar la vista
EXEC (N'CREATE OR ALTER VIEW dbo.vw_bi_consumo_pais_plan
WITH SCHEMABINDING
AS
SELECT u.pais AS pais_usuario, u.plan_suscripcion,
       COUNT_BIG(*) AS reproducciones_validas,
       CAST(SUM(r.segundos_escuchados) / 60.0 AS decimal(6,1)) AS minutos
FROM dbo.reproducciones AS r
JOIN dbo.usuarios AS u ON u.usuario_id = r.usuario_id
WHERE r.tipo_contenido = N''Canción'' AND r.segundos_escuchados >= 30
GROUP BY u.pais, u.plan_suscripcion;');

-- 4. Refrescar metadatos de las vistas no enlazadas que exponen la columna
EXEC sp_refreshview N'dbo.vw_bi_hechos_reproduccion';
EXEC sp_refreshview N'dbo.vw_usuarios_latam';

SELECT c.name, t.name AS tipo, c.max_length / 2 AS longitud
FROM sys.columns AS c
JOIN sys.types AS t ON t.user_type_id = c.user_type_id
WHERE c.object_id = OBJECT_ID(N'dbo.usuarios') AND c.name = N'plan_suscripcion';

ROLLBACK;
GO

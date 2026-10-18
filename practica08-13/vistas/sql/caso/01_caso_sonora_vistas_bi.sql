USE SonoraDB;
GO

-- Requerimiento 1. Tabla de hechos de reproducciones válidas
CREATE OR ALTER VIEW dbo.vw_bi_hechos_reproduccion
AS
WITH arbol AS (
    SELECT genero_id, genero_id AS raiz_id
    FROM dbo.generos
    WHERE genero_padre_id = (SELECT genero_id FROM dbo.generos WHERE genero_padre_id IS NULL)

    UNION ALL

    SELECT g.genero_id, a.raiz_id
    FROM dbo.generos AS g
    JOIN arbol AS a ON g.genero_padre_id = a.genero_id
)
SELECT r.reproduccion_id,
       CAST(r.fecha_hora AS date) AS fecha,
       r.fecha_hora,
       u.usuario_id,
       u.nombre_usuario,
       u.pais          AS pais_usuario,
       u.plan_suscripcion,
       c.titulo,
       a.nombre        AS artista,
       g.nombre        AS genero,
       gp.nombre       AS genero_principal,
       r.dispositivo,
       r.segundos_escuchados
FROM dbo.reproducciones AS r
JOIN dbo.usuarios  AS u  ON u.usuario_id = r.usuario_id
JOIN dbo.canciones AS c  ON c.cancion_id = r.cancion_id
JOIN dbo.artistas  AS a  ON a.artista_id = c.artista_id
JOIN dbo.generos   AS g  ON g.genero_id  = c.genero_id
JOIN arbol         AS ar ON ar.genero_id = c.genero_id
JOIN dbo.generos   AS gp ON gp.genero_id = ar.raiz_id
WHERE r.tipo_contenido = N'Canción'
  AND r.segundos_escuchados >= 30;
GO

-- Comprobación: una fila por reproducción válida
SELECT (SELECT COUNT(*) FROM dbo.vw_bi_hechos_reproduccion)                       AS filas_vista,
       (SELECT COUNT(DISTINCT reproduccion_id) FROM dbo.vw_bi_hechos_reproduccion) AS ids_distintos,
       (SELECT COUNT(*) FROM dbo.reproducciones
        WHERE tipo_contenido = N'Canción' AND segundos_escuchados >= 30)          AS validas_tabla;

-- Resumen por país
SELECT pais_usuario,
       COUNT(*)                   AS reproducciones,
       COUNT(DISTINCT usuario_id) AS oyentes,
       CAST(SUM(segundos_escuchados) / 60.0 AS decimal(6,1)) AS minutos
FROM dbo.vw_bi_hechos_reproduccion
GROUP BY pais_usuario
ORDER BY reproducciones DESC, pais_usuario;
GO

-- Requerimiento 2. Evolución diaria
CREATE OR ALTER VIEW dbo.vw_bi_kpi_diario
AS
SELECT fecha,
       COUNT(*)                   AS reproducciones_validas,
       COUNT(DISTINCT usuario_id) AS oyentes,
       CAST(SUM(segundos_escuchados) / 60.0 AS decimal(6,1)) AS minutos
FROM dbo.vw_bi_hechos_reproduccion
GROUP BY fecha;
GO

SELECT fecha, reproducciones_validas, oyentes, minutos
FROM dbo.vw_bi_kpi_diario
WHERE fecha BETWEEN '2026-09-16' AND '2026-09-22'
ORDER BY fecha;
GO

-- Requerimiento 3. Indicadores por género principal
CREATE OR ALTER VIEW dbo.vw_bi_kpi_genero_principal
AS
SELECT g.nombre                     AS genero_principal,
       COUNT(h.reproduccion_id)     AS reproducciones_validas,
       COUNT(DISTINCT h.usuario_id) AS oyentes,
       CAST(COALESCE(SUM(h.segundos_escuchados), 0) / 60.0 AS decimal(6,1)) AS minutos
FROM dbo.generos AS g
LEFT JOIN dbo.vw_bi_hechos_reproduccion AS h ON h.genero_principal = g.nombre
WHERE g.genero_padre_id = (SELECT genero_id FROM dbo.generos WHERE genero_padre_id IS NULL)
GROUP BY g.nombre;
GO

SELECT genero_principal, reproducciones_validas, oyentes, minutos
FROM dbo.vw_bi_kpi_genero_principal
ORDER BY reproducciones_validas DESC;
GO

-- Requerimiento 4. Rendimiento de canciones
CREATE OR ALTER VIEW dbo.vw_bi_rendimiento_canciones
AS
SELECT c.cancion_id,
       c.titulo,
       a.nombre AS artista,
       c.fecha_lanzamiento,
       COUNT(r.reproduccion_id)                                  AS reproducciones_totales,
       COUNT(CASE WHEN r.segundos_escuchados >= 30 THEN 1 END)   AS reproducciones_validas,
       COUNT(CASE WHEN r.segundos_escuchados <  30 THEN 1 END)   AS saltos,
       CAST(100.0 * COUNT(CASE WHEN r.segundos_escuchados < 30 THEN 1 END)
            / NULLIF(COUNT(r.reproduccion_id), 0) AS decimal(5,1)) AS tasa_salto
FROM dbo.canciones AS c
JOIN dbo.artistas AS a ON a.artista_id = c.artista_id
LEFT JOIN dbo.reproducciones AS r
       ON r.cancion_id = c.cancion_id
      AND r.tipo_contenido = N'Canción'
GROUP BY c.cancion_id, c.titulo, a.nombre, c.fecha_lanzamiento;
GO

SELECT titulo, artista, reproducciones_totales, reproducciones_validas, saltos, tasa_salto
FROM dbo.vw_bi_rendimiento_canciones
WHERE saltos > 0
ORDER BY tasa_salto DESC;
GO

-- Requerimiento 5. Mantenimiento de usuarios LATAM
CREATE OR ALTER VIEW dbo.vw_usuarios_latam
AS
SELECT usuario_id, nombre_usuario, pais, plan_suscripcion, fecha_alta
FROM dbo.usuarios
WHERE pais IN ('MX', 'AR', 'CO', 'PR')
WITH CHECK OPTION;
GO

SELECT usuario_id, nombre_usuario, pais, plan_suscripcion, fecha_alta
FROM dbo.vw_usuarios_latam
ORDER BY pais, nombre_usuario;
GO

BEGIN TRAN;
GO
-- a) Permitido
UPDATE dbo.vw_usuarios_latam SET plan_suscripcion = N'Premium' WHERE nombre_usuario = N'nachox';
GO
-- b) Bloqueado por CHECK OPTION
UPDATE dbo.vw_usuarios_latam SET pais = 'ES' WHERE nombre_usuario = N'juanpi';
GO
-- c) marta_rock no es visible en la vista
UPDATE dbo.vw_usuarios_latam SET plan_suscripcion = N'Premium' WHERE nombre_usuario = N'marta_rock';
GO
ROLLBACK;
GO

-- Requerimiento 6. Consumo por país y plan, enlazado al esquema
CREATE OR ALTER VIEW dbo.vw_bi_consumo_pais_plan
WITH SCHEMABINDING
AS
SELECT u.pais AS pais_usuario,
       u.plan_suscripcion,
       COUNT_BIG(*) AS reproducciones_validas,
       CAST(SUM(r.segundos_escuchados) / 60.0 AS decimal(6,1)) AS minutos
FROM dbo.reproducciones AS r
JOIN dbo.usuarios AS u ON u.usuario_id = r.usuario_id
WHERE r.tipo_contenido = N'Canción'
  AND r.segundos_escuchados >= 30
GROUP BY u.pais, u.plan_suscripcion;
GO

SELECT pais_usuario, plan_suscripcion, reproducciones_validas, minutos
FROM dbo.vw_bi_consumo_pais_plan
ORDER BY minutos DESC;
GO

-- Requerimiento 7. Mapa de dependencias
-- a)
SELECT referencing_schema_name, referencing_entity_name
FROM sys.dm_sql_referencing_entities(N'dbo.reproducciones', N'OBJECT')
WHERE referencing_entity_name LIKE N'vw[_]bi[_]%'
ORDER BY referencing_entity_name;

-- b)
SELECT referencing_schema_name, referencing_entity_name
FROM sys.dm_sql_referencing_entities(N'dbo.vw_bi_hechos_reproduccion', N'OBJECT')
ORDER BY referencing_entity_name;

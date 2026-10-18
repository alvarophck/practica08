USE SonoraDB;
GO

-- Ejemplo 1. Reproducciones válidas
CREATE OR ALTER VIEW dbo.vw_reproducciones_validas
AS
SELECT reproduccion_id, usuario_id, cancion_id, fecha_hora,
       segundos_escuchados, dispositivo
FROM dbo.reproducciones
WHERE tipo_contenido = N'Canción'
  AND segundos_escuchados >= 30;
GO

-- Ejemplo 2. Directorio de usuarios sin email
CREATE OR ALTER VIEW dbo.vw_usuarios_directorio
AS
SELECT usuario_id, nombre_usuario, pais, plan_suscripcion, fecha_alta
FROM dbo.usuarios;
GO

-- Ejemplo 3. Reproducciones enriquecidas
CREATE OR ALTER VIEW dbo.vw_reproducciones_detalle
AS
SELECT v.reproduccion_id,
       v.fecha_hora,
       u.usuario_id,
       u.nombre_usuario,
       u.pais            AS pais_usuario,
       u.plan_suscripcion,
       c.titulo,
       a.nombre          AS artista,
       g.nombre          AS genero,
       v.dispositivo,
       v.segundos_escuchados
FROM dbo.vw_reproducciones_validas AS v
JOIN dbo.usuarios  AS u ON u.usuario_id = v.usuario_id
JOIN dbo.canciones AS c ON c.cancion_id = v.cancion_id
JOIN dbo.artistas  AS a ON a.artista_id = c.artista_id
JOIN dbo.generos   AS g ON g.genero_id  = c.genero_id;
GO

-- Ejemplo 4. Indicadores por canción
CREATE OR ALTER VIEW dbo.vw_kpi_cancion
AS
SELECT c.cancion_id,
       c.titulo,
       a.nombre                     AS artista,
       c.fecha_lanzamiento,
       COUNT(v.reproduccion_id)     AS reproducciones_validas,
       COUNT(DISTINCT v.usuario_id) AS oyentes,
       CAST(COALESCE(SUM(v.segundos_escuchados), 0) / 60.0 AS decimal(6,1)) AS minutos
FROM dbo.canciones AS c
JOIN dbo.artistas AS a ON a.artista_id = c.artista_id
LEFT JOIN dbo.vw_reproducciones_validas AS v ON v.cancion_id = c.cancion_id
GROUP BY c.cancion_id, c.titulo, a.nombre, c.fecha_lanzamiento;
GO

-- Ejemplo 6. Género principal de cada subgénero
CREATE OR ALTER VIEW dbo.vw_genero_principal
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
SELECT a.genero_id,
       g.nombre AS genero,
       r.nombre AS genero_principal
FROM arbol AS a
JOIN dbo.generos AS g ON g.genero_id = a.genero_id
JOIN dbo.generos AS r ON r.genero_id = a.raiz_id;
GO

-- Ejemplo 9. Usuarios Free con CHECK OPTION
CREATE OR ALTER VIEW dbo.vw_usuarios_free
AS
SELECT usuario_id, nombre_usuario, pais, plan_suscripcion, fecha_alta
FROM dbo.usuarios
WHERE plan_suscripcion = N'Free'
WITH CHECK OPTION;
GO

-- Ejemplo 11. Catálogo enlazado al esquema
CREATE OR ALTER VIEW dbo.vw_catalogo_canciones
WITH SCHEMABINDING
AS
SELECT c.cancion_id,
       c.titulo,
       a.nombre AS artista,
       c.duracion_seg,
       c.fecha_lanzamiento
FROM dbo.canciones AS c
JOIN dbo.artistas  AS a ON a.artista_id = c.artista_id;
GO

-- Ejemplo 12. Vista indexada de consumo por canción
DROP VIEW IF EXISTS dbo.vw_ix_consumo_cancion;
GO

CREATE VIEW dbo.vw_ix_consumo_cancion
WITH SCHEMABINDING
AS
SELECT cancion_id,
       COUNT_BIG(*)             AS reproducciones_validas,
       SUM(segundos_escuchados) AS segundos
FROM dbo.reproducciones
WHERE tipo_contenido = N'Canción'
  AND segundos_escuchados >= 30
GROUP BY cancion_id;
GO

CREATE UNIQUE CLUSTERED INDEX IX_vw_ix_consumo_cancion
    ON dbo.vw_ix_consumo_cancion (cancion_id);
GO

SELECT name AS vista
FROM sys.views
ORDER BY name;

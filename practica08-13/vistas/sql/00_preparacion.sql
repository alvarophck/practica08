USE SonoraDB;
GO

-- 1. Cargas de la clase de subconsultas y CTE
INSERT INTO dbo.reproducciones
    (reproduccion_id, usuario_id, cancion_id, fecha_hora, segundos_escuchados, dispositivo, tipo_contenido)
SELECT s.reproduccion_id, s.usuario_id, s.cancion_id, s.fecha_hora,
       s.segundos_escuchados, s.dispositivo, s.tipo_contenido
FROM dbo.stg_reproducciones AS s
WHERE NOT EXISTS (SELECT 1 FROM dbo.reproducciones AS r WHERE r.reproduccion_id = s.reproduccion_id);

INSERT INTO dbo.usuarios (usuario_id, nombre_usuario, email, pais, plan_suscripcion, fecha_alta)
SELECT s.usuario_id, s.nombre_usuario, s.email, s.pais, s.plan_suscripcion, s.fecha_alta
FROM dbo.stg_usuarios AS s
WHERE NOT EXISTS (SELECT 1 FROM dbo.usuarios AS u WHERE u.usuario_id = s.usuario_id);
GO

-- 2. Lote del 22/09
DROP TABLE IF EXISTS dbo.stg_reproducciones_2209;

CREATE TABLE dbo.stg_reproducciones_2209 (
    reproduccion_id      int,
    usuario_id           int,
    cancion_id           int,
    fecha_hora           datetime2(0),
    segundos_escuchados  int,
    dispositivo          nvarchar(20),
    tipo_contenido       nvarchar(10)
);

INSERT INTO dbo.stg_reproducciones_2209
    (reproduccion_id, usuario_id, cancion_id, fecha_hora, segundos_escuchados, dispositivo, tipo_contenido) VALUES
(37, 5,  NULL, '2026-09-21 22:00', 30,  N'Móvil', N'Anuncio'),
(38, 5,  104,  '2026-09-21 22:01', 190, N'Móvil', N'Canción'),
(39, 8,  106,  '2026-09-22 07:30', 12,  N'Móvil', N'Canción'),
(40, 10, 103,  '2026-09-22 09:00', 176, N'Móvil', N'Canción'),
(41, 9,  NULL, '2026-09-22 09:10', 30,  N'Web',   N'Anuncio'),
(42, 9,  111,  '2026-09-22 09:11', 356, N'Web',   N'Canción'),
(43, 1,  114,  '2026-09-22 10:00', 25,  N'Móvil', N'Canción');

INSERT INTO dbo.reproducciones
    (reproduccion_id, usuario_id, cancion_id, fecha_hora, segundos_escuchados, dispositivo, tipo_contenido)
SELECT s.reproduccion_id, s.usuario_id, s.cancion_id, s.fecha_hora,
       s.segundos_escuchados, s.dispositivo, s.tipo_contenido
FROM dbo.stg_reproducciones_2209 AS s
WHERE NOT EXISTS (SELECT 1 FROM dbo.reproducciones AS r WHERE r.reproduccion_id = s.reproduccion_id);
GO

-- 3. Comprobación
SELECT (SELECT COUNT(*) FROM dbo.reproducciones) AS reproducciones,
       (SELECT COUNT(*) FROM dbo.usuarios)       AS usuarios;

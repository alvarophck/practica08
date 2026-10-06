USE SonoraDB;
GO

-- Ejemplo 8, paso 2. Carga incremental e idempotente
-- Se ejecuta dos veces: la primera inserta 5 filas, la segunda 0
INSERT INTO dbo.reproducciones
    (reproduccion_id, usuario_id, cancion_id, fecha_hora, segundos_escuchados, dispositivo, tipo_contenido)
SELECT s.reproduccion_id, s.usuario_id, s.cancion_id, s.fecha_hora,
       s.segundos_escuchados, s.dispositivo, s.tipo_contenido
FROM dbo.stg_reproducciones AS s
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.reproducciones AS r
    WHERE r.reproduccion_id = s.reproduccion_id
);

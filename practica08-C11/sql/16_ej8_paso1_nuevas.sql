USE SonoraDB;
GO

-- Ejemplo 8, paso 1. Filas del staging que aun no estan en destino
SELECT s.reproduccion_id, s.usuario_id, s.cancion_id, s.fecha_hora
FROM dbo.stg_reproducciones AS s
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.reproducciones AS r
    WHERE r.reproduccion_id = s.reproduccion_id
)
ORDER BY s.reproduccion_id;

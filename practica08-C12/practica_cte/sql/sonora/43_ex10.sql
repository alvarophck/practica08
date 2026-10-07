USE SonoraDB;
GO

-- Ejercicio 10. Organigrama con CTE recursiva
WITH organigrama AS (
    SELECT empleado_id, nombre, puesto,
           0 AS nivel,
           CAST(nombre AS nvarchar(400)) AS ruta
    FROM dbo.empleados
    WHERE jefe_id IS NULL

    UNION ALL

    SELECT e.empleado_id, e.nombre, e.puesto,
           o.nivel + 1,
           CAST(o.ruta + N' > ' + e.nombre AS nvarchar(400))
    FROM dbo.empleados AS e
    JOIN organigrama AS o ON e.jefe_id = o.empleado_id
)
SELECT nombre, puesto, nivel, ruta
FROM organigrama
ORDER BY ruta;

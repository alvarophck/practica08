USE SonoraDB;
GO

CREATE OR ALTER VIEW dbo.vw_organigrama
AS
WITH org AS (
    SELECT empleado_id, nombre, puesto, 0 AS nivel,
           CAST(nombre AS nvarchar(500)) AS ruta
    FROM dbo.empleados
    WHERE jefe_id IS NULL

    UNION ALL

    SELECT e.empleado_id, e.nombre, e.puesto, o.nivel + 1,
           CAST(o.ruta + N' > ' + e.nombre AS nvarchar(500))
    FROM dbo.empleados AS e
    JOIN org AS o ON e.jefe_id = o.empleado_id
)
SELECT empleado_id, nombre, puesto, nivel, ruta
FROM org;
GO

-- a)
SELECT nombre, puesto, nivel
FROM dbo.vw_organigrama
WHERE ruta LIKE N'%Raúl Benet > %'
ORDER BY nombre;

-- b)
SELECT nivel, COUNT(*) AS empleados
FROM dbo.vw_organigrama
GROUP BY nivel
ORDER BY nivel;

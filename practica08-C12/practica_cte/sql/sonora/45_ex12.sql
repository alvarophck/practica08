USE SonoraDB;
GO

-- Ejercicio 12. Área del CTO: subordinados directos e indirectos de Tomás Vidal
WITH area AS (
    SELECT empleado_id, nombre, puesto, 1 AS nivel
    FROM dbo.empleados
    WHERE jefe_id = (SELECT empleado_id FROM dbo.empleados WHERE nombre = N'Tomás Vidal')

    UNION ALL

    SELECT e.empleado_id, e.nombre, e.puesto, a.nivel + 1
    FROM dbo.empleados AS e
    JOIN area AS a ON e.jefe_id = a.empleado_id
)
SELECT nombre, puesto, nivel
FROM area
ORDER BY nivel, nombre;

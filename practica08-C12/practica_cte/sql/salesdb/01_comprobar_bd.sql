USE SalesDB;
GO

-- Comprobar que existe el esquema Sales y que tiene datos
SELECT DB_NAME() AS base_de_datos;

SELECT 'Sales.Customers' AS tabla, COUNT(*) AS filas FROM Sales.Customers
UNION ALL SELECT 'Sales.Orders',    COUNT(*) FROM Sales.Orders
UNION ALL SELECT 'Sales.Employees', COUNT(*) FROM Sales.Employees;

-- Reconstrucción mínima de SalesDB (esquema Sales: Customers, Orders, Employees)
-- Ejecutar conectado a master. Solo si no se dispone del script oficial de clase.
USE master;
GO

IF DB_ID('SalesDB') IS NOT NULL
BEGIN
    ALTER DATABASE SalesDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE SalesDB;
END
GO

CREATE DATABASE SalesDB;
GO

USE SalesDB;
GO

CREATE SCHEMA Sales;
GO

CREATE TABLE Sales.Customers
(
    CustomerID INT         NOT NULL PRIMARY KEY,
    FirstName  VARCHAR(50) NOT NULL,
    LastName   VARCHAR(50) NULL,
    Country    VARCHAR(50) NULL,
    Score      INT         NULL
);

CREATE TABLE Sales.Employees
(
    EmployeeID INT         NOT NULL PRIMARY KEY,
    FirstName  VARCHAR(50) NOT NULL,
    LastName   VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    ManagerID  INT         NULL REFERENCES Sales.Employees(EmployeeID)
);

CREATE TABLE Sales.Orders
(
    OrderID       INT         NOT NULL PRIMARY KEY,
    ProductID     INT         NOT NULL,
    CustomerID    INT         NOT NULL REFERENCES Sales.Customers(CustomerID),
    SalesPersonID INT         NULL REFERENCES Sales.Employees(EmployeeID),
    OrderDate     DATE        NOT NULL,
    ShipDate      DATE        NULL,
    OrderStatus   VARCHAR(20) NOT NULL,
    Quantity      INT         NOT NULL,
    Sales         INT         NOT NULL
);
GO

INSERT INTO Sales.Customers (CustomerID, FirstName, LastName, Country, Score) VALUES
(1, 'Jossef', 'Goldberg', 'Germany', 350),
(2, 'Kevin',  'Brown',    'USA',     900),
(3, 'Mary',   NULL,       'USA',     750),
(4, 'Mark',   'Schwarz',  'Germany', 500),
(5, 'Anna',   'Adams',    'USA',     NULL);

-- Se insertan primero los jefes para respetar la clave foránea
INSERT INTO Sales.Employees (EmployeeID, FirstName, LastName, Department, ManagerID) VALUES
(1, 'Frank',   'Lee',   'Marketing', NULL),
(2, 'Kevin',   'Brown', 'Marketing', 1),
(3, 'Mary',    'Smith', 'Sales',     1),
(4, 'Michael', 'Ray',   'Sales',     2),
(5, 'Carol',   'Baker', 'Sales',     3);

INSERT INTO Sales.Orders
(OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, Quantity, Sales) VALUES
(1,  101, 2, 3, '2025-01-01', '2025-01-05', 'Shipped',   1, 10),
(2,  102, 3, 3, '2025-01-05', '2025-01-10', 'Shipped',   1, 15),
(3,  101, 1, 5, '2025-01-10', '2025-01-25', 'Delivered', 2, 20),
(4,  105, 1, 3, '2025-01-20', '2025-01-25', 'Shipped',   2, 60),
(5,  104, 2, 5, '2025-02-01', '2025-02-05', 'Delivered', 1, 25),
(6,  104, 3, 5, '2025-02-05', '2025-02-10', 'Delivered', 2, 50),
(7,  102, 1, 1, '2025-02-15', '2025-02-27', 'Delivered', 2, 30),
(8,  101, 4, 3, '2025-02-18', '2025-02-27', 'Shipped',   3, 90),
(9,  101, 2, 3, '2025-03-10', '2025-03-15', 'Shipped',   2, 20),
(10, 102, 3, 5, '2025-03-15', '2025-03-20', 'Shipped',   1, 60);
GO

SELECT 'Sales.Customers' AS tabla, COUNT(*) AS filas FROM Sales.Customers
UNION ALL SELECT 'Sales.Orders',    COUNT(*) FROM Sales.Orders
UNION ALL SELECT 'Sales.Employees', COUNT(*) FROM Sales.Employees;

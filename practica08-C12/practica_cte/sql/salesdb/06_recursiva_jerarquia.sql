USE SalesDB;
GO

-- CTE recursiva: jerarquía de empleados con su nivel
WITH CTE_Emp_Hierarchy AS
(
    SELECT EmployeeID, FirstName, ManagerID, 1 AS Level   -- ancla: sin jefe
    FROM Sales.Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.FirstName, e.ManagerID, ceh.Level + 1
    FROM Sales.Employees AS e
    INNER JOIN CTE_Emp_Hierarchy AS ceh
        ON e.ManagerID = ceh.EmployeeID
)
SELECT * FROM CTE_Emp_Hierarchy;

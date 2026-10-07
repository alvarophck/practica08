USE SalesDB;
GO

-- CTE no recursiva: 4 CTE encadenadas + consulta principal
WITH CTE_Total_Sales AS
(
    SELECT CustomerID, SUM(Sales) AS TotalSales
    FROM Sales.Orders
    GROUP BY CustomerID
)
, CTE_Last_Order AS
(
    SELECT CustomerID, MAX(OrderDate) AS Last_Order
    FROM Sales.Orders
    GROUP BY CustomerID
)
, CTE_Customer_Rank AS
(
    SELECT CustomerID, TotalSales,
           RANK() OVER (ORDER BY TotalSales DESC) AS CustomerRank
    FROM CTE_Total_Sales
)
, CTE_Customer_Segments AS
(
    SELECT CustomerID, TotalSales,
           CASE
               WHEN TotalSales > 100 THEN 'High'
               WHEN TotalSales > 80  THEN 'Medium'
               ELSE 'Low'
           END AS CustomerSegments
    FROM CTE_Total_Sales
)
SELECT
    c.CustomerID, c.FirstName, c.LastName,
    cts.TotalSales, clo.Last_Order, ccr.CustomerRank, ccs.CustomerSegments
FROM Sales.Customers AS c
LEFT JOIN CTE_Total_Sales       AS cts ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order        AS clo ON clo.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Rank     AS ccr ON ccr.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Segments AS ccs ON ccs.CustomerID = c.CustomerID;

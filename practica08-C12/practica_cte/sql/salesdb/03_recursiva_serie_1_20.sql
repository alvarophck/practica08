USE SalesDB;
GO

-- CTE recursiva: serie del 1 al 20
WITH Series AS
(
    SELECT 1 AS MyNumber          -- ancla
    UNION ALL
    SELECT MyNumber + 1           -- recursivo
    FROM Series
    WHERE MyNumber < 20
)
SELECT * FROM Series;

USE SalesDB;
GO

-- Serie del 1 al 1000 SIN MAXRECURSION: falla al pasar de 100 vueltas (Msg 530)
WITH Series AS
(
    SELECT 1 AS MyNumber
    UNION ALL
    SELECT MyNumber + 1
    FROM Series
    WHERE MyNumber < 1000
)
SELECT * FROM Series;

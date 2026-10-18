USE SonoraDB;
GO

-- Falla a propósito: Msg 5074 y Msg 4922
ALTER TABLE dbo.usuarios ALTER COLUMN plan_suscripcion nvarchar(30) NOT NULL;

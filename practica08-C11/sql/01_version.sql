-- Paso 1. Comprobar la version del motor
SELECT @@VERSION AS version_completa,
       SERVERPROPERTY('ProductMajorVersion') AS version_principal;

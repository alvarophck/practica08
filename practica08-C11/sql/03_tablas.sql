-- Paso 3. Crear las tablas
USE SonoraDB;
GO

CREATE TABLE dbo.generos (
    genero_id        int           NOT NULL PRIMARY KEY,
    nombre           nvarchar(50)  NOT NULL,
    genero_padre_id  int           NULL REFERENCES dbo.generos (genero_id)
);

CREATE TABLE dbo.artistas (
    artista_id  int            NOT NULL PRIMARY KEY,
    nombre      nvarchar(100)  NOT NULL,
    pais        char(2)        NOT NULL,
    genero_id   int            NOT NULL REFERENCES dbo.generos (genero_id)
);

CREATE TABLE dbo.canciones (
    cancion_id         int            NOT NULL PRIMARY KEY,
    titulo             nvarchar(150)  NOT NULL,
    artista_id         int            NOT NULL REFERENCES dbo.artistas (artista_id),
    genero_id          int            NOT NULL REFERENCES dbo.generos (genero_id),
    duracion_seg       int            NOT NULL,
    fecha_lanzamiento  date           NOT NULL
);

CREATE TABLE dbo.usuarios (
    usuario_id        int            NOT NULL PRIMARY KEY,
    nombre_usuario    nvarchar(50)   NOT NULL,
    email             nvarchar(150)  NOT NULL,
    pais              char(2)        NOT NULL,
    plan_suscripcion  nvarchar(20)   NOT NULL,
    fecha_alta        date           NOT NULL
);

CREATE TABLE dbo.reproducciones (
    reproduccion_id      int           NOT NULL PRIMARY KEY,
    usuario_id           int           NOT NULL REFERENCES dbo.usuarios (usuario_id),
    cancion_id           int           NULL REFERENCES dbo.canciones (cancion_id),
    fecha_hora           datetime2(0)  NOT NULL,
    segundos_escuchados  int           NOT NULL,
    dispositivo          nvarchar(20)  NOT NULL,
    tipo_contenido       nvarchar(10)  NOT NULL
        CHECK (tipo_contenido IN (N'Canción', N'Anuncio'))
);

-- Las tablas de staging no llevan restricciones: reciben los datos tal como llegan
CREATE TABLE dbo.stg_reproducciones (
    reproduccion_id      int,
    usuario_id           int,
    cancion_id           int,
    fecha_hora           datetime2(0),
    segundos_escuchados  int,
    dispositivo          nvarchar(20),
    tipo_contenido       nvarchar(10)
);

CREATE TABLE dbo.stg_usuarios (
    usuario_id        int,
    nombre_usuario    nvarchar(50),
    email             nvarchar(150),
    pais              char(2),
    plan_suscripcion  nvarchar(20),
    fecha_alta        date
);

CREATE TABLE dbo.empleados (
    empleado_id  int            NOT NULL PRIMARY KEY,
    nombre       nvarchar(100)  NOT NULL,
    puesto       nvarchar(50)   NOT NULL,
    jefe_id      int            NULL REFERENCES dbo.empleados (empleado_id)
);
GO

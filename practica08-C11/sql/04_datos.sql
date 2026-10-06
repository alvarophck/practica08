-- Paso 4. Cargar los datos
USE SonoraDB;
GO

INSERT INTO dbo.generos (genero_id, nombre, genero_padre_id) VALUES
(1, N'Música', NULL),
(2, N'Pop', 1), (3, N'Urbano', 1), (4, N'Rock', 1), (5, N'Electrónica', 1),
(6, N'Reguetón', 3), (7, N'Trap', 3), (8, N'Hip Hop', 3),
(9, N'Indie', 4), (10, N'Metal', 4),
(11, N'House', 5), (12, N'Techno', 5),
(13, N'Dembow', 6);

INSERT INTO dbo.artistas (artista_id, nombre, pais, genero_id) VALUES
(1, N'Luna Roja', 'ES', 2),
(2, N'MC Brisa', 'PR', 6),
(3, N'Kaiser Beats', 'DE', 12),
(4, N'Los Voltios', 'AR', 9),
(5, N'Nébula', 'MX', 7),
(6, N'Hierro Fundido', 'ES', 10),
(7, N'DJ Coral', 'CO', 11),
(8, N'Verso Libre', 'ES', 8),
(9, N'Sara Cometa', 'ES', 2);

INSERT INTO dbo.canciones (cancion_id, titulo, artista_id, genero_id, duracion_seg, fecha_lanzamiento) VALUES
(101, N'Verano en Bucle',   1, 2,  185, '2026-06-12'),
(102, N'Neón',              1, 2,  201, '2025-11-03'),
(103, N'Perreo Lunar',      2, 6,  176, '2026-07-01'),
(104, N'Calle 23',          2, 6,  190, '2026-03-15'),
(105, N'Fábrica 4AM',       3, 12, 412, '2025-09-20'),
(106, N'Corriente Alterna', 4, 9,  234, '2026-02-10'),
(107, N'Cables Sueltos',    4, 9,  198, '2024-05-08'),
(108, N'Humo Violeta',      5, 7,  167, '2026-08-22'),
(109, N'Diamantes Rotos',   5, 7,  182, '2026-04-30'),
(110, N'Forja',             6, 10, 305, '2023-10-31'),
(111, N'Marea Alta',        7, 11, 356, '2026-05-19'),
(112, N'Rimas de Barrio',   8, 8,  214, '2025-12-01'),
(113, N'Galaxia Dembow',    2, 13, 158, '2026-09-04'),
(114, N'Sin Cobertura',     5, 7,  175, '2026-09-18'),
(115, N'Latido',            7, 11, 330, '2025-07-07');

INSERT INTO dbo.usuarios (usuario_id, nombre_usuario, email, pais, plan_suscripcion, fecha_alta) VALUES
(1, N'alexbeats',  N'alex.beats@mail.com',  'ES', N'Premium',  '2025-01-10'),
(2, N'marta_rock', N'marta.rock@mail.com',  'ES', N'Free',     '2025-06-02'),
(3, N'juanpi',     N'juanpi@mail.com',      'MX', N'Premium',  '2024-11-20'),
(4, N'sofi.trap',  N'sofi.trap@mail.com',   'AR', N'Familiar', '2026-02-14'),
(5, N'dani_dj',    N'dani.dj@mail.com',     'CO', N'Free',     '2026-08-30'),
(6, N'lucia.m',    N'lucia.m@mail.com',     'ES', N'Premium',  '2026-09-01'),
(7, N'nachox',     N'nachox@mail.com',      'MX', N'Free',     '2025-03-18'),
(8, N'vale_indie', N'vale.indie@mail.com',  'AR', N'Premium',  '2026-05-05');

INSERT INTO dbo.reproducciones (reproduccion_id, usuario_id, cancion_id, fecha_hora, segundos_escuchados, dispositivo, tipo_contenido) VALUES
(1,  1, 103,  '2026-09-14 08:15', 176, N'Móvil',      N'Canción'),
(2,  1, 108,  '2026-09-14 08:18', 167, N'Móvil',      N'Canción'),
(3,  1, 103,  '2026-09-14 19:40', 176, N'Web',        N'Canción'),
(4,  2, 106,  '2026-09-14 10:02', 234, N'Web',        N'Canción'),
(5,  2, NULL, '2026-09-14 10:06', 30,  N'Web',        N'Anuncio'),
(6,  2, 110,  '2026-09-14 10:07', 120, N'Web',        N'Canción'),
(7,  3, 105,  '2026-09-14 23:10', 412, N'Escritorio', N'Canción'),
(8,  3, 111,  '2026-09-15 00:05', 356, N'Escritorio', N'Canción'),
(9,  4, 108,  '2026-09-15 17:30', 167, N'Móvil',      N'Canción'),
(10, 4, 109,  '2026-09-15 17:33', 20,  N'Móvil',      N'Canción'),
(11, 4, 103,  '2026-09-15 17:35', 176, N'Móvil',      N'Canción'),
(12, 5, NULL, '2026-09-15 21:00', 30,  N'Móvil',      N'Anuncio'),
(13, 5, 111,  '2026-09-15 21:01', 356, N'Móvil',      N'Canción'),
(14, 1, 101,  '2026-09-16 07:50', 185, N'Móvil',      N'Canción'),
(15, 6, 101,  '2026-09-16 12:00', 185, N'Smart TV',   N'Canción'),
(16, 6, 102,  '2026-09-16 12:04', 201, N'Smart TV',   N'Canción'),
(17, 6, 101,  '2026-09-16 12:08', 15,  N'Smart TV',   N'Canción'),
(18, 7, 112,  '2026-09-16 16:20', 214, N'Móvil',      N'Canción'),
(19, 7, NULL, '2026-09-16 16:24', 30,  N'Móvil',      N'Anuncio'),
(20, 7, 104,  '2026-09-16 16:25', 190, N'Móvil',      N'Canción'),
(21, 3, 106,  '2026-09-17 09:10', 234, N'Web',        N'Canción'),
(22, 3, 107,  '2026-09-17 09:14', 198, N'Web',        N'Canción'),
(23, 2, 107,  '2026-09-17 18:45', 198, N'Móvil',      N'Canción'),
(24, 4, 113,  '2026-09-18 20:00', 158, N'Móvil',      N'Canción'),
(25, 4, 103,  '2026-09-18 20:03', 176, N'Móvil',      N'Canción'),
(26, 1, 113,  '2026-09-18 22:30', 158, N'Móvil',      N'Canción'),
(27, 5, 105,  '2026-09-19 02:15', 200, N'Móvil',      N'Canción'),
(28, 6, 109,  '2026-09-19 11:00', 182, N'Smart TV',   N'Canción'),
(29, 7, 103,  '2026-09-19 13:40', 176, N'Móvil',      N'Canción'),
(30, 1, 103,  '2026-09-20 09:05', 176, N'Móvil',      N'Canción'),
(31, 3, 112,  '2026-09-20 10:30', 214, N'Escritorio', N'Canción'),
(32, 2, NULL, '2026-09-20 18:00', 30,  N'Web',        N'Anuncio'),
(33, 2, 106,  '2026-09-20 18:01', 234, N'Web',        N'Canción');

-- Lote recibido el 21/09: las filas 32 y 33 llegan repetidas (ya estaban cargadas)
INSERT INTO dbo.stg_reproducciones (reproduccion_id, usuario_id, cancion_id, fecha_hora, segundos_escuchados, dispositivo, tipo_contenido) VALUES
(32, 2, NULL, '2026-09-20 18:00', 30,  N'Web',        N'Anuncio'),
(33, 2, 106,  '2026-09-20 18:01', 234, N'Web',        N'Canción'),
(34, 6, 113,  '2026-09-21 08:00', 158, N'Smart TV',   N'Canción'),
(35, 4, 114,  '2026-09-21 18:30', 22,  N'Móvil',      N'Canción'),
(36, 3, 110,  '2026-09-21 21:00', 305, N'Escritorio', N'Canción'),
(37, 5, NULL, '2026-09-21 22:00', 30,  N'Móvil',      N'Anuncio'),
(38, 5, 104,  '2026-09-21 22:01', 190, N'Móvil',      N'Canción');

-- Lote de altas: los usuarios 6 y 8 ya existen
INSERT INTO dbo.stg_usuarios (usuario_id, nombre_usuario, email, pais, plan_suscripcion, fecha_alta) VALUES
(6,  N'lucia.m',      N'lucia.m@mail.com',      'ES', N'Premium', '2026-09-01'),
(8,  N'vale_indie',   N'vale.indie@mail.com',   'AR', N'Premium', '2026-05-05'),
(9,  N'pau.synth',    N'pau.synth@mail.com',    'ES', N'Free',    '2026-09-21'),
(10, N'kiara_perreo', N'kiara.perreo@mail.com', 'PR', N'Premium', '2026-09-21');

INSERT INTO dbo.empleados (empleado_id, nombre, puesto, jefe_id) VALUES
(1,  N'Irene Salas',   N'CEO',               NULL),
(2,  N'Tomás Vidal',   N'CTO',               1),
(3,  N'Nuria Campos',  N'CMO',               1),
(4,  N'Raúl Benet',    N'Head of Data',      2),
(5,  N'Elena Ruiz',    N'Data Engineer',     4),
(6,  N'Pablo Ortega',  N'Data Engineer',     4),
(7,  N'Carmen Lozano', N'Data Analyst',      4),
(8,  N'Hugo Marín',    N'Backend Lead',      2),
(9,  N'Laura Gil',     N'Marketing Manager', 3),
(10, N'Andrés Pozo',   N'Community Manager', 9);
GO

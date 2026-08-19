-- =========================================================
-- Base de datos: Instituto de Idiomas
-- Actividad: LEFT JOIN, RIGHT JOIN e INNER JOIN
-- MySQL 8.x
--
-- NOTA DOCENTE: los datos contienen trampas deliberadas.
-- No "limpiar" la base antes de entregarla a los alumnos.
-- =========================================================

DROP DATABASE IF EXISTS instituto_idiomas;
CREATE DATABASE instituto_idiomas
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE instituto_idiomas;

-- ---------------------------------------------------------
-- TABLAS
-- ---------------------------------------------------------

CREATE TABLE profesores (
  id_profesor INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(50)  NOT NULL,
  apellido    VARCHAR(50)  NOT NULL,
  idioma      VARCHAR(30)  NOT NULL,
  email       VARCHAR(100)
);

CREATE TABLE alumnos (
  id_alumno   INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(50)  NOT NULL,
  apellido    VARCHAR(50)  NOT NULL,
  email       VARCHAR(100),
  fecha_alta  DATE         NOT NULL
);

CREATE TABLE cursos (
  id_curso    INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(60)  NOT NULL,
  idioma      VARCHAR(30)  NOT NULL,
  nivel       VARCHAR(10)  NOT NULL,
  id_profesor INT NULL,                      -- TRAMPA: admite NULL
  CONSTRAINT fk_curso_profesor
    FOREIGN KEY (id_profesor) REFERENCES profesores(id_profesor)
);

CREATE TABLE inscripciones (
  id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
  id_alumno      INT NOT NULL,
  id_curso       INT NOT NULL,
  fecha_insc     DATE NOT NULL,
  nota           DECIMAL(4,2) NULL,          -- TRAMPA: admite NULL
  CONSTRAINT fk_insc_alumno
    FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
  CONSTRAINT fk_insc_curso
    FOREIGN KEY (id_curso)  REFERENCES cursos(id_curso)
);

-- ---------------------------------------------------------
-- DATOS
-- ---------------------------------------------------------

INSERT INTO profesores (nombre, apellido, idioma, email) VALUES
('Elena',  'Ruiz',    'Inglés',   'eruiz@instituto.edu.ar'),
('Marco',  'Bianchi', 'Italiano', 'mbianchi@instituto.edu.ar'),
('Yuna',   'Park',    'Coreano',  NULL),               -- sin cursos a cargo
('Pierre', 'Duval',   'Francés',  'pduval@instituto.edu.ar');

INSERT INTO alumnos (nombre, apellido, email, fecha_alta) VALUES
('Marcela', 'Ríos',    'marcela.rios@mail.com',  '2025-03-04'),
('Julián',  'Ferreyra','jferreyra@mail.com',     '2025-03-06'),
('Ana',     'Ledesma', 'aledesma@mail.com',      '2025-03-11'),
('Bruno',   'Costa',   NULL,                     '2025-04-02'),  -- sin inscripciones
('Sofía',   'Almada',  'salmada@mail.com',       '2025-04-15'),
('Tomás',   'Vega',    'tvega@mail.com',         '2025-08-01'),  -- sin inscripciones
('Lucía',   'Benítez', 'lbenitez@mail.com',      '2025-03-19');

INSERT INTO cursos (nombre, idioma, nivel, id_profesor) VALUES
('Inglés Inicial',     'Inglés',    'A1', 1),
('Inglés Intermedio',  'Inglés',    'B2', 1),
('Italiano Inicial',   'Italiano',  'A1', 2),
('Portugués Inicial',  'Portugués', 'A1', NULL),  -- curso SIN profesor
('Francés Inicial',    'Francés',   'A1', 4),     -- curso SIN inscriptos
('Coreano Inicial',    'Coreano',   'A1', NULL);  -- sin profesor Y sin inscriptos

INSERT INTO inscripciones (id_alumno, id_curso, fecha_insc, nota) VALUES
(1, 1, '2025-03-10', 8.00),
(1, 3, '2025-03-12', NULL),   -- cursando, sin nota
(2, 1, '2025-03-10', 6.50),
(3, 2, '2025-03-15', 9.00),
(5, 4, '2025-04-20', NULL),   -- curso sin profesor
(7, 1, '2025-03-20', 4.00),
(3, 3, '2025-03-16', 7.25),
(5, 1, '2025-04-18', NULL);

-- ---------------------------------------------------------
-- VERIFICACIÓN RÁPIDA
-- ---------------------------------------------------------
-- SELECT COUNT(*) FROM profesores;     -- 4
-- SELECT COUNT(*) FROM alumnos;        -- 7
-- SELECT COUNT(*) FROM cursos;         -- 6
-- SELECT COUNT(*) FROM inscripciones;  -- 8

-- ============================================================================
-- SCRIPT DE CREACIÓN Y POBLADO DE LA BASE DE DATOS: colegio_db
-- Unidad Curricular: Base de Datos
-- Tema: Funciones en MySQL
-- ============================================================================

DROP DATABASE IF EXISTS colegio_db;
CREATE DATABASE colegio_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE colegio_db;

-- ----------------------------------------------------------------------------
-- Tabla 1: CURSOS
-- ----------------------------------------------------------------------------
CREATE TABLE cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_curso VARCHAR(100) NOT NULL,
    turno ENUM('M', 'T', 'N') NOT NULL COMMENT 'M: Mañana, T: Tarde, N: Noche'
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- Tabla 2: ALUMNOS
-- ----------------------------------------------------------------------------
CREATE TABLE alumnos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) DEFAULT NULL,
    fecha_nac DATE NOT NULL,
    fecha_inscripcion DATE NOT NULL,
    curso_id INT,
    FOREIGN KEY (curso_id) REFERENCES cursos(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- Tabla 3: NOTAS
-- ----------------------------------------------------------------------------
CREATE TABLE notas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    alumno_id INT NOT NULL,
    curso_id INT NOT NULL,
    nota DECIMAL(4,2) DEFAULT NULL, -- Admite NULL deliberadamente para ejercitar IFNULL/AVG
    anio INT NOT NULL,
    FOREIGN KEY (alumno_id) REFERENCES alumnos(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES cursos(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- Tabla 4: PRODUCTOS (Material Didáctico y Librería)
-- ----------------------------------------------------------------------------
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

-- ============================================================================
-- INSERCIÓN DE DATOS DE PRUEBA (DATASETS)
-- ============================================================================

-- Insertar Cursos
INSERT INTO cursos (nombre_curso, turno) VALUES
('Programación Web I', 'M'),
('Bases de Datos Relacionales', 'T'),
('Análisis de Sistemas', 'N'),
('Redes y Seguridad', 'M');

-- Insertar Alumnos (Incluye nombres con tildes/ñ para ejercitar CHAR_LENGTH vs LENGTH,
-- correos institucionales y fechas de nacimiento variadas para cálculo de edad)
INSERT INTO alumnos (nombre, apellido, email, fecha_nac, fecha_inscripcion, curso_id) VALUES
('Ana', 'Paz', 'ana.paz@colegio.edu.ar', '2005-04-12', '2026-02-15', 1),
('Martín', 'Ñáñez', 'm.nanez@gmail.com', '2004-09-25', '2026-02-20', 1),
('Sofía', 'Gómez', 'sofia_gomez@hotmail.com', '2006-01-05', '2026-03-01', 2),
('Lucas', 'Fernández', NULL, '2003-11-30', '2026-02-10', 2),
('María', 'Ríos', 'mrios@colegio.edu.ar', '2005-07-18', '2026-02-18', 3),
('Gonzalo', 'Ibáñez', 'gonza.ibanez@yahoo.com', '2002-12-01', '2026-03-05', 3),
('Lucía', 'Álvarez', 'lalvarez@colegio.edu.ar', '2004-05-14', '2026-02-22', 4),
('Esteban', 'Quito', 'equito@outlook.com', '2005-08-20', '2026-03-02', 4);

-- Insertar Notas (Incluye valores NULL para ejercitar el impacto de NULL en AVG/COUNT)
INSERT INTO notas (alumno_id, curso_id, nota, anio) VALUES
(1, 1, 9.50, 2026),
(1, 1, 8.00, 2026),
(2, 1, 5.50, 2026),
(2, 1, 4.00, 2026),
(3, 2, 10.00, 2026),
(3, 2, 8.50, 2026),
(4, 2, NULL, 2026),  -- Nota ausente/no rendida
(4, 2, 6.00, 2026),
(5, 3, 7.00, 2026),
(5, 3, 9.00, 2026),
(6, 3, 3.50, 2026),
(6, 3, 2.00, 2026),
(7, 4, 8.50, 2026),
(7, 4, 9.00, 2026),
(8, 4, NULL, 2026),  -- Nota ausente
(8, 4, 5.00, 2026);

-- Insertar Productos
INSERT INTO productos (nombre, precio) VALUES
('Manual de MySQL 8.0', 12500.459),
('Cuaderno Anillado A4', 3200.750),
('Pen Drive 64GB USB 3.0', 8999.990),
('Set de Marcadores de Pizarra', 4150.333),
('Cable Red UTP Categoría 6 (5m)', 2850.500);
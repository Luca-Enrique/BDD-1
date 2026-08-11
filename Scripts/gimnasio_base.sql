-- ============================================================
-- Base de datos: GIMNASIO
-- Para practicar ALTER, DELETE, UPDATE, SELECT y JOIN
-- Motor: MySQL / MariaDB
-- ============================================================

DROP DATABASE IF EXISTS gimnasio;
CREATE DATABASE gimnasio;
USE gimnasio;

-- ── Tabla central ───────────────────────────────────────────
CREATE TABLE socios (
  idsocio INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(30) NOT NULL,
  apellido VARCHAR(30) NOT NULL,
  fecha_nac DATE,
  dni INT,
  plan VARCHAR(20)
);

-- ── Equivale a "notas": tres valores numéricos + un texto ───
CREATE TABLE rutinas (
  idrutina INT AUTO_INCREMENT PRIMARY KEY,
  idsocio INT NOT NULL,
  series INT,
  repeticiones INT,
  peso_kg DECIMAL(5,2),
  ejercicio VARCHAR(40),
  FOREIGN KEY (idsocio) REFERENCES socios(idsocio)
);

-- ── Equivale a "asistencia" ─────────────────────────────────
CREATE TABLE asistencias (
  idasistencia INT AUTO_INCREMENT PRIMARY KEY,
  idsocio INT NOT NULL,
  fecha_ingreso DATE,
  actividad VARCHAR(30),
  FOREIGN KEY (idsocio) REFERENCES socios(idsocio)
);

-- ── Para practicar curdate() ────────────────────────────────
CREATE TABLE ventas (
  idventa INT AUTO_INCREMENT PRIMARY KEY,
  producto VARCHAR(40) NOT NULL,
  monto_vendido DECIMAL(10,2),
  fecha_venta DATE
);

-- ============================================================
-- DATOS DE PRUEBA
-- ============================================================

INSERT INTO socios VALUES
(DEFAULT, 'Lucía',   'Juarez',   '1998-04-12', 41111111, 'mensual'),
(DEFAULT, 'Martín',  'Juárez',   '2001-09-03', 42222222, 'anual'),
(DEFAULT, 'Camila',  'Giménez',  '1998-11-27', 43333333, 'mensual'),
(DEFAULT, 'Nahuel',  'Ferreyra', '2005-04-08', 44444444, 'trimestral'),
(DEFAULT, 'Sofía',   'Almada',   '1990-02-19', 45555555, 'anual'),
(DEFAULT, 'Julián',  'Sosa',     '1998-04-30', 46666666, 'mensual'),
(DEFAULT, 'Brenda',  'Barrios',  '2003-07-15', 47777777, 'mensual'),
(DEFAULT, 'Matías',  'Ledesma',  '1996-12-01', 48888888, 'anual'),
(DEFAULT, 'Micaela', 'Duarte',   '2005-04-22', 49999999, 'trimestral'),
(DEFAULT, 'Tomás',   'Ríos',     '1993-06-06', 40000000, 'mensual');

INSERT INTO rutinas VALUES
(DEFAULT, 1,  4, 12,  30.00, 'Sentadilla'),
(DEFAULT, 1,  3, 10,  45.50, 'Press banca'),
(DEFAULT, 2,  4,  8,  70.00, 'Peso muerto'),
(DEFAULT, 3,  3, 15,  20.00, 'Remo con barra'),
(DEFAULT, 4,  5, 20,  12.50, 'Estocadas'),
(DEFAULT, 5,  4, 12,  35.00, 'Sentadilla'),
(DEFAULT, 6,  3,  6,  85.00, 'Peso muerto'),
(DEFAULT, 7,  4, 15,  15.00, 'Elevaciones laterales'),
(DEFAULT, 8,  5, 10,  60.00, 'Press militar'),
(DEFAULT, 9,  3, 12,  25.00, 'Remo con mancuernas'),
(DEFAULT, 10, 4, 20,   8.00, 'Bíceps con barra');

INSERT INTO asistencias VALUES
(DEFAULT, 1,  '2026-04-06', 'Musculación'),
(DEFAULT, 1,  '2026-04-13', 'Funcional'),
(DEFAULT, 2,  '2026-04-07', 'Musculación'),
(DEFAULT, 3,  '2026-03-10', 'Spinning'),
(DEFAULT, 5,  '2026-04-21', 'Funcional'),
(DEFAULT, 6,  '2025-11-18', 'Musculación'),
(DEFAULT, 7,  '2026-04-02', 'Spinning'),
(DEFAULT, 8,  '2026-02-24', 'Musculación'),
(DEFAULT, 9,  '2026-04-29', 'Funcional'),
(DEFAULT, 10, '2025-12-05', 'Musculación');

INSERT INTO ventas VALUES
(DEFAULT, 'Proteína en polvo 1kg',   38000.00, CURDATE()),
(DEFAULT, 'Botella térmica',          9500.00, CURDATE()),
(DEFAULT, 'Guantes de entrenamiento', 7200.00, '2026-07-30'),
(DEFAULT, 'Cinturón de levantamiento',24500.00,'2026-07-28'),
(DEFAULT, 'Barrita proteica',         2800.00, CURDATE());

SELECT * FROM socios;
SELECT * FROM rutinas;
SELECT * FROM asistencias;
SELECT * FROM ventas;

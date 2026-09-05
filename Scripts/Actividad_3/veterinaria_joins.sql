-- ============================================================
-- Base de datos: veterinaria_joins
-- Trabajo Práctico — Consultas con JOIN
-- ============================================================

DROP DATABASE IF EXISTS veterinaria_joins;
CREATE DATABASE veterinaria_joins CHARACTER SET utf8mb4;
USE veterinaria_joins;

-- ============================================================
-- 1. ESTRUCTURA
-- ============================================================

CREATE TABLE sucursales (
    id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    direccion VARCHAR(120) NOT NULL
);

CREATE TABLE duenios (
    id_duenio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    apellido VARCHAR(60) NOT NULL,
    telefono VARCHAR(20)
);

CREATE TABLE mascotas (
    id_mascota INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    especie VARCHAR(30) NOT NULL,
    raza VARCHAR(50),
    edad INT,
    id_duenio INT NULL,
    FOREIGN KEY (id_duenio) REFERENCES duenios(id_duenio)
);

CREATE TABLE veterinarios (
    id_veterinario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    apellido VARCHAR(60) NOT NULL,
    matricula VARCHAR(30) NOT NULL UNIQUE,
    id_sucursal INT NULL,
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal)
);

CREATE TABLE turnos (
    id_turno INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME NOT NULL,
    estado ENUM('pendiente', 'atendido', 'cancelado') NOT NULL,
    id_mascota INT NOT NULL,
    id_veterinario INT NOT NULL,
    FOREIGN KEY (id_mascota) REFERENCES mascotas(id_mascota),
    FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id_veterinario)
);

CREATE TABLE tratamientos (
    id_tratamiento INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE turnos_tratamientos (
    id_turno INT NOT NULL,
    id_tratamiento INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_turno, id_tratamiento),
    FOREIGN KEY (id_turno) REFERENCES turnos(id_turno),
    FOREIGN KEY (id_tratamiento) REFERENCES tratamientos(id_tratamiento)
);

CREATE TABLE vacunas (
    id_vacuna INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    especie VARCHAR(30) NOT NULL
);

CREATE TABLE aplicaciones (
    id_aplicacion INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    id_mascota INT NOT NULL,
    id_vacuna INT NOT NULL,
    FOREIGN KEY (id_mascota) REFERENCES mascotas(id_mascota),
    FOREIGN KEY (id_vacuna) REFERENCES vacunas(id_vacuna)
);

-- ============================================================
-- 2. DATOS
-- Los datos están preparados para que los JOIN del práctico
-- tengan casos con y sin coincidencias.
-- ============================================================

INSERT INTO sucursales (nombre, direccion) VALUES
('Sucursal Centro', 'Urquiza 120'),
('Sucursal Norte', 'Av. Ramírez 850'),
('Sucursal Sur', 'Almafuerte 1450'),
('Sucursal Este', 'Blas Parera 2100');

INSERT INTO duenios (nombre, apellido, telefono) VALUES
('Laura', 'Benitez', '343-4567890'),
('Martin', 'Sosa', '343-4123456'),
('Carla', 'Gutierrez', '343-4998877'),
('Diego', 'Fernandez', '343-4332211'),
('Sofia', 'Martinez', '343-4556677');

INSERT INTO mascotas (nombre, especie, raza, edad, id_duenio) VALUES
('Rocco', 'Perro', 'Labrador', 4, 1),
('Michi', 'Gato', 'Siames', 2, 1),
('Luna', 'Perro', 'Caniche', 7, 2),
('Pelusa', 'Gato', 'Mestizo', 1, 3),
('Toby', 'Perro', 'Beagle', 5, 4),
('Nina', 'Gato', 'Mestizo', 3, 4),
('Coco', 'Conejo', 'Enano', 2, 5),
('Simba', 'Perro', 'Mestizo', 6, NULL);

INSERT INTO veterinarios (nombre, apellido, matricula, id_sucursal) VALUES
('Ana', 'Pereyra', 'MP-1001', 1),
('Bruno', 'Gomez', 'MP-1002', 1),
('Camila', 'Rossi', 'MP-1003', 2),
('Diego', 'Acosta', 'MP-1004', 3),
('Elena', 'Suarez', 'MP-1005', NULL);

INSERT INTO tratamientos (descripcion, precio) VALUES
('Consulta general', 8000.00),
('Desparasitación', 5000.00),
('Limpieza dental', 12000.00),
('Radiografía', 15000.00),
('Curación de herida', 9000.00),
('Control postoperatorio', 7000.00);

INSERT INTO turnos (fecha, estado, id_mascota, id_veterinario) VALUES
('2026-08-01 09:00:00', 'atendido', 1, 1),
('2026-08-02 10:30:00', 'atendido', 2, 2),
('2026-08-03 11:00:00', 'pendiente', 3, 3),
('2026-08-04 15:00:00', 'cancelado', 4, 1),
('2026-08-05 09:30:00', 'atendido', 5, 4),
('2026-08-06 12:00:00', 'atendido', 1, 1),
('2026-08-07 16:00:00', 'pendiente', 6, 3),
('2026-08-08 10:00:00', 'atendido', 4, 2),
('2026-08-09 14:30:00', 'cancelado', 7, 4);

INSERT INTO turnos_tratamientos (id_turno, id_tratamiento, cantidad) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 1, 1),
(2, 3, 1),
(3, 1, 1),
(4, 1, 1),
(5, 1, 1),
(5, 4, 2),
(6, 1, 1),
(6, 5, 1),
(7, 1, 1),
(8, 1, 1),
(8, 2, 2),
(9, 1, 1),
(9, 6, 1);

INSERT INTO vacunas (nombre, especie) VALUES
('Rabia', 'Perro'),
('Quíntuple', 'Perro'),
('Triple Felina', 'Gato'),
('Leucemia Felina', 'Gato'),
('Mixomatosis', 'Conejo'),
('Vacuna Experimental', 'Perro');

INSERT INTO aplicaciones (fecha, id_mascota, id_vacuna) VALUES
('2026-01-10', 1, 1),
('2026-02-15', 1, 2),
('2026-03-20', 2, 3),
('2026-04-12', 3, 1),
('2026-05-18', 4, 3),
('2026-06-05', 5, 1),
('2026-07-01', 1, 1),
('2026-07-20', 6, 4);

-- ============================================================
-- 3. VERIFICACIONES OPCIONALES
-- ============================================================

-- Cantidad de registros de cada tabla:
SELECT 'sucursales' AS tabla, COUNT(*) AS cantidad FROM sucursales
UNION ALL
SELECT 'duenios', COUNT(*) FROM duenios
UNION ALL
SELECT 'mascotas', COUNT(*) FROM mascotas
UNION ALL
SELECT 'veterinarios', COUNT(*) FROM veterinarios
UNION ALL
SELECT 'turnos', COUNT(*) FROM turnos
UNION ALL
SELECT 'tratamientos', COUNT(*) FROM tratamientos
UNION ALL
SELECT 'turnos_tratamientos', COUNT(*) FROM turnos_tratamientos
UNION ALL
SELECT 'vacunas', COUNT(*) FROM vacunas
UNION ALL
SELECT 'aplicaciones', COUNT(*) FROM aplicaciones;

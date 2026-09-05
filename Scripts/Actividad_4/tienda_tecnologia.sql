-- =========================================================
-- Script de creación: Base de datos "tienda_tecnologia"
-- Modelo normalizado: clientes, productos, ventas, detalle_ventas
-- =========================================================

DROP DATABASE IF EXISTS tienda_tecnologia;
CREATE DATABASE tienda_tecnologia;
USE tienda_tecnologia;

-- ---------------------------------------------------------
-- Tabla: clientes
-- ---------------------------------------------------------
CREATE TABLE clientes (
    id_cliente  INT PRIMARY KEY AUTO_INCREMENT,
    nombre      VARCHAR(50) NOT NULL,
    apellido    VARCHAR(50) NOT NULL,
    ciudad      VARCHAR(50) NOT NULL,
    fecha_alta  DATE NOT NULL
);

-- ---------------------------------------------------------
-- Tabla: productos
-- ---------------------------------------------------------
CREATE TABLE productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre      VARCHAR(100) NOT NULL,
    categoria   VARCHAR(50) NOT NULL,
    precio      DECIMAL(10,2) NOT NULL,
    stock       INT NOT NULL
);

-- ---------------------------------------------------------
-- Tabla: ventas (cabecera)
-- ---------------------------------------------------------
CREATE TABLE ventas (
    id_venta    INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente  INT NOT NULL,
    fecha_venta DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- ---------------------------------------------------------
-- Tabla: detalle_ventas
-- ---------------------------------------------------------
CREATE TABLE detalle_ventas (
    id_detalle      INT PRIMARY KEY AUTO_INCREMENT,
    id_venta        INT NOT NULL,
    id_producto     INT NOT NULL,
    cantidad        INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- =========================================================
-- Carga de datos de ejemplo
-- =========================================================

-- ---------------------------------------------------------
-- Clientes
-- ---------------------------------------------------------
INSERT INTO clientes (nombre, apellido, ciudad, fecha_alta) VALUES
('Lucía',    'Gómez',    'Paraná',       '2025-03-10'),
('Martín',   'Fernández','Nogoyá',       '2025-07-22'),
('Sofía',    'López',    'Paraná',       '2024-11-05'),
('Diego',    'Rodríguez','Concordia',    '2025-01-18'),
('Valentina','Sánchez',  'Gualeguaychú', '2025-09-30'),
('Nicolás',  'Torres',   'Paraná',       '2024-05-14'),
('Camila',   'Díaz',     'Victoria',     '2025-02-27'),
('Federico', 'Romero',   'Nogoyá',       '2025-12-01');

-- ---------------------------------------------------------
-- Productos
-- ---------------------------------------------------------
INSERT INTO productos (nombre, categoria, precio, stock) VALUES
('Notebook Acer Aspire 5',      'Notebook',    450000.00, 8),
('Notebook Lenovo IdeaPad',     'Notebook',    380000.00, 3),
('Notebook Asus VivoBook Pro',  'Notebook',    620000.00, 5),
('Mouse Logitech Pro',          'Accesorios',   35000.00, 25),
('Teclado Mecánico HyperX',     'Accesorios',   85000.00, 12),
('Monitor Samsung 24"',         'Monitores',   210000.00, 7),
('Monitor LG UltraWide',        'Monitores',   350000.00, 4),
('Auriculares Sony',            'Audio',        95000.00, 15),
('Auriculares Pro Gamer',       'Audio',       120000.00, 9),
('Impresora Epson',             'Impresoras',  180000.00, 6),
('Disco SSD 1TB',               'Almacenamiento', 75000.00, 20),
('Placa de Video Asus Pro',     'Componentes', 780000.00, 2),
('Webcam Logitech',             'Accesorios',   60000.00, 10),
('Tablet Samsung',              'Tablets',     280000.00, 6),
('Router TP-Link',              'Redes',        45000.00, 18);

-- ---------------------------------------------------------
-- Ventas (cabecera)
-- ---------------------------------------------------------
INSERT INTO ventas (id_cliente, fecha_venta) VALUES
(1, '2026-01-05'),
(2, '2026-01-12'),
(3, '2025-12-20'),
(1, '2026-02-03'),
(4, '2026-02-15'),
(5, '2026-03-01'),
(6, '2026-03-10'),
(2, '2026-03-22'),
(7, '2026-04-02'),
(8, '2026-04-18'),
(3, '2026-05-05'),
(1, '2026-05-20');

-- ---------------------------------------------------------
-- Detalle de ventas
-- ---------------------------------------------------------
INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES
(1, 1, 1, 450000.00),
(1, 4, 2, 35000.00),
(2, 6, 1, 210000.00),
(3, 8, 2, 95000.00),
(4, 3, 1, 620000.00),
(4, 5, 1, 85000.00),
(5, 11, 3, 75000.00),
(6, 2, 1, 380000.00),
(6, 13, 1, 60000.00),
(7, 9, 4, 120000.00),
(8, 7, 1, 350000.00),
(9, 10, 1, 180000.00),
(9, 15, 2, 45000.00),
(10, 12, 1, 780000.00),
(11, 14, 2, 280000.00),
(12, 1, 1, 450000.00),
(12, 6, 2, 210000.00);

/* 1) Crear la Base de Datos y definir las tablas correspondientes al modelo de datos proporcionado, utilizando sentencias SQL. 
Se deberán contemplar las claves primarias, las claves foráneas y las restricciones necesarias para garantizar la integridad de los datos.

a) En la tabla Productos, establecer restricciones que impidan registrar valores negativos en los campos 'precio_unitario' y 'stock'.
*/

CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE clientes (
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    email VARCHAR(80) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    fecha_registro DATE NOT NULL
);

CREATE TABLE productos (
	id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(40) NOT NULL,
    descripcion VARCHAR(50) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

CREATE TABLE pedidos (
	id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    monto_total DECIMAL(10,2) NOT NULL,
    estado_envio VARCHAR(15) NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente)
    REFERENCES clientes (id_cliente)
);

CREATE TABLE detalle_pedidos (
	id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_historico DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_pedidos FOREIGN KEY (id_pedido)
    REFERENCES pedidos (id_pedido),
    CONSTRAINT fk_productos FOREIGN KEY (id_producto)
    REFERENCES productos (id_producto)
);

# 2) Incorporar un nuevo campo en la tabla de productos para clasificar la categoría comercial a la que pertenecen.

# MI RESPUESTA
ALTER TABLE productos (
	categoria_comercial VARCHAR(60) NOT NULL
);

# RESPUESTA CORRECTA
ALTER TABLE productos ADD COLUMN (
	categoria_comercial VARCHAR(60) NOT NULL
);

# 3) Registrar 2 nuevos productos en el catálogo de la tienda virtual.

INSERT INTO productos VALUES
(DEFAULT, 'teclado', 'teclado inalambrico REDRAGON', 10000, 5, 'perifericos'),
(DEFAULT, 'Ratón', 'Ratón inalambrico REDRAGON', 5000, 10, 'perifericos');

/*  # La correción pide ¿qué campos?, 
en my sql no hace falta agregar los campos si declaramos todos los valores, 
desde el id hasta la ultima columna, en este caso la categoria_comercial, 
en el orden en el que están definidas dentro de la tabla, 
por ende, si miramos la consulta, podemos ver que esta se encuentra bien definida y es una copia textual de mi respuesta del parcial.
*/

# 4) Actualizar el precio unitario de un producto debido a modificaciones en la lista de costos.
# MI RESPUESTA
UPDATE productos
SET precio_unitario = 7000
WHERE nombre = 'Ratón';

/* Nuevamente se me corrige mediante '¿Qué campos?
Si leemos el enunciado y mi respuesta, podemos destacar que, dentro de ella, no hay ningun error de syntax y cumple con lo que pide la consigna,
podemos discutir si faltan buenas practicas con el hecho del id, pero dentro del enunciado en ningun momento aclara expliciatemente que el producto debe ser
'encontrado' por algun identificador unico, a mi se me planeó un problema y yo desarrollé mi logica.
*/

# 5) Dar de baja a un cliente que ha solicitado la eliminación de su cuenta en la plataforma.

DELETE FROM clientes
WHERE nombre = 'Luca' and apellido = 'Enrique';

/* Repito lo anterior, no hay errores de syntax, y mi respuesta cumple con el enunciado, en este caso
si analizamos la logica, elimina de la tabla clientes cuando coincide un nombre y un apellido, 
al efectuar esto, se puede dar de baja correctamente un usuario registrado, que es lo que pide la consigna, 
nuevamente no indica explisitamente que debe ser mediante algun identificador unico, implementé mi logica.
*/

# 6) Listar aquellos productos que se encuentren dentro de un rango de precios determinado y que dispongan de stock fisico mayor a cero.
SELECT nombre, precio_unitario, stock
FROM productos
WHERE precio_unitario BETWEEN 5000 AND 15000 AND stock >= 1;

# 7) Elaborar un informe completo de ventas que vincule el código del pedido, los datos del cliente que lo efectuó, los productos incluidos en el detalle, las cantidades y los precios históricos.
SELECT CONCAT(c.nombre, ' ', c.apellido) AS cliente, c.email, c.direccion, c.fecha_registro, pe.id_pedido AS codigo_pedido, pe.monto_total, pro.nombre AS producto, dp.cantidad, dp.precio_historico
FROM productos pro
INNER JOIN detalle_pedidos dp ON pro.id_producto = dp.id_producto
INNER JOIN pedidos pe ON dp.id_pedido = pe.id_pedido
INNER JOIN clientes c ON pe.id_cliente = c.id_cliente;

# 8) Calcular el subtotal monetario de cada ſtem en el detalle de un pedido (multiplicando cantidad por precio histórico), mostrando el resultado redondeado a dos cifras decimales.
SELECT pro.nombre, dp.cantidad, dp.precio_historico, ROUND(dp.cantidad * dp.precio_historico, 2) AS subtotal
FROM detalle_pedidos dp
INNER JOIN productos pro ON dp.id_producto = pro.id_producto;

# 9) Obtener la sumatoria total de dinero gastado por cada cliente en la plataforma, filtrando y mostrando exclusivamente a aquellos cuyo volumen de compras supere un monto acumulado determinado.
# MI RESPUESTA
SELECT CONCAT(c.nombre, ' ', c.apellido) AS cliente, pe.monto_total
FROM pedidos pe
INNER JOIN clientes c ON pe.id_cliente = c.id_cliente
GROUP BY c.id_cliente
HAVING pe.monto_total >= 50000;

# 10) Identificar y mostrar los datos del producto más caro registrado en todo el catálogo de la tienda.
# Mi respuesta
SELECT nombre, descripcion, precio_unitario, stock
FROM productos
WHERE id_producto = (SELECT id_producto, MAX(precio_unitario) FROM productos);
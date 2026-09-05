use tienda_tecnologia;

# 1. Mostrar los productos cuyo precio sea mayor a $100.000.
SELECT nombre, categoria, precio FROM productos WHERE precio > 100000;

# 2. Mostrar los productos cuyo precio esté entre $50.000 y $150.000.
SELECT nombre, categoria, precio FROM productos WHERE precio BETWEEN 50000 AND 150000;

# 3. Mostrar los productos cuyo stock sea menor o igual a 10.
SELECT nombre, categoria, stock FROM productos WHERE stock <= 10;

# 4. Mostrar los detalles de venta donde la cantidad vendida sea mayor a 3.
SELECT p.nombre AS producto, p.categoria, dv.cantidad, v.fecha_venta
FROM detalle_ventas dv
INNER JOIN ventas v ON dv.id_venta = v.id_venta
INNER JOIN productos p ON dv.id_producto = p.id_producto
WHERE dv.cantidad > 3;

# 5. Mostrar los productos cuyo precio sea diferente de $80.000.
SELECT nombre, categoria, precio FROM productos WHERE precio != 80000;

# 6. Mostrar los clientes que viven en la ciudad de "Paraná".
SELECT nombre, apellido, ciudad FROM clientes WHERE ciudad = 'Parana';

# 7. Mostrar los productos pertenecientes a la categoría "Notebook".
SELECT nombre, categoria FROM productos WHERE categoria = 'Notebook';

# 8. Mostrar los productos cuyo nombre comience con "A".
SELECT nombre, categoria FROM productos WHERE nombre LIKE 'A%';

# 9. Mostrar los productos cuyo nombre contenga la palabra "Pro".
SELECT nombre, categoria FROM productos WHERE nombre LIKE '%Pro%';

# 10. Mostrar los clientes cuya ciudad termine en "a".
SELECT nombre, apellido, ciudad FROM clientes WHERE ciudad LIKE '%a';

# 11. Mostrar las ventas realizadas después del 2026-01-01.
SELECT p.nombre AS producto, p.categoria, v.fecha_venta
FROM ventas v
INNER JOIN detalle_ventas dv ON v.id_venta = dv.id_venta
INNER JOIN productos p ON dv.id_producto = p.id_producto
WHERE v.fecha_venta > '2026-01-01';

# 12. Mostrar las ventas realizadas durante el año 2026.
SELECT p.nombre AS producto, p.categoria, v.fecha_venta
FROM ventas v
INNER JOIN detalle_ventas dv ON v.id_venta = dv.id_venta
INNER JOIN productos p ON dv.id_producto = p.id_producto
WHERE v.fecha_venta BETWEEN '2026-01-01' AND '2026-12-31';

# 13. Mostrar los clientes registrados durante el año 2025.
SELECT nombre, apellido, fecha_alta FROM clientes WHERE fecha_alta BETWEEN '2025-01-01' AND '2025-12-31';

# 14. Mostrar las ventas realizadas entre dos fechas determinadas.
SELECT p.nombre AS producto, p.categoria, v.fecha_venta
FROM ventas v
INNER JOIN detalle_ventas dv ON v.id_venta = dv.id_venta
INNER JOIN productos p ON dv.id_producto = p.id_producto
WHERE v.fecha_venta BETWEEN '2025-08-08' AND '2026-08-08';

# 15. Mostrar cada venta indicando fecha, año, mes y día.
SELECT id_venta, fecha_venta, YEAR(fecha_venta) AS anio, MONTH(fecha_venta) AS mes, DAY(fecha_venta) AS dia FROM ventas;

# 16. Mostrar todos los productos ordenados por precio de menor a mayor.
SELECT nombre, categoria, precio FROM productos ORDER BY precio ASC;

# 17. Mostrar todos los productos ordenados por precio de mayor a menor.
SELECT nombre, categoria, precio FROM productos ORDER BY precio DESC;

# 18. Mostrar los clientes ordenados alfabéticamente por apellido.
SELECT nombre, apellido FROM clientes ORDER BY apellido ASC;

# 19. Mostrar las ventas ordenadas desde la más reciente hasta la más antigua.
SELECT p.nombre AS producto, p.categoria, v.fecha_venta
FROM ventas v
INNER JOIN detalle_ventas dv ON v.id_venta = dv.id_venta
INNER JOIN productos p ON dv.id_producto = p.id_producto
ORDER BY v.fecha_venta DESC;

# 20. ¿Cuál es el producto más caro?
SELECT nombre, categoria, precio FROM productos ORDER BY precio DESC LIMIT 1;

# 21. ¿Cuál es el producto más barato?
SELECT nombre, categoria, precio FROM productos ORDER BY precio ASC LIMIT 1;

# 22. ¿Cuál es el precio promedio de los productos?
SELECT AVG(precio) AS precio_promedio FROM productos;

# 23. ¿Cuántas unidades se vendieron en total? (usar `detalle_ventas`)
SELECT SUM(cantidad) AS total_unidades_vendidas FROM detalle_ventas;

# 24. ¿Cuántas unidades se vendieron de cada producto? (usar `detalle_ventas`)
SELECT p.nombre AS producto, SUM(dv.cantidad) AS total_unidades_vendidas
FROM detalle_ventas dv
INNER JOIN productos p ON dv.id_producto = p.id_producto
GROUP BY p.nombre;

# 25. ¿Cuál fue la cantidad máxima de unidades vendidas en una operación? (`detalle_ventas`)
SELECT MAX(cantidad) AS cantidad_maxima FROM detalle_ventas;

# 26. ¿Cuál fue la cantidad mínima de unidades vendidas en una operación? (`detalle_ventas`)
SELECT MIN(cantidad) AS cantidad_maxima FROM detalle_ventas;

# 27. Mostrar cuántos productos hay en cada categoría.
SELECT categoria, COUNT(*) AS cantidad_productos FROM productos GROUP BY categoria;

# 28. Mostrar el precio promedio de cada categoría.
SELECT categoria, ROUND(AVG(precio)) AS precio_promedio FROM productos GROUP BY categoria;

# 29. Mostrar el precio máximo de cada categoría.
SELECT categoria, MAX(precio) AS precio_maximo FROM productos GROUP BY categoria;

# 30. Mostrar el precio mínimo de cada categoría.
SELECT categoria, MIN(precio) AS precio_minimo FROM productos GROUP BY categoria;

# 31. Mostrar la cantidad total vendida de cada producto. (usar `detalle_ventas`)
SELECT p.nombre AS producto, SUM(dv.cantidad) AS total_unidades_vendidas
FROM detalle_ventas dv
INNER JOIN productos p ON dv.id_producto = p.id_producto
GROUP BY p.nombre;

# 32. Mostrar la cantidad de ventas realizadas por cada cliente. (usar tabla `ventas`)
SELECT c.nombre AS cliente, COUNT(v.id_venta) AS cantidad_ventas
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
GROUP BY c.nombre;

# 33. Obtener por cada categoría: cantidad de productos, precio mínimo, precio máximo y precio promedio. Ordenar desde la categoría con mayor precio promedio hasta la menor.
SELECT categoria, COUNT(*) AS cantidad_productos, MIN(precio) AS precio_minimo, MAX(precio) AS precio_maximo, ROUND(AVG(precio)) AS precio_promedio
FROM productos
GROUP BY categoria
ORDER BY precio_promedio DESC;

# 34. Modificar la consulta anterior para mostrar solamente las categorías cuyo precio promedio sea superior a $100.000.
SELECT categoria, COUNT(*) AS cantidad_productos, MIN(precio) AS precio_minimo, MAX(precio) AS precio_maximo, ROUND(AVG(precio)) AS precio_promedio
FROM productos
GROUP BY categoria
HAVING precio_promedio > 100000
ORDER BY precio_promedio DESC;

/* 35. (Extra – JOINs) Mostrar el detalle de cada venta: fecha de la venta, nombre del cliente, nombre del producto, cantidad y precio unitario. 
Ordenar por fecha de venta descendente. 
Pista: necesitarás unir las tablas `ventas`, `detalle_ventas`, `clientes` y `productos` usando `JOIN`.
*/
SELECT v.fecha_venta, c.nombre AS cliente, p.nombre AS producto, dv.cantidad, p.precio
FROM ventas v
INNER JOIN detalle_ventas dv ON v.id_venta = dv.id_venta
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON dv.id_producto = p.id_producto
ORDER BY v.fecha_venta DESC;
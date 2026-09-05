# Actividad práctica: Consultas SQL con MySQL

**Tema:** consultas simples, operadores, fechas, ORDER BY, GROUP BY y funciones de agregación
**Modelo de datos normalizado:** ventas + detalle_ventas

## Situación problemática

Una tienda de tecnología necesita analizar la información de sus ventas. Para un mejor diseño de base de datos, la información de ventas se separó en dos tablas: `ventas` (cabecera de cada operación) y `detalle_ventas` (productos vendidos en cada operación).

## Estructura de las tablas

### Tabla `clientes`

| Campo | Tipo |
|---|---|
| id_cliente | INT |
| nombre | VARCHAR |
| apellido | VARCHAR |
| ciudad | VARCHAR |
| fecha_alta | DATE |

### Tabla `productos`

| Campo | Tipo |
|---|---|
| id_producto | INT |
| nombre | VARCHAR |
| categoria | VARCHAR |
| precio | DECIMAL |
| stock | INT |

### Tabla `ventas` (cabecera)

| Campo | Tipo |
|---|---|
| id_venta | INT |
| id_cliente | INT |
| fecha_venta | DATE |

### Tabla `detalle_ventas`

| Campo | Tipo |
|---|---|
| id_detalle | INT |
| id_venta | INT |
| id_producto | INT |
| cantidad | INT |
| precio_unitario | DECIMAL |

**Relaciones:**
- `ventas.id_cliente` → `clientes.id_cliente`
- `detalle_ventas.id_venta` → `ventas.id_venta`
- `detalle_ventas.id_producto` → `productos.id_producto`

---

## Parte 1 – Operadores con números

1. Mostrar los productos cuyo precio sea mayor a $100.000.
2. Mostrar los productos cuyo precio esté entre $50.000 y $150.000.
3. Mostrar los productos cuyo stock sea menor o igual a 10.
4. Mostrar los detalles de venta donde la cantidad vendida sea mayor a 3.
5. Mostrar los productos cuyo precio sea diferente de $80.000.

## Parte 2 – Operadores con textos

6. Mostrar los clientes que viven en la ciudad de "Paraná".
7. Mostrar los productos pertenecientes a la categoría "Notebook".
8. Mostrar los productos cuyo nombre comience con "A".
9. Mostrar los productos cuyo nombre contenga la palabra "Pro".
10. Mostrar los clientes cuya ciudad termine en "a".

## Parte 3 – Consultas con fechas

11. Mostrar las ventas realizadas después del 2026-01-01.
12. Mostrar las ventas realizadas durante el año 2026.
13. Mostrar los clientes registrados durante el año 2025.
14. Mostrar las ventas realizadas entre dos fechas determinadas.
15. Mostrar cada venta indicando fecha, año, mes y día.

## Parte 4 – Ordenamiento

16. Mostrar todos los productos ordenados por precio de menor a mayor.
17. Mostrar todos los productos ordenados por precio de mayor a menor.
18. Mostrar los clientes ordenados alfabéticamente por apellido.
19. Mostrar las ventas ordenadas desde la más reciente hasta la más antigua.

## Parte 5 – Funciones de agregación

20. ¿Cuál es el producto más caro?
21. ¿Cuál es el producto más barato?
22. ¿Cuál es el precio promedio de los productos?
23. ¿Cuántas unidades se vendieron en total? (usar `detalle_ventas`)
24. ¿Cuántas unidades se vendieron de cada producto? (usar `detalle_ventas`)
25. ¿Cuál fue la cantidad máxima de unidades vendidas en una operación? (`detalle_ventas`)
26. ¿Cuál fue la cantidad mínima de unidades vendidas en una operación? (`detalle_ventas`)

## Parte 6 – GROUP BY

27. Mostrar cuántos productos hay en cada categoría.
28. Mostrar el precio promedio de cada categoría.
29. Mostrar el precio máximo de cada categoría.
30. Mostrar el precio mínimo de cada categoría.
31. Mostrar la cantidad total vendida de cada producto. (usar `detalle_ventas`)
32. Mostrar la cantidad de ventas realizadas por cada cliente. (usar tabla `ventas`)

## Desafío final

33. Obtener por cada categoría: cantidad de productos, precio mínimo, precio máximo y precio promedio. Ordenar desde la categoría con mayor precio promedio hasta la menor.

**Ayuda:**

```sql
SELECT categoria, COUNT(*) AS cantidad_productos,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo,
    AVG(precio) AS precio_promedio
FROM productos
GROUP BY categoria
ORDER BY precio_promedio DESC;
```

34. Modificar la consulta anterior para mostrar solamente las categorías cuyo precio promedio sea superior a $100.000.

**Pista:** investigar para qué sirve `HAVING`.

35. (Extra – JOINs) Mostrar el detalle de cada venta: fecha de la venta, nombre del cliente, nombre del producto, cantidad y precio unitario. Ordenar por fecha de venta descendente.

**Pista:** necesitarás unir las tablas `ventas`, `detalle_ventas`, `clientes` y `productos` usando `JOIN`.

---

## Ayudas de sintaxis

### Operadores

```sql
WHERE campo > valor
WHERE campo < valor
WHERE campo >= valor
WHERE campo <= valor
WHERE campo = valor
WHERE campo <> valor
```

### Combinar condiciones

```sql
WHERE precio > 50000 AND precio < 150000;
```

### LIKE

- `'A%'` → comienza con A
- `'%a'` → termina con a
- `'%Pro%'` → contiene Pro

### Fechas

`YEAR(fecha)`, `MONTH(fecha)`, `DAY(fecha)`

```sql
WHERE YEAR(fecha_venta) = 2026;
```

### ORDER BY

```sql
ORDER BY campo ASC;
ORDER BY campo DESC;
```

### Agregación

- `MAX(campo)` → máximo
- `MIN(campo)` → mínimo
- `SUM(campo)` → suma
- `AVG(campo)` → promedio
- `COUNT(campo)` → cantidad

### GROUP BY

```sql
SELECT campo, FUNCION(campo)
FROM tabla
GROUP BY campo;
```

### HAVING

Se utiliza para filtrar resultados agrupados (después de `GROUP BY`).

### JOIN (nuevo)

```sql
FROM ventas v
JOIN detalle_ventas d ON v.id_venta = d.id_venta
JOIN productos p ON d.id_producto = p.id_producto
```

> **Nota:** Las consultas 4, 23, 24, 25, 26 y 31 deben realizarse sobre la tabla `detalle_ventas`. Las consultas de fechas y ordenamiento de ventas se realizan sobre la tabla `ventas`. El ejercicio 35 introduce el uso de `JOIN` para relacionar las tablas.

use veterinaria_joins;

# 1. Listá cada mascota junto al nombre y apellido de su dueño. Ordená por apellido del dueño y, dentro de cada uno, por nombre de la mascota.
SELECT m.nombre AS mascota, d.nombre, d.apellido 
FROM mascotas m 
INNER JOIN duenios d ON m.id_duenio = d.id_duenio ORDER BY d.apellido, m.nombre;

# 2. Mostrá todos los turnos con la fecha, el nombre de la mascota atendida, el nombre completo del veterinario y el estado del turno. Ordená cronológicamente.
SELECT t.fecha, t.estado, m.nombre AS mascota, v.nombre AS nombre_veterinario, v.apellido AS apellido_veterinario
FROM turnos t
INNER JOIN mascotas m ON t.id_mascota = m.id_mascota
INNER JOIN veterinarios v ON t.id_veterinario = v.id_veterinario
ORDER BY t.fecha;

#3. Armá el detalle facturable de los turnos en estado atendido: 
# número de turno, fecha, mascota, descripción del tratamiento, cantidad y subtotal calculado. Esta consulta requiere vincular cuatro tablas.
SELECT t.id_turno AS numero_turno, t.fecha, m.nombre AS mascota, tr.descripcion AS tratamiento, tt.cantidad, tt.cantidad * tr.precio AS subtotal
FROM turnos t
INNER JOIN mascotas m ON t.id_mascota = m.id_mascota
INNER JOIN turnos_tratamientos tt ON t.id_turno = tt.id_turno
INNER JOIN tratamientos tr ON tr.id_tratamiento = tt.id_tratamiento
WHERE t.estado = "atendido";

# 4. Calculá cuánto facturó cada veterinario. Mostrá apellido y nombre, la cantidad de turnos distintos que atendió y el total facturado. Ordená de mayor a menor.
SELECT v.nombre, v.apellido, COUNT(DISTINCT t.id_turno) AS cantidad_turnos, SUM(tt.cantidad * tr.precio) AS total_facturado
FROM veterinarios v
INNER JOIN turnos t ON v.id_veterinario = t.id_veterinario
INNER JOIN turnos_tratamientos tt ON t.id_turno = tt.id_turno
INNER JOIN tratamientos tr ON tt.id_tratamiento = tr.id_tratamiento
WHERE t.estado = 'atendido'
GROUP BY v.id_veterinario, v.apellido, v.nombre
ORDER BY total_facturado DESC;

# 5. Listá todas las vacunas aplicadas indicando la fecha, la mascota, el nombre de la vacuna y el nombre completo del dueño.
SELECT a.fecha, m.nombre AS mascota, v.nombre AS vacuna, CONCAT(d.nombre, ' ', d.apellido) AS dueño
FROM aplicaciones a
INNER JOIN mascotas m ON a.id_mascota = m.id_mascota
INNER JOIN vacunas v ON a.id_vacuna = v.id_vacuna
INNER JOIN duenios d ON m.id_duenio = d.id_duenio
ORDER BY a.fecha;

# 6. Listá todos los dueños registrados junto a sus mascotas, incluyendo a quienes todavía no tienen ninguna registrada.
SELECT d.nombre AS dueño, d.apellido AS apellido_dueño, m.nombre AS mascota
FROM duenios d
LEFT JOIN mascotas m ON d.id_duenio = m.id_duenio
ORDER BY d.apellido, d.nombre;

# 7. Mostrá cada dueño con la cantidad de mascotas que tiene. Usando `COUNT(*)` y otra usando `COUNT()` sobre la clave primaria de la mascota. 
# Poné ambas columnas en la misma consulta, compará los resultados y explicá en un comentario cuál de las dos es correcta y por qué.
SELECT d.nombre AS dueño, d.apellido AS apellido_dueño, COUNT(*) AS cantidad_todo, COUNT(m.id_mascota) AS cantidad_pk
FROM duenios d
LEFT JOIN mascotas m ON d.id_duenio = m.id_duenio
GROUP BY d.id_duenio, d.nombre, d.apellido
ORDER BY d.apellido;

# 8. Obtené las mascotas que nunca tuvieron un turno agendado. Resolvelo sin usar `NOT IN` ni subconsultas: el filtro debe apoyarse en el resultado del JOIN.
SELECT m.nombre AS mascota, m.especie
FROM mascotas m
LEFT JOIN turnos t ON m.id_mascota = t.id_mascota
WHERE t.id_turno IS NULL;

# 9. Listá todas las mascotas con la fecha de su última vacuna aplicada y el total de dosis recibidas. Las que nunca fueron vacunadas también deben aparecer.
SELECT m.nombre AS mascota, MAX(a.fecha) AS ultima_vacuna, COUNT(a.id_aplicacion) AS total_dosis
FROM mascotas m
LEFT JOIN aplicaciones a ON m.id_mascota = a.id_mascota
GROUP BY m.id_mascota, m.nombre
ORDER BY m.nombre;

# 10A. Todas las mascotas con sus turnos en estado `atendido`, poniendo la condición del estado dentro de la cláusula `ON`
SELECT m.nombre AS mascota, t.id_turno, t.fecha, t.estado
FROM mascotas m
LEFT JOIN turnos t ON m.id_mascota = t.id_mascota AND t.estado = 'atendido'
ORDER BY m.nombre;

# 10B. La misma consulta, pero con la condición del estado en el `WHERE`
SELECT m.nombre AS mascota, t.id_turno, t.fecha, t.estado
FROM mascotas m
LEFT JOIN turnos t ON m.id_mascota = t.id_mascota
WHERE t.estado = 'atendido'
ORDER BY m.nombre;

# 11. Listá todos los veterinarios con los turnos que atendieron, incluyendo a aquellos que no tienen ningún turno asignado. La consulta debe resolverse con RIGHT JOIN.
SELECT v.nombre AS nombre_veterinario, v.apellido AS apellido_veterinario, t.id_turno, t.fecha, t.estado
FROM turnos t
RIGHT JOIN veterinarios v ON t.id_veterinario = v.id_veterinario
ORDER BY v.apellido, t.fecha;

# 12. Mostrá todas las sucursales con la cantidad de veterinarios que trabajan en cada una, incluidas las que no tienen personal asignado.
SELECT s.nombre AS sucursal, COUNT(v.id_veterinario) AS cantidad_veterinarios
FROM veterinarios v
RIGHT JOIN sucursales s ON v.id_sucursal = s.id_sucursal
GROUP BY s.id_sucursal, s.nombre
ORDER BY s.nombre;

# 13. Detectá los tratamientos del catálogo que nunca fueron aplicados en ningún turno.
SELECT tr.descripcion AS tratamiento, tr.precio
FROM turnos_tratamientos tt
RIGHT JOIN tratamientos tr ON tt.id_tratamiento = tr.id_tratamiento
WHERE tt.id_tratamiento IS NULL;

# 14. Listá todas las vacunas del vademécum indicando cuántas veces se aplicaron y la fecha de la última aplicación. Las que nunca se usaron deben mostrarse con cero.
SELECT v.nombre AS vacuna, COUNT(a.id_aplicacion) AS veces_aplicada, MAX(a.fecha) AS ultima_aplicacion
FROM aplicaciones a
RIGHT JOIN vacunas v ON a.id_vacuna = v.id_vacuna
GROUP BY v.id_vacuna, v.nombre
ORDER BY v.nombre;

# 15. Tomá la consulta del ejercicio 6 y reescribila usando RIGHT JOIN, invirtiendo el orden en que nombrás las tablas, de modo que devuelva exactamente el mismo resultado. Verificá que ambas salidas sean idénticas.
SELECT d.nombre AS dueño, d.apellido AS apellido_dueño, m.nombre AS mascota
FROM mascotas m
RIGHT JOIN duenios d ON m.id_duenio = d.id_duenio
ORDER BY d.apellido, d.nombre;

# 16. MySQL no implementa `FULL OUTER JOIN`. Investigá cómo se simula combinando un LEFT JOIN y un RIGHT JOIN, 
# y escribí una consulta que devuelva todos los dueños y todas las mascotas, hayan quedado vinculados o no. Justificá por qué se usa `UNION` y no `UNION ALL`.
SELECT d.nombre AS dueño, d.apellido AS apellido_dueño, m.nombre AS mascota
FROM duenios d
LEFT JOIN mascotas m ON d.id_duenio = m.id_duenio
UNION
SELECT d.nombre AS dueño, d.apellido AS apellido_dueño, m.nombre AS mascota
FROM duenios d
RIGHT JOIN mascotas m ON d.id_duenio = m.id_duenio;

/* 17. Al finalizar, respondé en no más de diez renglones: 
en esta base de datos concreta, ¿qué información se pierde si un analista usa siempre INNER JOIN por costumbre? 
Mencioná al menos tres casos puntuales que hayas encontrado resolviendo el práctico. 

Si uso siempre INNER JOIN, pierdo todos los registros que no tienen una coincidencia del otro lado,por ejemplo, Simba,
desaparece de cualquier listado de mascotas con dueño. 
Elena Suárez, no tiene sucursal asignado, y tambien las mascotas que nunca tuvieron un turno agendado también quedan afuera si uno junta veterinarios/mascotas con turnos usando INNER JOIN. 
Lo mismo pasa con tratamientos del catálogo que nunca se aplicaron o vacunas que nunca se usaron.
Un INNER JOIN los excluye directamente del resultado, como si no existieran en el catálogo. 
El INNER JOIN muestra solo lo que coincide, y muchas veces se necesita ver también lo que falta.

*/



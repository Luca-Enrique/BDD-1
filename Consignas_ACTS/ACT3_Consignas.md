# Trabajo Práctico — Consultas con JOIN

**Tecnicatura en Análisis y Desarrollo de Software**
Escuela Normal Superior "Dr. Antonio Sagarna"
Espacio curricular: Base de Datos

---

## Consigna general

Trabajamos sobre la base `veterinaria_joins`, que modela la gestión de una clínica veterinaria con varias sucursales.

Antes de empezar, ejecutá el script de creación que está en el archivo `joins_veterinaria.sql` (secciones 1 y 2 únicamente: estructura y datos).

Resolvé cada punto con **una sola consulta SQL**. Entregá un archivo `.sql` con tu apellido en el nombre, que contenga las 15 consultas numeradas y comentadas. Cada consulta debe estar precedida por un comentario con el número de ejercicio y, en dos renglones, **qué esperabas obtener y qué obtuviste**. Si no coinciden, explicá por qué.

No se aceptan resoluciones con subconsultas en lugar de JOIN, salvo donde el enunciado lo indique expresamente.

---

## Modelo de datos

| Tabla | Contenido |
|---|---|
| `sucursales` | Locales de la clínica |
| `duenios` | Personas responsables de las mascotas |
| `mascotas` | Animales registrados, vinculados a un dueño |
| `veterinarios` | Profesionales, asignados a una sucursal |
| `turnos` | Atenciones agendadas, con estado |
| `tratamientos` | Catálogo de prestaciones y precios |
| `turnos_tratamientos` | Qué se le hizo a cada turno y en qué cantidad |
| `vacunas` | Vademécum de vacunas por especie |
| `aplicaciones` | Registro de vacunas efectivamente aplicadas |

Antes de escribir la primera consulta, dibujá el diagrama entidad-relación de estas nueve tablas marcando las claves foráneas. Adjuntalo a la entrega.

---

## Parte A — INNER JOIN

**1.** Listá cada mascota junto al nombre y apellido de su dueño. Ordená por apellido del dueño y, dentro de cada uno, por nombre de la mascota.

**2.** Mostrá todos los turnos con la fecha, el nombre de la mascota atendida, el nombre completo del veterinario y el estado del turno. Ordená cronológicamente.

**3.** Armá el detalle facturable de los turnos en estado `atendido`: número de turno, fecha, mascota, descripción del tratamiento, cantidad y subtotal calculado. Esta consulta requiere vincular cuatro tablas.

**4.** Calculá cuánto facturó cada veterinario. Mostrá apellido y nombre, la cantidad de turnos distintos que atendió y el total facturado. Ordená de mayor a menor.

**5.** Listá todas las vacunas aplicadas indicando la fecha, la mascota, el nombre de la vacuna y el nombre completo del dueño.

> **Sobre el punto 5:** contá cuántas filas devuelve tu consulta y compará ese número con la cantidad de registros que tiene la tabla `aplicaciones`. ¿Coinciden? Si no, identificá exactamente qué fila se perdió y explicá el motivo.

---

## Parte B — LEFT JOIN

**6.** Listá **todos** los dueños registrados junto a sus mascotas, incluyendo a quienes todavía no tienen ninguna registrada.

**7.** Mostrá cada dueño con la cantidad de mascotas que tiene. Resolvé el mismo punto dos veces: una usando `COUNT(*)` y otra usando `COUNT()` sobre la clave primaria de la mascota. Poné ambas columnas en la misma consulta, compará los resultados y explicá en un comentario cuál de las dos es correcta y por qué.

**8.** Obtené las mascotas que nunca tuvieron un turno agendado. Resolvelo sin usar `NOT IN` ni subconsultas: el filtro debe apoyarse en el resultado del JOIN.

**9.** Listá todas las mascotas con la fecha de su última vacuna aplicada y el total de dosis recibidas. Las que nunca fueron vacunadas también deben aparecer.

**10.** Escribí estas dos consultas y compará sus resultados:

- a) Todas las mascotas con sus turnos en estado `atendido`, poniendo la condición del estado **dentro de la cláusula `ON`**.
- b) La misma consulta, pero con la condición del estado **en el `WHERE`**.

Una de las dos deja de comportarse como un LEFT JOIN. Identificá cuál, indicá cuántas filas devuelve cada una y explicá qué hace la base de datos en cada caso.

---

## Parte C — RIGHT JOIN

**11.** Listá todos los veterinarios con los turnos que atendieron, incluyendo a aquellos que no tienen ningún turno asignado. La consulta debe resolverse con RIGHT JOIN.

**12.** Mostrá todas las sucursales con la cantidad de veterinarios que trabajan en cada una, incluidas las que no tienen personal asignado.

**13.** Detectá los tratamientos del catálogo que nunca fueron aplicados en ningún turno.

**14.** Listá todas las vacunas del vademécum indicando cuántas veces se aplicaron y la fecha de la última aplicación. Las que nunca se usaron deben mostrarse con cero.

**15.** Tomá la consulta del ejercicio 6 y reescribila usando RIGHT JOIN, invirtiendo el orden en que nombrás las tablas, de modo que devuelva exactamente el mismo resultado. Verificá que ambas salidas sean idénticas.

---

## Parte D — Integración

**16.** MySQL no implementa `FULL OUTER JOIN`. Investigá cómo se simula combinando un LEFT JOIN y un RIGHT JOIN, y escribí una consulta que devuelva todos los dueños y todas las mascotas, hayan quedado vinculados o no. Justificá por qué se usa `UNION` y no `UNION ALL`.

**17.** Al finalizar, respondé en no más de diez renglones: en esta base de datos concreta, ¿qué información se pierde si un analista usa siempre INNER JOIN por costumbre? Mencioná al menos tres casos puntuales que hayas encontrado resolviendo el práctico.

---

## Criterios de evaluación

| Criterio | Puntos |
|---|---|
| Corrección de las consultas | 40 |
| Elección adecuada del tipo de JOIN | 20 |
| Análisis de los puntos 5, 7, 10 y 17 | 25 |
| Diagrama entidad-relación | 10 |
| Prolijidad, comentarios y formato de entrega | 5 |

# Actividades de SQL — Base de datos GIMNASIO (versión corta)

**Antes de empezar:** ejecutá el script `gimnasio_base.sql` completo. Vas a tener cuatro tablas: `socios`, `rutinas`, `asistencias` y `ventas`.

Entregá un archivo `.sql` con las 24 actividades numeradas y comentadas. Cuando una consulta te dé error, **no la borres**: dejala comentada y anotá qué decía el mensaje.

---

## Bloque 1 — Insertar registros

1. Agregá un socio nuevo con todos sus datos, usando `DEFAULT` en el campo del id. Verificá con un `SELECT *` que el id se haya generado solo.
2. Cargale a ese socio dos rutinas en una sola sentencia `INSERT`.
3. Intentá cargar una rutina con un `idsocio` que no exista (por ejemplo 77). Anotá el error y explicá con tus palabras por qué el motor no lo deja.

## Bloque 2 — Agregar, borrar y modificar campos

4. Agregá a `socios` un campo `telefono` de tipo `VARCHAR(20)`. Mostrá la estructura con `DESCRIBE socios;`.
5. Borrá el campo `telefono` que acabás de crear.
6. Modificá `plan` en `socios` para que acepte hasta 25 caracteres y no admita nulos.
7. Cambiá el nombre del campo `nombre` por `nombre_socio`, manteniendo el tipo y la restricción. Después volvé a ejecutar una consulta vieja que usara `nombre` y anotá qué pasa.

## Bloque 3 — Borrar y modificar registros

8. Cambiá el DNI del socio con `idsocio = 3` por el valor `43999999`.
9. Pasá al plan `anual` a todos los socios que hoy tienen plan `trimestral`.
10. Corregí el apellido `Juarez` (sin tilde) para que quede `Juárez` donde aparezca.
11. Intentá borrar el socio con `idsocio = 1`. Anotá el error. ¿Qué habría que hacer antes para poder borrarlo?

## Bloque 4 — Consultas de selección con textos

12. Mostrá nombre y apellido de los socios cuyo apellido sea exactamente `Barrios`.
13. Mostrá los socios cuyo apellido empiece con `A`.
14. Mostrá los socios cuyo plan contenga la palabra `anual`. Prestá atención al resultado: fijate si aparece algo que no esperabas y explicá por qué.
15. **Para pensar:** compará `WHERE apellido = 'Juarez'` con `WHERE apellido LIKE 'J%'`. ¿Por qué no dan lo mismo? Fijate bien en las tildes de los datos cargados.

## Bloque 5 — Consultas de selección con números

16. Mostrá ejercicio y peso de las rutinas que superan los 40 kg.
17. Mostrá las rutinas con peso mayor a 30 kg **y** repeticiones menores o iguales a 12.
18. Mostrá ejercicio y peso ordenados de mayor a menor peso.

## Bloque 6 — Consultas con fechas

19. Mostrá los socios nacidos en el mes de abril.
20. Mostrá los socios nacidos en el año 1998, primero con `YEAR()` y después con un rango de fechas. Compará los dos resultados.
21. Mostrá las ventas realizadas hoy.

## Bloque 7 — Consultas de dos tablas

22. Mostrá apellido y nombre del socio junto al ejercicio y el peso de cada rutina.
23. Mostrá nombre del socio y actividad de cada asistencia, solo de los socios cuyo nombre empiece con `M`.

## Bloque 8 — Consulta de tres tablas

24. Mostrá apellido, nombre, ejercicio y actividad, uniendo `socios`, `rutinas` y `asistencias`. **Para pensar:** contá cuántas filas devuelve y comparalo con la cantidad de rutinas cargadas. Buscá el caso de Lucía y explicá qué está pasando. Después averiguá qué socio no aparece a pesar de tener rutina, y por qué.

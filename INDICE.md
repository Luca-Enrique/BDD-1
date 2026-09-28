# Índice de archivos

Catálogo completo del repositorio, ordenado por carpeta. Cada entrada indica el archivo y una breve descripción de lo que hace.

> Para una vista general, requisitos y configuración, ver `README.md`. Para el historial de versiones, ver `CHANGELOG.md`.

## Consignas_ACTS

Enunciados de las actividades, en el mismo orden en que se resuelven.

- `ACT1_Consignas.md` → 24 actividades sobre la base `gimnasio`: `INSERT`, `ALTER TABLE` (agregar, borrar y modificar campos), `UPDATE` / `DELETE`, `LIKE`, operadores numéricos, funciones de fecha y `JOIN` de dos y tres tablas.
- `ACT2_Consignas.md` → Actividad de `INNER JOIN`, `LEFT JOIN` y `RIGHT JOIN` sobre `instituto_idiomas`. Consta de una parte A de investigación guiada (15 preguntas sobre comportamiento, `ON` vs `WHERE` y `COUNT(*) vs COUNT(columna)`) y una parte B de 13 ejercicios integradores en tres niveles, con criterios de evaluación y defensa oral.
- `ACT3_Consignas.md` → Trabajo práctico de `JOIN` sobre `veterinaria_joins` (9 tablas). 17 puntos repartidos en INNER, LEFT, RIGHT y una parte de integración que incluye la simulación de `FULL OUTER JOIN` con `UNION`.
- `ACT4_Consignas.md` → 35 consignas sobre `tienda_tecnologia`: operadores con números y textos, consultas con fechas, `ORDER BY`, funciones de agregación, `GROUP BY` / `HAVING` y un ejercicio final con `JOIN` de cuatro tablas.
- `ACT5_Consignas.md` → 10 actividades de subconsultas sobre `sistema_proyectos`: escalares en `WHERE`, `IN` / `NOT IN` y la trampa del `NULL`, `EXISTS` / `NOT EXISTS` con `EXPLAIN`, subconsulta correlacionada, subconsulta en la lista `SELECT`, tabla derivada en `FROM` y `ALL` / `ANY`.

## Scripts

- `SENTENCIAS.sql` → Guía de sentencias SQL reorganizada en 9 secciones temáticas (DDL, `INSERT`, `UPDATE` / `DELETE`, `SELECT` por texto, por números, `ORDER BY`, por fechas, `JOIN` y `GROUP BY` / `HAVING`). Cada sección indica con un `USE` a qué base corresponde.

## Scripts/Actividad 1 — Gimnasio

- `gimnasio_base.sql` → Crea la base de datos `gimnasio` con las tablas `socios`, `rutinas`, `asistencias` y `ventas`, con claves foráneas y datos de prueba.
- `ACT1_Respuestas.sql` → Resolución comentada de las 24 actividades de la Actividad 1.

## Scripts/Actividad 2 — Instituto de Idiomas

- `instituto_idiomas.sql` → Crea la base de datos `instituto_idiomas` con las tablas `alumnos`, `cursos`, `profesores` e `inscripciones`, con datos de prueba que incluyen notas en `NULL` y cursos sin profesor.
- `Investigacion.sql` → Resolución de la parte A: investigación guiada de los tres tipos de `JOIN`, la condición en `ON` vs `WHERE` y la diferencia entre `COUNT(*)` y `COUNT(columna)`.
- `ACT2_Respuestas.sql` → Resolución comentada de los 13 ejercicios integradores de la parte B, con las justificaciones de por qué se eligió cada tipo de `JOIN`.

## Scripts/Actividad 3 — Veterinaria (JOINs)

- `veterinaria_joins.sql` → Crea la base de datos `veterinaria_joins` con sus 9 tablas (`sucursales`, `duenos`, `mascotas`, `veterinarios`, `turnos`, `tratamientos`, `turnos_tratamientos`, `vacunas`, `aplicaciones`) y datos de prueba.
- `ACT3_Respuestas.sql` → Resolución comentada de los 17 puntos del práctico: `INNER`, `LEFT` y `RIGHT JOIN` de hasta cuatro tablas, comparación de `COUNT(*)` contra `COUNT()` de la clave primaria, y simulación de `FULL OUTER JOIN` con `UNION`.

## Scripts/Actividad 4 — Tienda de Tecnología

- `tienda_tecnologia.sql` → Crea la base de datos `tienda_tecnologia` con las tablas `clientes`, `productos`, `ventas` y `detalle_ventas`, con datos de prueba.
- `ACT4_Respuestas.sql` → Resolución comentada de las 35 consignas: operadores, funciones de fecha, `ORDER BY`, agregación, `GROUP BY` / `HAVING` y el detalle de ventas con `JOIN` de cuatro tablas.

## Scripts/Actividad 5 — Sistema de Proyectos (subconsultas)

- `sistema_proyectos.sql` → Crea la base de datos `sistema_proyectos` con las tablas `departamentos`, `empleados`, `proyectos` y `asignaciones`. Los datos de prueba incluyen a propósito una asignación con `empleado_id` en `NULL`, que es la base de la consigna sobre la trampa de `NOT IN`.
- `ACT5_Respuestas.sql` → Resolución comentada de las 10 actividades de subconsultas, con la explicación de qué devuelve cada subconsulta interna por sí sola.

## Models

Modelos entidad-relación de MySQL Workbench (`.mwb`).

- `alumnos_aulas_cursos.mwb` → Alumnos, aulas y cursos.
- `biblioteca_digital.mwb` → Biblioteca digital (autores, géneros, libros y préstamos).
- `cine.mwb` → Cine (películas, funciones y salas).
- `colegio.mwb` → Colegio.
- `parque_tecnologico.mwb` → Parque tecnológico.
- `plataforma_musical.mwb` → Plataforma musical.
- `veterinaria.mwb` → Veterinaria.
- `veterinaria_joins.mwb` → Clínica veterinaria con sucursales (sucursales, dueños, mascotas, veterinarios, turnos, tratamientos y vacunas).

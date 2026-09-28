# Changelog

## [1.4.0] - 2026-09-28

### docs

- Creo `INDICE.md` con el catálogo completo de archivos del repositorio, organizado por carpeta (Consignas_ACTS, Scripts, Scripts/Actividad 1 a 5 y Models).
- Aligero `README.md`: las tablas de estructura del repositorio y de modelos entidad-relación pasan al `INDICE.md` y quedan reemplazadas por un árbol de carpetas, un bloque de documentación inicial y la fecha de última actualización.

## [1.3.0] - 2026-09-28

### feat

- Actividad 5 — base `sistema_proyectos` con `departamentos`, `empleados`, `proyectos` y `asignaciones` (Scripts/Actividad 5/sistema_proyectos.sql) + resolución de las 10 consignas de subconsultas (Scripts/Actividad 5/ACT5_Respuestas.sql).
- Consigna ACT5_Consignas.md.
- Subconsultas escalares, `IN`/`NOT IN`, `EXISTS`/`NOT EXISTS`, subconsulta correlacionada, subconsulta en la lista `SELECT`, tabla derivada en `FROM`, y `ALL`/`ANY` con su equivalencia a `MAX()`/`MIN()`.

### fix

- Actividad 4: la reescritura de la consigna 4c con `WHERE empleado_id IS NULL` estaba invertida (devolvía 0 filas); se reemplazó por una versión con `NOT EXISTS`.
- Actividad 4: se completaron los incisos a) y b) de la consigna 4 sobre la trampa del `NULL` en `NOT IN`.

### docs

- Actualización del README.md con la Actividad 5 en la estructura, la guía de uso y los temas cubiertos.

## [1.2.0] - 2026-09-05

### feat

- Actividad 3 — JOINs: base `veterinaria_joins` con sus 9 tablas y datos de prueba (Scripts/Actividad 3/veterinaria_joins.sql) + resolución de los 17 puntos (Scripts/Actividad 3/ACT3_Respuestas.sql).
- Actividad 4 — base `tienda_tecnologia` con `clientes`, `productos`, `ventas` y `detalle_ventas` (Scripts/Actividad 4/tienda_tecnologia.sql) + resolución de consignas (Scripts/Actividad 4/ACT4_Respuestas.sql).
- Consignas ACT3_Consignas.md y ACT4_Consignas.md.
- Modelo entidad-relación `veterinaria_joins` (Models/veterinaria_joins.mwb).

### refactor

- Scripts/SENTENCIAS.sql reorganizado en 9 secciones temáticas (DDL, INSERT, UPDATE/DELETE, SELECT por texto/números/fechas, ORDER BY, JOIN, GROUP BY/HAVING), con consultas completas ejecutables y `USE` por sección.
- Scripts/Actividad 1/ACTIVIDAD.sql → ACT1_Respuestas.sql y Scripts/Actividad 2/EJERCICIOS.sql → ACT2_Respuestas.sql (renombrados).

### docs

- Orden cronológico de versiones en el CHANGELOG (1.1.0 antes de 1.0.0).

## [1.1.0] - 2026-08-19

### feat

- Actividad 2 — Instituto de Idiomas: investigación guiada + ejercicios integradores de LEFT JOIN, RIGHT JOIN e INNER JOIN.
- Base de datos `instituto_idiomas` con tablas `profesores`, `alumnos`, `cursos` e `inscripciones` (Scripts/Actividad 2/instituto_idiomas.sql).
- Resolución comentada de los 13 ejercicios de la Actividad 2 (Scripts/Actividad 2/EJERCICIOS.sql).
- Resolución de la parte A — investigación guiada con 18 preguntas (Scripts/Actividad 2/INVESTIGACION.sql).
- Sentencia `DISTINCT` y unión de 4 tablas en Scripts/SENTENCIAS.sql.

### refactor

- Reorganización de la estructura de Scripts: archivos de cada actividad en subcarpetas (`Scripts/Actividad 1/`, `Scripts/Actividad 2/`).
- Renombrado `Consignas Gimnasio.md` a `ACT1_Consignas.md`.
- Reformateo de consultas JOIN en Scripts/SENTENCIAS.sql para mejor legibilidad.

### docs

- Actualización del README.md con la nueva estructura, guía de uso por actividad y nuevos temas cubiertos.

## [1.0.0] - 2026-08-11

### feat

- Base de datos `gimnasio` con tablas `socios`, `rutinas`, `asistencias` y `ventas` (Scripts/gimnasio_base.sql).
- Resolución comentada de las 24 actividades (Scripts/ACTIVIDAD.sql).
- Guía de sentencias SQL (Scripts/SENTENCIAS.sql).
- Enunciados de actividades (Consignas ACTS/).
- 7 modelos entidad-relación en MySQL Workbench (Models/).

### docs

- Documentación completa del proyecto en README.md (estructura, uso, temas cubiertos y modelos).
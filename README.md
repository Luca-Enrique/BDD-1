# Práctica de Bases de Datos — MySQL

Repositorio con ejercitación de bases de datos en **MySQL / MariaDB**: modelos entidad-relación diseñados en MySQL Workbench (`.mwb`) y scripts SQL con sentencias para crear, modificar y consultar bases de datos.

## Documentación

- `INDICE.md` → Catálogo de todos los archivos del repositorio, con descripción de cada uno.
- `CHANGELOG.md` → Registro de versiones y cambios.

## Estructura

```
Consignas_ACTS/      Enunciados de las 5 actividades
Models/              Modelos entidad-relación de MySQL Workbench (.mwb)
Scripts/             Guía de sentencias SQL y scripts de cada actividad
  Actividad_1/       Gimnasio
  Actividad_2/       Instituto de Idiomas
  Actividad_3/       Veterinaria (JOINs)
  Actividad_4/       Tienda de Tecnología
  Actividad_5/       Sistema de Proyectos (subconsultas)
```

El detalle archivo por archivo está en [INDICE.md](INDICE.md).

## Requisitos

- **MySQL** o **MariaDB**
- **MySQL Workbench** (opcional, para abrir los modelos `.mwb`)

## Cómo usar

### Actividad 1 — Base de datos Gimnasio
1. Ejecutá `Scripts/Actividad 1/gimnasio_base.sql` para crear la base de datos `gimnasio` con sus tablas y datos de prueba.
2. Ejecutá `Scripts/Actividad 1/ACT1_Respuestas.sql` para ver la resolución comentada de las 24 actividades (INSERT, ALTER, UPDATE, DELETE, SELECT con JOINs).

### Actividad 2 — Instituto de Idiomas
1. Ejecutá `Scripts/Actividad 2/instituto_idiomas.sql` para crear la base de datos `instituto_idiomas` con sus tablas y datos de prueba.
2. Ejecutá `Scripts/Actividad 2/INVESTIGACION.sql` para ver la resolución de la parte A (investigación guiada de JOINs).
3. Ejecutá `Scripts/Actividad 2/ACT2_Respuestas.sql` para ver la resolución de la parte B (ejercicios integradores de Nivel 1, 2 y 3).

### Actividad 3 — Veterinaria (JOINs)
1. Ejecutá `Scripts/Actividad 3/veterinaria_joins.sql` para crear la base de datos `veterinaria_joins` con sus 9 tablas y datos de prueba.
2. Ejecutá `Scripts/Actividad 3/ACT3_Respuestas.sql` para ver la resolución comentada de los 17 puntos (INNER, LEFT, RIGHT JOIN y simulación de FULL OUTER).

### Actividad 4 — Tienda de Tecnología
1. Ejecutá `Scripts/Actividad 4/tienda_tecnologia.sql` para crear la base de datos `tienda_tecnologia` con sus 4 tablas y datos de prueba.
2. Ejecutá `Scripts/Actividad 4/ACT4_Respuestas.sql` para ver la resolución comentada de las consignas.

### Actividad 5 — Sistema de Proyectos (subconsultas)
1. Ejecutá `Scripts/Actividad 5/sistema_proyectos.sql` para crear la base de datos `sistema_proyectos` con sus 4 tablas y datos de prueba.
2. Ejecutá `Scripts/Actividad 5/ACT5_Respuestas.sql` para ver la resolución comentada de las 10 consignas (subconsultas escalares, `IN`/`NOT IN`, `EXISTS`/`NOT EXISTS`, correlacionadas, tabla derivada y `ALL`/`ANY`).

## Temas cubiertos

- `CREATE DATABASE` / `DROP DATABASE` / `CREATE TABLE`
- `ALTER TABLE` (`ADD`, `DROP`, `MODIFY`, `CHANGE`)
- `INSERT`, `UPDATE`, `DELETE`
- `SELECT` con `WHERE`, `LIKE`, `BETWEEN`, operadores de comparación y `ORDER BY`
- Funciones de fecha: `CURDATE()`, `YEAR()`, `MONTH()`, `DAY()`
- `INNER JOIN` de dos, tres y cuatro tablas
- `LEFT JOIN` y `RIGHT JOIN` (equivalencia, comportamiento y uso práctico)
- `GROUP BY` con `COUNT()`, `AVG()`
- `IFNULL()` / `COALESCE()`
- `DISTINCT`
- Claves foráneas y errores de integridad referencial (1451 / 1452)
- Diferencia entre `COUNT(*)` y `COUNT(columna)`
- Condición en `ON` vs `WHERE` con LEFT JOIN
- Subconsultas escalares en `WHERE` (con `AVG()`, `MAX()`)
- `IN` / `NOT IN` con subconsulta y la trampa del `NULL`
- `EXISTS` / `NOT EXISTS` y comparación de planes de ejecución con `EXPLAIN`
- Subconsultas correlacionadas (alias de la consulta externa)
- Subconsultas en la lista `SELECT` y tablas derivadas en `FROM`
- `ALL` y `ANY` y su equivalencia con `MAX()` / `MIN()`

## Cambios

Ver el registro de versiones en [CHANGELOG.md](CHANGELOG.md).

---

**Última actualización:** 28 Septiembre 2026

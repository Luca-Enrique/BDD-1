# Práctica de Bases de Datos — MySQL

Repositorio con ejercitación de bases de datos en **MySQL / MariaDB**: modelos entidad-relación diseñados en MySQL Workbench (`.mwb`) y scripts SQL con sentencias para crear, modificar y consultar bases de datos.

## Estructura del repositorio

| Carpeta / Archivo                         | Contenido |
|-------------------------------------------|-----------|
| `Consignas ACTS/`                         | Enunciados de cada actividad |
| `Models/`                                 | Modelos entidad-relación (`.mwb`) de MySQL Workbench |
| `Scripts/Actividad 1/gimnasio_base.sql`   | Crea la base de datos `gimnasio` con 4 tablas y datos de prueba |
| `Scripts/Actividad 1/ACT1_Respuestas.sql` | Resolución comentada de las 24 consignas de la Actividad 1 |
| `Scripts/Actividad 2/instituto_idiomas.sql` | Crea la base de datos `instituto_idiomas` con 4 tablas y datos de prueba |
| `Scripts/Actividad 2/ACT2_Respuestas.sql` | Resolución comentada de los 13 ejercicios de la Actividad 2 |
| `Scripts/Actividad 2/INVESTIGACION.sql`   | Resolución de la parte A (investigación guiada) de la Actividad 2 |
| `Scripts/Actividad 3/veterinaria_joins.sql` | Crea la base de datos `veterinaria_joins` con 9 tablas y datos de prueba |
| `Scripts/Actividad 3/ACT3_Respuestas.sql` | Resolución comentada de los 17 puntos del práctico de JOINs |
| `Scripts/Actividad 4/tienda_tecnologia.sql` | Crea la base de datos `tienda_tecnologia` con 4 tablas y datos de prueba |
| `Scripts/Actividad 4/ACT4_Respuestas.sql` | Resolución comentada de las consignas de la Actividad 4 |
| `Scripts/SENTENCIAS.sql`                  | Guía de sentencias SQL (ALTER, INSERT, UPDATE, DELETE, SELECT, JOIN, DISTINCT...) |
| `CHANGELOG.md`                            | Registro de cambios del proyecto |

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
1. Ejecutá `Scripts/Actividad 4/tienda_tecnologia.sql` para crear la base de datos `tienda_tecnologia` con sus tablas y datos de prueba.
2. Ejecutá `Scripts/Actividad 4/ACT4_Respuestas.sql` para ver la resolución comentada de las consignas.

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

## Modelos entidad-relación

| Modelo                   | Descripción |
|--------------------------|-------------|
| `alumnos_aulas_cursos`   | Alumnos, aulas y cursos |
| `biblioteca_digital`     | Biblioteca digital (autores, géneros, libros y préstamos) |
| `cine`                   | Cine (películas, funciones, salas) |
| `colegio`                | Colegio |
| `parque_tecnologico`     | Parque tecnológico |
| `plataforma_musical`     | Plataforma musical |
| `veterinaria`            | Veterinaria |
| `veterinaria_joins`      | Clínica veterinaria con sucursales (sucursales, dueños, mascotas, veterinarios, turnos, tratamientos, vacunas) |

## Cambios

Ver el registro de versiones en [CHANGELOG.md](CHANGELOG.md).

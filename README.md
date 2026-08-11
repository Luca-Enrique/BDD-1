# Práctica de Bases de Datos — MySQL

Repositorio con ejercitación de bases de datos en **MySQL / MariaDB**: modelos entidad-relación diseñados en MySQL Workbench (`.mwb`) y scripts SQL con sentencias para crear, modificar y consultar bases de datos.

## Estructura del repositorio

| Carpeta / Archivo            | Contenido |
|------------------------------|-----------|
| `Consignas ACTS/`            | Aquí se encuentran las consignas de las actividades que vaya realizando |
| `Models/`                    | Modelos entidad-relación (`.mwb`) de MySQL Workbench |
| `Scripts/gimnasio_base.sql`  | Crea la base de datos `gimnasio` con 4 tablas (`socios`, `rutinas`, `asistencias`, `ventas`) y datos de prueba |
| `Scripts/ACTIVIDAD.sql`      | Resolución comentada de las 24 consignas |
| `Scripts/SENTENCIAS.sql`     | Guía de sentencias SQL (ALTER, INSERT, UPDATE, DELETE, SELECT, JOIN...) |
| `CHANGELOG.md`               | Registro de cambios del proyecto |

## Requisitos

- **MySQL** o **MariaDB**
- **MySQL Workbench** (opcional, para abrir los modelos `.mwb`)

## Cómo usar

1. Ejecutá los scripts necesarios, como por ejemplo `Scripts/gimnasio_base.sql` para crear la base de datos `gimnasio` con sus tablas y datos de prueba.
2. Después ejecutá `Scripts/ACTIVIDAD.sql` para ver la resolución comentada de las 24 actividades.

## Temas cubiertos

- `CREATE DATABASE` / `DROP DATABASE` / `CREATE TABLE`
- `ALTER TABLE` (`ADD`, `DROP`, `MODIFY`, `CHANGE`)
- `INSERT`, `UPDATE`, `DELETE`
- `SELECT` con `WHERE`, `LIKE`, operadores de comparación y `ORDER BY`
- Funciones de fecha: `CURDATE()`, `YEAR()`, `MONTH()`, `DAY()`
- `INNER JOIN` de dos y tres tablas
- Claves foráneas y errores de integridad referencial (1451 / 1452)

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

## Cambios

Ver el registro de versiones en [CHANGELOG.md](CHANGELOG.md).

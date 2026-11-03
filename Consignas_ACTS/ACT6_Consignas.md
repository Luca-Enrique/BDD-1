# Actividad práctica: Funciones en MySQL

**Tema:** funciones de texto, numéricas, de fecha, de control de flujo y de agregación
**Base de datos:** `colegio_db`

## Situación problemática

Un colegio necesita generar reportes a partir de la información de sus cursos, alumnos y notas. Los datos no están del todo limpios: hay nombres con tildes y `ñ`, correos de distintos dominios y notas que quedaron en `NULL` porque el alumno no rindió. El objetivo es practicar las funciones de MySQL para normalizar textos, calcular promedios y formatear fechas sin modificar los datos originales.

## Estructura de las tablas

### Tabla `cursos`

| Campo | Tipo |
|---|---|
| id | INT |
| nombre_curso | VARCHAR |
| turno | ENUM('M', 'T', 'N') |

### Tabla `alumnos`

| Campo | Tipo |
|---|---|
| id | INT |
| nombre | VARCHAR |
| apellido | VARCHAR |
| email | VARCHAR (admite `NULL`) |
| fecha_nac | DATE |
| fecha_inscripcion | DATE |
| curso_id | INT |

### Tabla `notas`

| Campo | Tipo |
|---|---|
| id | INT |
| alumno_id | INT |
| curso_id | INT |
| nota | DECIMAL(4,2) (admite `NULL`) |
| anio | INT |

### Tabla `productos`

| Campo | Tipo |
|---|---|
| id | INT |
| nombre | VARCHAR |
| precio | DECIMAL(10,2) |

**Relaciones:**
- `alumnos.curso_id` → `cursos.id`
- `notas.alumno_id` → `alumnos.id`
- `notas.curso_id` → `cursos.id`

> Ejecutar primero `Scripts/Actividad_6/colegio_db.sql` para crear la base y cargar los datos de prueba.

---

## Parte 1 — Funciones de texto

1. Mostrar el apellido en mayúsculas, el nombre normal y una columna `nombre_completo` que una ambos con un espacio. Además, extraer únicamente el dominio de los correos electrónicos (todo lo que está después del `@`).
2. Mostrar el apellido de los alumnos y la cantidad exacta de caracteres que tiene, ordenados de forma ascendente según esa longitud.
3. Sobre la tabla `productos`, listar el nombre, el precio original y calcular:
   a) el precio final con un 21% de recargo, redondeado a 2 decimales;
   b) el mismo cálculo pero con `TRUNCATE` a 2 decimales.
   Comparar ambos resultados y explicar la diferencia.

## Parte 2 — Funciones numéricas y de control de flujo

4. Determinar si el `id` de cada alumno es **par** o **impar** usando `IF` y `MOD`.
5. En la tabla `notas`, mostrar el nombre del alumno, su nota y una columna `condicion` que evalúe:
   - si la nota es 9 o más: `'Excelente'`;
   - si la nota es 6 o más: `'Aprobado'`;
   - en cualquier otro caso: `'Desaprobado'`.

## Parte 3 — Funciones de fecha

6. A partir de la tabla `alumnos`, mostrar el nombre, la fecha de nacimiento formateada como `DD/MM/YYYY` y la edad exacta en años cumplidos.
7. Calcular una fecha de vencimiento sumando exactamente 15 días a `fecha_inscripcion`.

## Parte 4 — Agregación

8. Sobre las tablas `notas` y `cursos`, agrupado por curso, devolver:
   - el nombre del curso;
   - la cantidad total de notas registradas;
   - el promedio de notas redondeado a 2 decimales;
   - la nota máxima obtenida.

   Filtrar únicamente los cursos cuyo promedio general sea mayor o igual a 6.

---

## Desafío integrador

**Parte 1:** seleccionar un alumno al azar de toda la base usando `RAND()` combinada con `ORDER BY` y `LIMIT 1`.

**Parte 2:** generar un reporte que una `alumnos`, `cursos` y `notas`, mostrando:
- nombre y apellido concatenados y en mayúsculas;
- el promedio de sus notas con 1 decimal;
- el mes de inscripción extraído con `MONTH` y rellenado con ceros a la izquierda (por ejemplo `05` en lugar de `5`).

---

## Condiciones de entrega

- Un único archivo `.sql` con las consultas comentadas (`-- N`) y las respuestas escritas dentro de comentarios de bloque.
- Nombre del archivo: `apellido_nombre_funciones.sql`.
- Ejecutar el script sobre `colegio_db` y verificar que todas las consultas corran sin errores.

# Subconsultas básicas en MySQL — 10 actividades

**Espacio curricular:** Base de Datos
**Alcance:** subconsultas dentro de `SELECT` (escalares, `IN`/`NOT IN`, `EXISTS`, correlacionadas, tablas derivadas).
**No se usan** en esta guía: `INSERT/UPDATE/DELETE` con subconsulta, CTEs ni funciones de ventana.

---

## 1. Esquema de trabajo

Ejecutar el script completo antes de empezar. Todas las consignas se resuelven sobre estas cuatro tablas.

```sql
DROP DATABASE IF EXISTS sistema_proyectos;
CREATE DATABASE sistema_proyectos
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sistema_proyectos;

CREATE TABLE departamentos (
  id      INT AUTO_INCREMENT PRIMARY KEY,
  nombre  VARCHAR(60) NOT NULL,
  ciudad  VARCHAR(60) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE empleados (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  nombre          VARCHAR(60) NOT NULL,
  apellido        VARCHAR(60) NOT NULL,
  salario         DECIMAL(12,2) NOT NULL,
  fecha_ingreso   DATE NOT NULL,
  departamento_id INT,
  CONSTRAINT fk_emp_depto FOREIGN KEY (departamento_id)
    REFERENCES departamentos(id)
) ENGINE=InnoDB;

CREATE TABLE proyectos (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  nombre          VARCHAR(80) NOT NULL,
  presupuesto     DECIMAL(14,2) NOT NULL,
  departamento_id INT,
  CONSTRAINT fk_proy_depto FOREIGN KEY (departamento_id)
    REFERENCES departamentos(id)
) ENGINE=InnoDB;

CREATE TABLE asignaciones (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  empleado_id INT,          -- admite NULL a propósito
  proyecto_id INT NOT NULL,
  horas       INT NOT NULL,
  CONSTRAINT fk_asig_emp  FOREIGN KEY (empleado_id) REFERENCES empleados(id),
  CONSTRAINT fk_asig_proy FOREIGN KEY (proyecto_id) REFERENCES proyectos(id)
) ENGINE=InnoDB;

INSERT INTO departamentos (id, nombre, ciudad) VALUES
 (1,'Sistemas','Paraná'),
 (2,'Ventas','Nogoyá'),
 (3,'Contabilidad','Paraná'),
 (4,'Logística','Victoria'),
 (5,'Marketing','Nogoyá');

INSERT INTO empleados (id, nombre, apellido, salario, fecha_ingreso, departamento_id) VALUES
 (1,'Ana','Gómez',    850000.00,'2019-03-01',1),
 (2,'Bruno','Díaz',   920000.00,'2018-07-15',1),
 (3,'Carla','Ruiz',   640000.00,'2021-01-10',2),
 (4,'Diego','Sosa',   710000.00,'2020-05-20',2),
 (5,'Elena','Vera',   990000.00,'2017-11-05',1),
 (6,'Fabián','Luna',  580000.00,'2022-02-28',3),
 (7,'Gabriela','Paz', 760000.00,'2019-09-12',3),
 (8,'Hernán','Ríos',  450000.00,'2023-04-03',4),
 (9,'Irina','Blanco', 830000.00,'2016-06-30',4),
 (10,'Julián','Mota', 670000.00,'2021-08-19',2);

INSERT INTO proyectos (id, nombre, presupuesto, departamento_id) VALUES
 (1,'Migración ERP',      5000000.00,1),
 (2,'Portal de Clientes', 2500000.00,1),
 (3,'Campaña Verano',     1200000.00,2),
 (4,'Auditoría Interna',   900000.00,3),
 (5,'Ruteo Inteligente',  3000000.00,4);

INSERT INTO asignaciones (id, empleado_id, proyecto_id, horas) VALUES
 (1,1,1,120),
 (2,2,1,100),
 (3,5,2, 80),
 (4,3,3, 60),
 (5,4,3, 40),
 (6,7,4, 90),
 (7,9,5,110),
 (8,1,2, 50),
 (9,NULL,5,30);   -- horas de un recurso externo todavía no registrado
```

---

## 2. Actividades

Para **cada** actividad se entrega: la consulta SQL, una captura del resultado y **una línea** explicando qué devuelve la subconsulta interna por sí sola.

### Actividad 1 — Subconsulta escalar en `WHERE`
Listar apellido, nombre y salario de los empleados que ganan **más que el promedio salarial de toda la empresa**, ordenados de mayor a menor salario.
*Pista:* la subconsulta devuelve un único valor, así que se compara con `>`.

### Actividad 2 — Subconsulta escalar (máximo)
Mostrar los datos del empleado que tiene el **salario más alto**, sin usar `ORDER BY ... LIMIT 1`.
*Pregunta a responder por escrito:* ¿qué pasaría si dos empleados empataran en el salario máximo? ¿Y con `LIMIT 1`?

### Actividad 3 — `IN` con subconsulta
Listar los empleados que trabajan en departamentos ubicados en **Paraná**. Resolverlo con subconsulta (no con `JOIN`).

### Actividad 4 — `NOT IN` y la trampa del `NULL`
Obtener los empleados que **no tienen ninguna asignación** a proyectos, usando:

```sql
SELECT nombre, apellido
FROM empleados
WHERE id NOT IN (SELECT empleado_id FROM asignaciones);
```

a) Ejecutarla y anotar cuántas filas devuelve.
b) Explicar **por qué** devuelve ese resultado (mirar la fila 9 de `asignaciones`).
c) Reescribirla de **dos** formas distintas para que dé el resultado correcto.

### Actividad 5 — Subconsulta correlacionada
Listar los empleados que ganan más que el **promedio salarial de su propio departamento**. Mostrar apellido, departamento y salario.
*Pista:* la subconsulta interna tiene que referenciar la fila de la consulta externa (alias obligatorio).

### Actividad 6 — `EXISTS`
Listar los departamentos que tienen **al menos un empleado** asignado.

### Actividad 7 — `NOT EXISTS`
Listar los departamentos que **no tienen ningún empleado**. Comparar el resultado y el plan de ejecución (`EXPLAIN`) contra la versión con `NOT IN`.

### Actividad 8 — Subconsulta en la lista `SELECT`
Mostrar apellido, nombre y una columna calculada `cantidad_proyectos` con la cantidad de proyectos distintos en los que participa cada empleado. Los empleados sin asignaciones deben aparecer con **0**, no con `NULL`.

### Actividad 9 — Subconsulta en `FROM` (tabla derivada)
Mostrar el nombre del departamento y su salario promedio, **solo** para los departamentos cuyo promedio supere los `$650000`. Resolverlo con una tabla derivada en el `FROM`.
*Requisito:* la tabla derivada tiene que llevar alias, si no MySQL tira error.

### Actividad 10 — `ALL` y `ANY`
a) Listar los empleados que ganan más que **todos** los empleados de Contabilidad.
b) Listar los empleados que ganan más que **alguno** de los empleados de Contabilidad.
c) Escribir en una línea la diferencia conceptual entre `> ALL` y `> ANY`, y con qué función de agregación se podría reemplazar cada uno.

---

## 3. Condiciones de entrega

- Un único archivo `.sql` con las 10 consultas comentadas (`-- Actividad N`) y las respuestas escritas dentro de comentarios de bloque.
- Nombre del archivo: `apellido_nombre_subconsultas.sql`.
- **Defensa oral individual:** en la instancia de coloquio se pide ejecutar dos consultas a elección del docente y modificarlas en vivo (cambiar el operador, la ciudad, el umbral o el departamento de referencia). No se aprueba la entrega sin defensa.

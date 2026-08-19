# Actividad: LEFT JOIN, RIGHT JOIN e INNER JOIN

**Base de datos:** Instituto de Idiomas
**Modalidad:** investigación guiada + ejercicios integradores
**Duración estimada:** 2 clases (80 min + 80 min)

---

## Parte 0 — Preparación del entorno

Ejecutá el script `instituto_idiomas.sql` en tu servidor MySQL. Antes de escribir una sola consulta con JOIN, respondé:

1. ¿Cuántas filas tiene cada tabla? (`SELECT COUNT(*) FROM ...`)
2. Dibujá el diagrama entidad-relación en papel. Marcá las claves foráneas con flechas.
3. ¿Qué columnas admiten `NULL`? Revisá con `DESCRIBE cursos;` y `DESCRIBE inscripciones;`

> **Anotá los conteos.** Los vas a necesitar para interpretar los resultados de la Parte A.

---

## Parte A — Investigación guiada

Esta parte **no tiene explicación previa**. La idea es que descubras el comportamiento de cada JOIN ejecutando y observando.

### A.1 — El experimento base

Ejecutá estas tres consultas, una por una, y anotá **cuántas filas devuelve cada una**:

```sql
-- Consulta 1
SELECT a.nombre, a.apellido, i.id_curso, i.nota
FROM alumnos a
INNER JOIN inscripciones i ON a.id_alumno = i.id_alumno;

-- Consulta 2
SELECT a.nombre, a.apellido, i.id_curso, i.nota
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno;

-- Consulta 3
SELECT a.nombre, a.apellido, i.id_curso, i.nota
FROM alumnos a
RIGHT JOIN inscripciones i ON a.id_alumno = i.id_alumno;
```

Completá esta tabla:

| Consulta | Tipo de JOIN | Filas devueltas | ¿Aparecen NULL? ¿En qué columnas? |
|---|---|---|---|
| 1 | INNER | | |
| 2 | LEFT | | |
| 3 | RIGHT | | |

**Preguntas de análisis:**

1. La consulta 2 devuelve más filas que la 1. ¿Qué alumnos aparecen en el resultado de la 2 y no en el de la 1? Nombralos.
2. ¿Por qué la consulta 3 devuelve exactamente la misma cantidad de filas que la 1? ¿Qué te dice eso sobre los datos de la tabla `inscripciones`?
3. Si el LEFT JOIN devuelve filas con `NULL`, ¿esos `NULL` están guardados en la base o los genera la consulta? Justificá.

### A.2 — Invertir el orden

Ejecutá y compará:

```sql
-- Consulta 4
SELECT c.nombre AS curso, p.apellido AS profesor
FROM cursos c
LEFT JOIN profesores p ON c.id_profesor = p.id_profesor;

-- Consulta 5
SELECT c.nombre AS curso, p.apellido AS profesor
FROM profesores p
RIGHT JOIN cursos c ON c.id_profesor = p.id_profesor;
```

4. ¿Qué diferencia hay entre los resultados de la 4 y la 5? Explicá qué pasó.
5. Escribí una regla general que relacione LEFT JOIN y RIGHT JOIN. Completá esta frase con tus palabras:
   *"`A LEFT JOIN B` es equivalente a `___________` porque..."*
6. Si son equivalentes, ¿por qué existen los dos? Buscá al menos un argumento a favor de cada uno.

### A.3 — Buscar lo que falta (el uso real del LEFT JOIN)

Ejecutá:

```sql
-- Consulta 6
SELECT p.nombre, p.apellido, c.nombre AS curso
FROM profesores p
LEFT JOIN cursos c ON p.id_profesor = c.id_profesor
WHERE c.id_curso IS NULL;
```

7. ¿Qué devuelve? ¿Qué pregunta del negocio está respondiendo esta consulta?
8. ¿Podrías obtener el mismo resultado con un INNER JOIN? Probá y explicá qué pasa.
9. Escribí, imitando el patrón anterior, una consulta que devuelva **los cursos que no tienen ningún alumno inscripto**.

### A.4 — La trampa

Ejecutá estas dos consultas. Parecen decir lo mismo:

```sql
-- Consulta 7
SELECT a.nombre, a.apellido, i.nota
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno
WHERE i.nota >= 7;

-- Consulta 8
SELECT a.nombre, a.apellido, i.nota
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno AND i.nota >= 7;
```

10. ¿Cuántas filas devuelve cada una? ¿Por qué son distintas?
11. Una de las dos "anuló" el LEFT JOIN y se comportó como un INNER JOIN. ¿Cuál y por qué?
12. Formulá la regla: ¿cuándo va la condición en el `ON` y cuándo en el `WHERE`?

### A.5 — Contar mal

```sql
-- Consulta 9
SELECT a.nombre, a.apellido, COUNT(*) AS cantidad
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno
GROUP BY a.id_alumno, a.nombre, a.apellido;

-- Consulta 10
SELECT a.nombre, a.apellido, COUNT(i.id_inscripcion) AS cantidad
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno
GROUP BY a.id_alumno, a.nombre, a.apellido;
```

13. Buscá a Bruno Costa en ambos resultados. ¿Qué cantidad muestra cada consulta? ¿Cuál está bien?
14. Explicá la diferencia entre `COUNT(*)` y `COUNT(columna)`.
15. Si tuvieras que informarle a la dirección del instituto cuántos cursos hizo cada alumno, ¿qué consulta usarías? ¿Qué pasaría si usás la otra?

---

## Parte B — Ejercicios integradores

Ya con las tres herramientas. Cada consigna indica **qué** hay que obtener, no **cómo**: parte del trabajo es decidir qué tipo de JOIN corresponde.

> **Regla de entrega:** cada ejercicio se entrega con (a) la consulta SQL, (b) captura de pantalla del resultado real, (c) una línea justificando por qué elegiste ese tipo de JOIN.

### Nivel 1 — Dos tablas

1. Listado de todas las inscripciones con nombre y apellido del alumno y nombre del curso. Solo las que tienen datos completos en ambas tablas.

2. Listado de **todos** los alumnos del instituto, indicando en cuántos cursos están inscriptos. Los que no tienen ninguno deben aparecer con `0`.

3. Listado de **todos** los cursos con el apellido del profesor a cargo. Los cursos sin profesor asignado deben mostrar la leyenda `SIN ASIGNAR` en lugar de `NULL`.
   *Pista: investigá la función `IFNULL()` o `COALESCE()`.*

4. Alumnos que se dieron de alta pero **nunca** se inscribieron a nada.

5. Cursos que están en el catálogo pero **no tienen ningún inscripto**.

6. Profesores que **no** tienen cursos a cargo actualmente.

### Nivel 2 — Tres tablas

7. Listado completo de inscripciones mostrando: apellido del alumno, nombre del curso y apellido del profesor. Usá INNER JOIN. Anotá cuántas filas devuelve.

8. Repetí el ejercicio 7 pero asegurando que **no se pierda ninguna inscripción**, incluso si el curso no tiene profesor asignado. Compará la cantidad de filas con la del ejercicio 7 y explicá la diferencia.

9. Por cada curso, mostrar: nombre del curso, nivel, apellido del profesor y cantidad de alumnos inscriptos. Deben aparecer **todos** los cursos, incluidos los que tienen cero inscriptos y los que no tienen profesor.

10. Promedio de notas por curso, mostrando todos los cursos. Los que no tienen notas cargadas deben aparecer igual.
    *Atención: hay inscripciones con `nota` en `NULL`. Verificá si el `AVG()` las está contando o no, y aclaralo en tu justificación.*

### Nivel 3 — Criterio propio

11. La dirección quiere un informe de **alumnos en riesgo**: aquellos cuyo promedio de notas es menor a 6, mostrando además la cantidad de cursos que hicieron. ¿Qué pasa con los alumnos que todavía no tienen ninguna nota cargada? Decidí si deben aparecer o no, y justificá tu decisión.

12. Escribí una consulta que responda: *¿qué idiomas del catálogo no tienen profesor disponible?* Tené en cuenta que un profesor puede figurar en la tabla `profesores` sin estar asignado a un curso.

13. **Consigna de análisis (sin SQL):** el sistema del instituto muestra en pantalla el listado de cursos con su profesor usando un INNER JOIN. Dos cursos desaparecieron de la pantalla y nadie entiende por qué. Explicá qué está pasando y proponé dos soluciones distintas: una desde la consulta y otra desde el diseño de la base de datos.

---

## Criterios de evaluación

| Criterio | Puntaje |
|---|---|
| Parte A completa, con las 15 respuestas fundamentadas | 30 |
| Ejercicios Nivel 1 (6 ejercicios) | 24 |
| Ejercicios Nivel 2 (4 ejercicios) | 24 |
| Ejercicios Nivel 3 (3 ejercicios) | 15 |
| Justificación de la elección del JOIN en cada caso | 7 |

**Se descuenta puntaje si:** la consulta devuelve el resultado correcto por casualidad y la justificación no lo explica; se entregan capturas de resultados que no coinciden con la consulta presentada.

---

## Defensa oral

Cada estudiante debe poder, frente al docente y sin material a la vista:

- Modificar en vivo una de sus consultas para invertir el sentido del JOIN.
- Explicar qué filas se agregan o se pierden al cambiar INNER por LEFT en un caso concreto de su entrega.
- Responder: *"si borro esta línea del `WHERE`, ¿qué pasa?"*

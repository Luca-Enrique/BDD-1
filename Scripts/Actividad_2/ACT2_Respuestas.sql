use instituto_idiomas;

# 1. Listado de todas las inscripciones con nombre y apellido del alumno y nombre del curso. Solo las que tienen datos completos en ambas tablas.
SELECT a.nombre, a.apellido, c.nombre AS curso
FROM inscripciones i 
INNER JOIN alumnos a ON i.id_alumno = a.id_alumno
INNER JOIN cursos c ON i.id_curso = c.id_curso;

# 2. Listado de todos los alumnos del instituto, indicando en cuántos cursos están inscriptos. Los que no tienen ninguno deben aparecer con `0`.
SELECT a.nombre, a.apellido, COUNT(i.id_inscripcion) AS cantidad
FROM inscripciones i
RIGHT JOIN alumnos a ON i.id_alumno = a.id_alumno
GROUP BY a.id_alumno, a.nombre, a.apellido;

/* 3. Listado de todos los cursos con el apellido del profesor a cargo. 
Los cursos sin profesor asignado deben mostrar la leyenda `SIN ASIGNAR` en lugar de `NULL`. 
*Pista: investigá la función `IFNULL()` o `COALESCE()`.
*/
SELECT IFNULL(p.apellido, 'SIN ASIGNAR') AS apellido, c.nombre AS curso 
FROM cursos c
LEFT JOIN profesores p ON c.id_profesor = p.id_profesor;

# 4. Alumnos que se dieron de alta pero nunca se inscribieron a nada.
SELECT a.nombre, a.apellido
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno
WHERE i.id_inscripcion IS NULL;

# 5. Cursos que están en el catálogo pero no tienen ningún inscripto.
SELECT c.nombre AS curso
FROM cursos c
LEFT JOIN inscripciones i ON c.id_curso = i.id_curso
WHERE i.id_curso IS NULL;

# 6. Profesores que no tienen cursos a cargo actualmente.
SELECT p.nombre, p.apellido
FROM profesores p
LEFT JOIN cursos c ON p.id_profesor = c.id_profesor
WHERE id_curso IS NULL;

# 7. Listado completo de inscripciones mostrando: apellido del alumno, nombre del curso y apellido del profesor. Usá INNER JOIN. Anotá cuántas filas devuelve.
SELECT a.apellido AS alumno, c.nombre AS curso, p.apellido AS profesor
FROM inscripciones i
INNER JOIN alumnos a ON i.id_alumno = a.id_alumno
INNER JOIN cursos c ON i.id_curso = c.id_curso
INNER JOIN profesores p ON c.id_profesor = p.id_profesor;
# Devolvió 7 filas

/* 8. Repetí el ejercicio 7 pero asegurando que no se pierda ninguna inscripción, 
incluso si el curso no tiene profesor asignado. 
Compará la cantidad de filas con la del ejercicio 7 y explicá la diferencia.
*/
SELECT a.apellido AS alumno, c.nombre AS curso, p.apellido AS profesor
FROM inscripciones i
LEFT JOIN alumnos a ON i.id_alumno = a.id_alumno
LEFT JOIN cursos c ON i.id_curso = c.id_curso
LEFT JOIN profesores p ON c.id_profesor = p.id_profesor;
# Devolvió 8 filas, ya que muestra el 'LEFT JOIN' mantiene todas las inscripciones, aunque no tenga un profesor asigando, como en este caso.

/* 9. Por cada curso, mostrar: nombre del curso, nivel, apellido del profesor y cantidad de alumnos inscriptos. 
Deben aparecer todos los cursos, incluidos los que tienen cero inscriptos y los que no tienen profesor.
*/
SELECT c.nombre AS curso, c.nivel, p.apellido AS profesor, COUNT(i.id_inscripcion) AS alumnos_inscriptos
FROM cursos c
LEFT JOIN profesores p ON c.id_profesor = p.id_profesor
LEFT JOIN inscripciones i ON c.id_curso = i.id_curso
GROUP BY c.nombre, c.nivel, p.apellido;

/* 10. Promedio de notas por curso, mostrando todos los cursos. 
Los que no tienen notas cargadas deben aparecer igual.
Atención: hay inscripciones con `nota` en `NULL`. 
Verificá si el `AVG()` las está contando o no, y aclaralo en tu justificación.
*/
SELECT c.nombre AS curso, AVG(i.nota) AS promedio_notas
FROM cursos c
LEFT JOIN inscripciones i ON c.id_curso = i.id_curso
GROUP BY c.nombre;
/* El 'LEFT JOIN' muestra todos los cursos, incluso los que no tienen inscripciones o notas cargadas. 
La función 'AVG()' ignora los 'NULL', 
por lo que las notas que son 'NULL' no entran en el calculo del promedio. 
Por otro lado, los cursos que no tienen ninguna nota muestran 'NULL' como promedio.
*/

/* 11. La dirección quiere un informe de alumnos en riesgo: 
aquellos cuyo promedio de notas es menor a 6, mostrando además la cantidad de cursos que hicieron. 
¿Qué pasa con los alumnos que todavía no tienen ninguna nota cargada? Decidí si deben aparecer o no, y justificá tu decisión.
*/
SELECT a.nombre, a.apellido, AVG(i.nota) AS promedio_notas, COUNT(i.id_curso) AS cantidad_cursos
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno
LEFT JOIN cursos c ON c.id_curso = i.id_curso
WHERE i.nota < 6
GROUP BY a.nombre, a.apellido;
/* Considero que los que aparecen con notas 'NULL' no deben aparecer porque:
1. Encucian lo que muestra la consulta
2. no proporciona información útil, ya que directamente aparece 'NULL' y lo que necesitamos es un promedio claro
*/

/* 12. Escribí una consulta que responda: 
¿qué idiomas del catálogo no tienen profesor disponible? 
Tené en cuenta que un profesor puede figurar en la tabla `profesores` sin estar asignado a un curso.
*/
SELECT DISTINCT c.idioma
FROM cursos c
LEFT JOIN profesores p ON c.id_profesor = p.id_profesor
WHERE p.id_profesor IS NULL;

/* 13. Consigna de análisis (sin SQL): 
el sistema del instituto muestra en pantalla el listado de cursos con su profesor usando un INNER JOIN. 
Dos cursos desaparecieron de la pantalla y nadie entiende por qué.
Explicá qué está pasando y proponé dos soluciones distintas: 
1. Desde la consulta
2. Desde el diseño de la base de datos.
---------------------------------------
Los dos cursos que falta desaparecieron porque se usa un 'INNER JOIN' el cual solo obtiene los resultados coincidientes de ambas tablas.

1. Propongo utilizar un 'LEFT JOIN', ya que nos permite ver todos los cursos aunque no tengan un profesor asignado. 
En los casos donde no exista profesor, apareceria como 'NULL'.
2. Si el instituto dice que todos los cursos deben tener minimo un profesor, 
modificaría 'id_profesor' para que no admita valores 'NULL (NOT NULL)'. 
Además, dejaria la clave foránea que obliga a que el profesor que esté asignado exista en la tabla profesores.
*/

# Consulta que utilizó el instituto
SELECT c.nombre AS curso, p.apellido AS profesor
FROM cursos c
INNER JOIN profesores p ON c.id_profesor = p.id_profesor;

# Consulta que propongo
SELECT c.nombre AS curso, p.apellido AS profesor
FROM cursos c
LEFT JOIN profesores p ON c.id_profesor = p.id_profesor;


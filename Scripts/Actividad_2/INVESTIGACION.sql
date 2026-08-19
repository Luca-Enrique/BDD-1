use instituto_idiomas;

/* 1. ¿Cuántas filas tiene cada tabla? (`SELECT COUNT(*) FROM ...`)
Usamos el 'SELECT COUNT(*) FROM ...' 
para contar cuantos registros tienen una tabla en cuestión, podemos usar sentencias como WHERE para ser más especificos.
*/

								     -- Registros
SELECT COUNT(*) FROM profesores;     -- 	4 
SELECT COUNT(*) FROM alumnos;        -- 	7 
SELECT COUNT(*) FROM cursos;         -- 	6
SELECT COUNT(*) FROM inscripciones;  -- 	8


# 3. ¿Qué columnas admiten `NULL`? Revisá con `DESCRIBE cursos;` y `DESCRIBE inscripciones;`
DESCRIBE cursos; # La FK permite null, es la unica
DESCRIBE inscripciones; # La columna para notas permite null, tambien la unica

# 4. Ejecutá estas tres consultas, una por una, y anotá cuántas filas devuelve cada una:
-- Consulta 1
SELECT a.nombre, a.apellido, i.id_curso, i.nota
FROM alumnos a
INNER JOIN inscripciones i ON a.id_alumno = i.id_alumno;
# Devolvió 8 filas 	

-- Consulta 2
SELECT a.nombre, a.apellido, i.id_curso, i.nota
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno;
# Devolvió 10 filas

-- Consulta 3
SELECT a.nombre, a.apellido, i.id_curso, i.nota
FROM alumnos a
RIGHT JOIN inscripciones i ON a.id_alumno = i.id_alumno;
# Devolvió 8 filas

/* Tabla completa:
| Consulta | Tipo de JOIN | Filas devueltas | ¿Aparecen NULL?  | ¿En qué columnas?        |
|----------|--------------|-----------------|------------------|--------------------------|
|    1     |    INNER     |        8        |   	Si    	   |   En la columna de nota  |
|    2     |    LEFT      |       10        |   	Si    	   |   En id_curso y en nota  |
| 	 3     |    RIGHT     |        8        |   	Si    	   |   En la columna de nota  |
|----------|--------------|-----------------|------------------|--------------------------|
*/

/* 5. La consulta 2 devuelve más filas que la 1. ¿Qué alumnos aparecen en el resultado de la 2 y no en el de la 1? Nombralos.
 Bruno y Tomás no aparecen el resultado de la sentencia 1
*/

/* 6. ¿Por qué la consulta 3 devuelve exactamente la misma cantidad de filas que la 1? ¿Qué te dice eso sobre los datos de la tabla `inscripciones`?
Al unir las dos tablas con inner podemos ver que nos devuelve 8 filas, 
ahora, si al hacer right join nos devuelve la misma cantidad de filas, 
podemos deducir que la tabla incripciones tiene todos los alumnos asignados.
*/

/* 7. Si el LEFT JOIN devuelve filas con `NULL`, ¿esos `NULL` están guardados en la base o los genera la consulta? Justificá.
Los 'NULL' estan en la db, al usar una sentencia como 'LEFT JOIN', 
te los muestra porque en la tabla que estamos intentando unirno encuentra resultados para ese id en concreto, 
por ejemplo, si intentamos unir alumnos e inscripciones, con un left join, 
los alumnos que no tengan nota en la db, la columna 'nota' se muestra como 'NULL'.
*/

-- Consulta 4
SELECT c.nombre AS curso, p.apellido AS profesor
FROM cursos c
LEFT JOIN profesores p ON c.id_profesor = p.id_profesor;

-- Consulta 5
SELECT c.nombre AS curso, p.apellido AS profesor
FROM profesores p
RIGHT JOIN cursos c ON c.id_profesor = p.id_profesor;

/* 8. ¿Qué diferencia hay entre los resultados de la 4 y la 5? Explicá qué pasó.
Muestran lo mismo, porque las dos estan usando el 'JOIN' hacia la misma tabla 'cursos', 
aunque uno es 'LEFT' y el otro es 'RIGHT', el orden en el que está escrita la consulta hace que los dos 'JOINS' capten la misma tabla.
*/

/* 9. Escribí una regla general que relacione LEFT JOIN y RIGHT JOIN. Completá esta frase con tus palabras:
*"`A LEFT JOIN B` es equivalente a `B RIGHT JOIN A` 
porque las dos tienen el mismo 'objetivo' por así decirlo, el cual es la tabla A y las coincidencias con la tabla B"*
*/

/* 10. Si son equivalentes, ¿por qué existen los dos? Buscá al menos un argumento a favor de cada uno.
Existen las 2 consultas ya que nos permite escribir la conuslta de manera más comoda, según como estén ordenadas las 2 o más tablas que queremos unir

'LEFT JOIN': Nos permite mantener todos los registros de la tabla que esté a la izquierda, incluso cuando no coinciden los registros
'RIGHT JOIN': Hace lo mismo, pero nos permite mantener siempre el orden en el que escribimos las consultas con 'JOIN', 
			  con solo cambiar de palabra, haciendo que sea más fácil de leer.
*/

-- Consulta 6
SELECT p.nombre, p.apellido, c.nombre AS curso
FROM profesores p
LEFT JOIN cursos c ON p.id_profesor = c.id_profesor
WHERE c.id_curso IS NULL;

/* 11. ¿Qué devuelve? ¿Qué pregunta del negocio está respondiendo esta consulta?
Nos devuelve un profesor el cual no tiene un curso asignado, ya que el id aparece como 'NULL'
Y en este caso, nos sirve para saber que profesores no están en ningun curso para así poder asignarlos.
*/

SELECT p.nombre, p.apellido, c.nombre AS curso
FROM profesores p
INNER JOIN cursos c ON p.id_profesor = c.id_profesor
WHERE c.id_curso IS NULL;

/* 12. ¿Podrías obtener el mismo resultado con un INNER JOIN? Probá y explicá qué pasa.
No, ya que el 'INNER JOIN' solo nos muestra los registros, el cual tengan coincidencias en las dos tablas que estamos intentando unir,
en este caso, como curso aparece 'NULL' el 'INNER JOIN' evita esos registros y nos los muestra.
*/

# 13. Escribí, imitando el patrón anterior, una consulta que devuelva **los cursos que no tienen ningún alumno inscripto**.
SELECT c.nombre, i.id_curso AS curso # Esto ultimo no hace falta, ya que siempre va a aparecer 'NULL', lo dejo porque sigue la misma sentencia de antes
FROM cursos c
LEFT JOIN inscripciones i ON c.id_curso = i.id_curso
WHERE i.id_curso IS NULL;

-- Consulta 7
SELECT a.nombre, a.apellido, i.nota
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno
WHERE i.nota >= 7;
# Devolvió 3 filas

-- Consulta 8
SELECT a.nombre, a.apellido, i.nota
FROM alumnos a
LEFT JOIN inscripciones i ON a.id_alumno = i.id_alumno AND i.nota >= 7;
# Devolvió 8 filas

/* 13. ¿Cuántas filas devuelve cada una? ¿Por qué son distintas?
Aunque parece que las 2 deben dar el mismo resultado, la consulta 7 solo toma los alumnos los cuales su nota es mayor o igual a 7,
eliminando a los alumnos los cuales tienen notas como 'NULL', acutando como un 'INNER JOIN', 
por otro lado, la consulta 8 pone la condicion dentro del 'ON', entonces el 'LEFT JOIN' conserva los 'NULL'
*/

/* 14. Una de las dos "anuló" el LEFT JOIN y se comportó como un INNER JOIN. ¿Cuál y por qué?
En la consulta 7 podemos ver que pasa esto, ya que con la condicional 'WHERE i.nota >= 7' el 'JOIN', esta descarta las notas con valor 'NULL', 
por lo que en teoria es un 'LEFT JOIN' pero en realidad actua como un 'INNER JOIN'
*/

/* 15. Formulá la regla: ¿cuándo va la condición en el ON y cuándo en el WHERE?
'ON': Cuando queremos dejar todos los valores, incluso, en este caso, de la tabla derecha.
'WHERE': Sirve para cuando queremos mostrar un resultado final, eliminando los 'NULL'.
*/

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

/* 16. Buscá a Bruno Costa en ambos resultados. ¿Qué cantidad muestra cada consulta? ¿Cuál está bien?
En la consulta 9 aparece 1 vez, en la consulta 10 aparece 0 veces.
La consulta 10 es la que está bien, porque la primera lo cuenta aunque el resultado sea 'NULL' la segunda consulta no, solo cuenta cuando no es 'NULL'.
*/

/* 17. Explicá la diferencia entre COUNT(*) y COUNT(columna).
'COUNT(*): Cuenta todo, aunque sea 'NULL'
'COUNT(columna): Solo cuenta los reguistros que no tengan como valor 'NULL'
*/

/* 18. Si tuvieras que informarle a la dirección del instituto cuántos cursos hizo cada alumno, ¿qué consulta usarías? ¿Qué pasaría si usás la otra?
Si tuviera que usar una, usaria la consulta 10, ya que es la que proporciona una información correcta, porque cuenta solo las inscripciones que de verdad
hicieron, sino estariamos proporcionando un número erroneo al mostrar 1 más del que deberia ya que contamos los 'NULL' con la consulta 9.
*/
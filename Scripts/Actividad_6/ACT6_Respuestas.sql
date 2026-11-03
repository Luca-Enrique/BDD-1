USE colegio_db;

/* 1. Generar una consulta que muestre el apellido en mayúsculas, 
el nombre capitalizado/normal, 
y una columna llamada nombre_completo que una ambos con un espacio como separador. 
Además, extraiga únicamente el dominio de los correos electrónicos de los alumnos (todo lo que está después del @).
*/

SELECT UPPER(apellido) AS apellido_mayus,
		nombre,
        CONCAT(nombre, ' ', apellido) AS nombre_completo,
        SUBSTRING(email, LOCATE('@', email) + 1) AS dominio
FROM alumnos;

/* 2. Mostrar el apellido de los alumnos 
y la cantidad exacta de caracteres de su apellido, 
ordenados de manera ascendente según dicha longitud.
*/

SELECT apellido, CHAR_LENGTH(apellido) AS letras_apellido
FROM alumnos
ORDER BY letras_apellido ASC;

/* 3. Sobre la tabla productos, liste el nombre del producto, su precio original y calcule:
El precio final con un 21% de recargo, redondeado a 2 decimales.
El mismo cálculo pero utilizando TRUNCATE a 2 decimales. 
Observar y comentar en clase la diferencia práctica entre ambas funciones.
*/

SELECT nombre, precio AS precio_original,
		ROUND(precio * 100 / 21, 2) AS precio_final_redondeado,
        TRUNCATE(precio * 100 / 21, 2) AS precio_final_cortado
FROM productos;

# 4. Utilizar la tabla productos o alumnos para determinar si el ID del registro es 'Par' o'Impar'.	
SELECT id, IF(MOD(id, 2) = 0, 'Par', 'Impar') AS id_par_impar
FROM alumnos;

/* 5. En la tabla notas, mostrar el nombre del alumno, su nota y una columna llamada condición que evalúe lo siguiente:
Si la nota es 9 o más: 'Excelente' 
Si la nota es 6 o más: 'Aprobado' 
En cualquier otro caso: 'Desaprobado'
*/

SELECT a.nombre, n.nota,
		CASE
			WHEN n.nota >= 9 THEN 'Excelente'
            WHEN n.nota >= 6 THEN 'Aprobado'
            ELSE 'Desaprobado'
		END AS condicion
FROM notas n
INNER JOIN alumnos a ON n.alumno_id = a.id;

/* 6. A partir de la tabla alumnos, 
mostrar el nombre, 
la fecha de nacimiento formateada como DD/MM/YYYY 
y calcule la edad exacta en años cumplidos.
*/

SELECT nombre, DATE_FORMAT(fecha_nac, '%d/%m/%Y') AS fecha_nacimiento, TIMESTAMPDIFF(YEAR, fecha_nac, CURDATE()) AS anios
FROM alumnos;

# 7. Calcule una fecha de vencimiento sumando exactamente 15 días a la fecha_inscripción.
SELECT CONCAT(nombre, ' ', apellido) AS alumno, DATE_ADD(fecha_inscripcion, INTERVAL 15 DAY) AS fecha_vencimiento
FROM alumnos;

/* 8. Realizar una consulta sobre la tabla notas y cursos, agrupado por curso, que devuelva:
El nombre del curso. 
La cantidad total de notas registradas. 
El promedio de notas redondeado a 2 decimales. 
La nota máxima obtenida. 
Filtrar únicamente aquellos cursos cuyo promedio general sea mayor o igual a 6.
*/

SELECT c.nombre_curso AS curso, COUNT(n.nota) AS notas_totales_registradas, ROUND(AVG(n.nota), 2) AS promedio_notas, MAX(n.nota) AS nota_maxima
FROM notas n
INNER JOIN cursos c ON n.curso_id = c.id
GROUP BY c.nombre_curso
HAVING AVG(n.nota) >= 6;

# Desafio integrador
# Parte 1: Seleccione un alumno al azar de toda la base de datos utilizando la función RAND() combinada con ORDER BY y LIMIT 1.

SELECT RAND(id) AS id_random, CONCAT(nombre, ' ', apellido) AS alumno
FROM alumnos
ORDER BY id DESC LIMIT 1;

/* Parte 2: Genere un reporte que una las tablas alumnos, cursos y notas, donde se muestre 
el nombre y apellido concatenados en mayúsculas, 
el promedio de sus notas formateado, 
y el mes de inscripción extraído con MONTH y 
rellenado con ceros a la izquierda (ej. 05 en lugar de 5).
*/

SELECT UPPER(CONCAT(a.nombre, ' ', a.apellido)) AS alumno, c.nombre_curso AS curso, ROUND(AVG(n.nota), 1) AS nota_promedio, LPAD(MONTH(a.fecha_inscripcion), 2, '0') AS mes_inscripcion
FROM alumnos a
INNER JOIN cursos c ON a.curso_id = c.id
INNER JOIN notas n ON n.alumno_id = a.id AND n.curso_id = c.id
GROUP BY a.id, c.id;











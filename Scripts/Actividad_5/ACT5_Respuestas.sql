use sistema_proyectos;

/* 1.Listar apellido, nombre y salario de los empleados que ganan más que el promedio salarial
 de toda la empresa, ordenados de mayor a menor salario. 
 Pista: la subconsulta devuelve un único valor, así que se compara con >.
 
 Esta subconsulta devuelve el promedio del salario de los empleados.
 */
SELECT apellido, nombre, salario
FROM empleados
WHERE salario > 
                (SELECT AVG(salario)
                FROM empleados)
ORDER BY salario DESC;

/* 2. Mostrar los datos del empleado que tiene el salario más alto, sin usar ORDER BY ... LIMIT 1.

Esta subconsulta muestra el salario máximo dentro de la tabla 'empleados'.
Si 2 empleados tienen el mismo sueldo, muestra a los 2, con 'LIMIT 1' muestra solo uno hasta que se agregue una condición más.
 */
SELECT apellido, nombre, salario
FROM empleados
WHERE salario = 
                (SELECT MAX(salario)
                FROM empleados);

/* 3. Listar los empleados que trabajan en departamentos ubicados en Paraná. Resolverlo con subconsulta (no con JOIN).

Esta subconsulta muestra el id del departamento, la cual su ciudad sea 'Paraná'.
 */
SELECT nombre, apellido 
FROM empleados
WHERE departamento_id IN 
                        (SELECT id 
                        FROM departamentos 
                        WHERE ciudad = 'Paraná');

/* 4. Obtener los empleados que no tienen ninguna asignación a proyectos, usando:
SELECT nombre, apellido
FROM empleados
WHERE id NOT IN (SELECT empleado_id FROM asignaciones);

a) Ejecutarla y anotar cuántas filas devuelve.
No devuelve ninguna fila.

b) Explicar por qué devuelve ese resultado (mirar la fila 9 de asignaciones).
'asignaciones' tiene 'empleado_id' el cual puede ser 'NULL'.
Resultado: la consulta nunca devuelve filas, aunque en realidad la db tiene 3 empleados sin asignación (Fabian, Hernan y Julian).
Este es el comportamiento de tres valores lógicos de SQL: lo que no es TRUE se trata como FALSE.

c) Reescribirla de dos formas distintas para que dé el resultado correcto.
Podemos filtrar los NULL dentro de la subconsulta con 'IS NOT NULL'.
Otra alternativa es usando 'NOT EXISTS' con 'empleado_id', que compara fila a fila y trata
el NULL como una ausencia de coincidencia.
Las dos devuelven los 3 empleados sin ninguna asignación: Fabian, Hernan y Julian.
 */
SELECT nombre, apellido
FROM empleados
WHERE id NOT IN (SELECT empleado_id 
                FROM asignaciones);

SELECT nombre, apellido
FROM empleados
WHERE id NOT IN (SELECT empleado_id 
                FROM asignaciones 
                WHERE empleado_id IS NOT NULL);

SELECT nombre, apellido
FROM empleados e
WHERE NOT EXISTS (SELECT 1
                FROM asignaciones a
                WHERE a.empleado_id = e.id);

/* 5. Listar los empleados que ganan más que el promedio salarial de su propio departamento.
Mostrar apellido, departamento y salario.
Pista: la subconsulta interna tiene que referenciar la fila de la consulta externa (alias obligatorio).
 */
SELECT e.apellido, d.nombre AS departamento, e.salario
FROM empleados e
JOIN departamentos d ON d.id = e.departamento_id
WHERE e.salario > 
                (SELECT AVG(e2.salario) 
                FROM empleados e2 
                WHERE e2.departamento_id = e.departamento_id);

# 6. Listar los departamentos que tienen al menos un empleado asignado.
SELECT nombre, ciudad
FROM departamentos d
WHERE EXISTS 
            (SELECT 1 
            FROM empleados e 
            WHERE e.departamento_id = d.id);

/* 7. Listar los departamentos que no tienen ningún empleado. Comparar el resultado y el plan
de ejecución (EXPLAIN) contra la versión con NOT IN.
 */
SELECT nombre, ciudad
FROM departamentos d
WHERE NOT EXISTS 
                (SELECT 1 
                FROM empleados e 
                WHERE e.departamento_id = d.id);

EXPLAIN
SELECT nombre, ciudad
FROM departamentos d
WHERE NOT EXISTS 
                (SELECT 1 
                FROM empleados e 
                WHERE e.departamento_id = d.id);

SELECT nombre, ciudad
FROM departamentos d
WHERE d.id NOT IN 
                (SELECT e.departamento_id
                FROM empleados e
                WHERE e.departamento_id IS NOT NULL);

EXPLAIN
SELECT nombre, ciudad
FROM departamentos d
WHERE d.id NOT IN 
                (SELECT e.departamento_id
                FROM empleados e
                WHERE e.departamento_id IS NOT NULL);

/* 8. Mostrar apellido, nombre y una columna calculada 'cantidad_proyectos' con la cantidad de
proyectos distintos en los que participa cada empleado. Los empleados sin asignaciones deben
aparecer con 0, no con NULL.
 */
SELECT e.apellido, e.nombre,
       COALESCE((SELECT COUNT(DISTINCT a.proyecto_id)
                 FROM asignaciones a
                 WHERE a.empleado_id = e.id), 0) AS cantidad_proyectos
FROM empleados e
ORDER BY e.id;

/* 9. Mostrar el nombre del departamento y su salario promedio, solo para los departamentos cuyo
promedio supere los $650000. Resolverlo con una tabla derivada en el FROM.
Requisito: la tabla derivada tiene que llevar alias, si no MySQL tira error.
 */
SELECT d.nombre AS departamento, t.promedio_salario
FROM (SELECT departamento_id, AVG(salario) AS promedio_salario
      FROM empleados
      GROUP BY departamento_id
      HAVING AVG(salario) > 650000) AS t
JOIN departamentos d ON d.id = t.departamento_id
ORDER BY t.promedio_salario DESC;

# 10. a) Listar los empleados que ganan más que todos los empleados de Contabilidad.
SELECT apellido, nombre, salario
FROM empleados
WHERE salario > ALL (SELECT e.salario
                     FROM empleados e
                     JOIN departamentos d ON d.id = e.departamento_id
                     WHERE d.nombre = 'Contabilidad')
ORDER BY salario DESC;

# 10. b) Listar los empleados que ganan más que alguno de los empleados de Contabilidad.
SELECT apellido, nombre, salario
FROM empleados
WHERE salario > ANY (SELECT e.salario
                     FROM empleados e
                     JOIN departamentos d ON d.id = e.departamento_id
                     WHERE d.nombre = 'Contabilidad')
ORDER BY salario DESC;

/* 10. c) Diferencia conceptual entre '> ALL' y '> ANY', y con qué función de agregación se
podría reemplazar cada uno.
'> ALL' exige que la comparación sea verdadera contra TODOS los valores devueltos por la
subconsulta, así que se puede reemplazar por '> MAX()'. '> ANY' exige que sea verdadera contra
ALGUNO de los valores, así que se puede reemplazar por '> MIN()'.
 */

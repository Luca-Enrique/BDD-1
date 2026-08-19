USE gimnasio;

# 1. Agregá un socio nuevo con todos sus datos, usando `DEFAULT` en el campo del id. Verificá con un `SELECT *` que el id se haya generado solo.
INSERT INTO socios VALUES # Inserté en la tablas 'socios' un nuevo socio con mis datos
(DEFAULT, 'Luca', 'Enrique', '2005-08-08', '46675482', 'mensual');

SELECT * FROM socios; # selecioné de la tabla socios todo los registros para ver si el ID se autoincrementó solo

# 2. Cargale a ese socio dos rutinas en una sola sentencia `INSERT`.
INSERT INTO rutinas VALUES # Inserté los valores dentro de la tabla rutinas al socio con ID 11
(DEFAULT, 11, 4, 10, 15.00, 'Curl de cuadriceps'),
(DEFAULT, 11, 3, 12, 10.00, 'Curl de biceps');

SELECT * FROM rutinas WHERE idsocio = 11; # comprobé que se haya cargado 

# 3. Intentá cargar una rutina con un `idsocio` que no exista (por ejemplo 77). Anotá el error y explicá con tus palabras por qué el motor no lo deja
INSERT INTO rutinas VALUES
(DEFAULT, 77, 3, 15, 20.00, 'Curl de triceps'); # Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`gimnasio`.`rutinas`, CONSTRAINT `rutinas_ibfk_1` FOREIGN KEY (`idsocio`) REFERENCES `socios` (`idsocio`))
# El error dice que no puede agregar los valores que le puse, ya que no encuentra la referencia (la clave foranea) del ID que le estoy pasando, es decir, no encuentra en la tablas socios el idsocio '77'

# 4. Agregá a `socios` un campo `telefono` de tipo `VARCHAR(20)`. Mostrá la estructura con `DESCRIBE socios;`.
ALTER TABLE socios ADD telefono VARCHAR(20); # Agregamos el campo con alter table y lo dejamos que pueda ser null para que no tengamos que cargar los datos a los socios existentes

DESCRIBE socios; # muestra todos los campos de socios

# 5. Borrá el campo `telefono` que acabás de crear.
ALTER TABLE socios DROP telefono; # con drop borramos el campo 

# 6. Modificá `plan` en `socios` para que acepte hasta 25 caracteres y no admita nulos.
ALTER TABLE socios MODIFY plan VARCHAR(25) NOT NULL; # con modify nos permite modificar el campo

# 7. Cambiá el nombre del campo `nombre` por `nombre_socio`, manteniendo el tipo y la restricción. Después volvé a ejecutar una consulta vieja que usara `nombre` y anotá qué pasa.
alter table socios change nombre nombre_socio varchar(30) not null; # y aca change nos permite renombrar la columna

SELECT nombre FROM socios WHERE idsocio = 11; # Error Code: 1054. Unknown column 'nombre' in 'field list'
# Basicamente este error nos dice que no encuentra en la tabla socios la columna 'nombre', ya que posteriormente le cambiamos de nombre
SELECT nombre_socio FROM socios WHERE idsocio = 11; # Deberia funcionar y tirar 'Luca' como resultado

# 8. Cambiá el DNI del socio con `idsocio = 3` por el valor `43999999`.
UPDATE socios SET dni = 43999999 WHERE idsocio = 3; # con UPDATE actualizamos un registro

# 9. Pasá al plan `anual` a todos los socios que hoy tienen plan `trimestral`.
UPDATE socios SET plan = 'anual' WHERE plan = 'trimestral'; # cambia todos los planes que esten con 'trimestral' a 'anual'

SELECT * FROM socios; # Para confirmar que los cambios fueron realizados

# 10. Corregí el apellido `Juarez` (sin tilde) para que quede `Juárez` donde aparezca.
UPDATE socios SET apellido = 'Juárez' WHERE apellido = 'Juarez';

# 11. Intentá borrar el socio con `idsocio = 1`. Anotá el error. ¿Qué habría que hacer antes para poder borrarlo?
DELETE FROM socios WHERE idsocio = 1; # Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`gimnasio`.`asistencias`, CONSTRAINT `asistencias_ibfk_1` FOREIGN KEY (`idsocio`) REFERENCES `socios` (`idsocio`))

# Basicamente no nos deja borrar el socio 1 porque en otra tabla 'asistencias' usa esta id como clave foranea, y por ende debemos eliminar registros de estas tablas para poder eliminar el socio, sino, quedarian registros en tablas las cuales tienen un id de socio el cual no existe

# 12. Mostrá nombre y apellido de los socios cuyo apellido sea exactamente `Barrios`.
SELECT nombre_socio, apellido FROM socios WHERE apellido = 'Barrios';

# 13. Mostrá los socios cuyo apellido empiece con `A`.
SELECT * FROM socios WHERE apellido LIKE 'A%';

# 14. Mostrá los socios cuyo plan contenga la palabra `anual`. Prestá atención al resultado: fijate si aparece algo que no esperabas y explicá por qué.
SELECT * FROM socios WHERE plan LIKE 'anual';

# Despues de ejecutar la sentencia no noto alguna diferencia además de la obvia, la cual es que hay más planes anuales de los que habia, ya que posteriormente cambiamos todos los planes trimestrales a anuales.

# 15. **Para pensar:** compará `WHERE apellido = 'Juarez'` con `WHERE apellido LIKE 'J%'`. ¿Por qué no dan lo mismo? Fijate bien en las tildes de los datos cargados.
# selecciona todos los apellido que sean tal cual 'Juarez'
SELECT * FROM socios WHERE apellido = 'Juarez'; # Despues de correrlo, puedo ver que no solo muestra los apellidos que se muestran tal cual como 'Juarez', sino que tambeien los que llevan tilde

# selecciona todos los apellidos que empiezen por J
SELECT * FROM socios WHERE apellido LIKE 'J%'; # Acá queda igual como lo habia predecido

# Y despues de analizar los dos resultados, puedo decir que dan lo mismo, aunque, si habria un socio mas cargado que no se apellide 'Juárez' y se apellide por ejemplo 'Jurado', en ese caso si solo se mostraria en la segunda sentencia, ya que esta toma todos los apellidos que empiecen por 'J'
# EJEMPLO
INSERT INTO socios VALUES 
(DEFAULT, 'Romero', 'Jurado', '1999-05-12', 41010101, 'anual');

# Despues de correr esta sentencia podemos ver claramente la diferencia

# 16. Mostrá ejercicio y peso de las rutinas que superan los 40 kg.
SELECT idrutina, ejercicio, peso_kg FROM rutinas WHERE peso_kg > 40.00;

# 17. Mostrá las rutinas con peso mayor a 30 kg **y** repeticiones menores o iguales a 12.
SELECT idrutina, ejercicio, repeticiones, peso_kg FROM rutinas WHERE peso_kg > 30.00 AND repeticiones <= 12;

# 18. Mostrá ejercicio y peso ordenados de mayor a menor peso.
SELECT idrutina, ejercicio, peso_kg FROM rutinas ORDER BY peso_kg DESC;

# 19. Mostrá los socios nacidos en el mes de abril.
SELECT * FROM socios WHERE month(fecha_nac) = 4;

# 20. Mostrá los socios nacidos en el año 1998, primero con `YEAR()` y después con un rango de fechas. Compará los dos resultados.
SELECT * FROM socios WHERE year(fecha_nac) = 1998; # con year()

SELECT * FROM socios WHERE fecha_nac > '1998-01-01' AND fecha_nac < '1999-01-01'; # con un rango de fechas

# Los dos resultados muestran lo mismo, pero para db grandes es mejor usar la segunda sentencia, ya que solo recorre ese rango, sino tiene que recorrer fecha por fecha y puede tardar mas

# 21. Mostrá las ventas realizadas hoy.
SELECT * FROM ventas WHERE fecha_venta = CURDATE(); 

# 22. Mostrá apellido y nombre del socio junto al ejercicio y el peso de cada rutina.
SELECT socios.idsocio, socios.nombre_socio, socios.apellido, rutinas.ejercicio, rutinas.peso_kg FROM socios INNER JOIN rutinas ON socios.idsocio = rutinas.idsocio;

# 23. Mostrá nombre del socio y actividad de cada asistencia, solo de los socios cuyo nombre empiece con `M`.
SELECT socios.idsocio, socios.nombre_socio, asistencias.actividad FROM socios INNER JOIN asistencias ON socios.idsocio = asistencias.idsocio WHERE nombre_socio LIKE 'M%';

# 24. Mostrá apellido, nombre, ejercicio y actividad, uniendo `socios`, `rutinas` y `asistencias`. **Para pensar:** contá cuántas filas devuelve y comparalo con la cantidad de rutinas cargadas.
SELECT socios.idsocio, socios.nombre_socio, socios.apellido, rutinas.ejercicio, asistencias.actividad FROM socios INNER JOIN rutinas ON socios.idsocio = rutinas.idsocio INNER JOIN asistencias ON socios.idsocio = asistencias.idsocio;
# Aparecen 12 filas

SELECT * FROM rutinas; # Mientras que hay 13 rutinas cargadas

# Buscá el caso de Lucía y explicá qué está pasando.
# Mostrar los datos del socio 1 (Lucia)
SELECT socios.idsocio, socios.nombre_socio, socios.apellido, socios.plan, rutinas.series, rutinas.repeticiones, rutinas.peso_kg, rutinas.ejercicio, asistencias.fecha_ingreso, asistencias.actividad 
FROM socios 
INNER JOIN rutinas ON socios.idsocio = rutinas.idsocio 
INNER JOIN asistencias ON socios.idsocio = asistencias.idsocio 
WHERE socios.idsocio = 1;

# Lucia aparece 4 veces ya que tiene 2 rutinas cargadas, y a su vez tiene 4 asistencias, 1 por cada rutina en 2 dias diferentes, es por esto que aparece 4 veces con la sentencia anterior

# Después averiguá qué socio no aparece a pesar de tener rutina, y por qué.
SELECT * FROM socios; # Los socios que no aparecen son los con id 4, 11 y 12, pero solo el 4 y el 11 tiene minimo 1 rutina cargada
# Ahora, porque no aparecen... 
# porque ninguno de los dos tienen una asistencia cargada en esta tabla, teniendo en cuenta que la sentencia muestra solo los usuarios los cuales su id esten en las tablas socios, rutinas y asistencias, si el id del socio no aparece en las 3 tablas, no lo muestra con la sentencia SELECT
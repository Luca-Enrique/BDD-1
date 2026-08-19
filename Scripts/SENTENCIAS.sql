use biblioteca;

# SENTENCIAS PARA AGREGAR, BORRAR Y MODIFICAR CAMPOS

# AGREGAR
alter table autores add apellido varchar(15) not null after nombre; 

# BORRAR
alter table autores drop apellido;

# MODIFICAR
alter table autores modify apellido varchar(40) not null;
alter table generos change nombre genero varchar(30) not null;

describe autores;
describe generos;

# SENTENCIAS PARA AGREGAR, BORRAR Y MODIFICAR REGISTROS

# BORRAR
delete from autores where idautor = 11;

# MODIFICAR / AGREGAR
update autores set apellido = "Shakespeare" where idautor = 1;

# INSERTAR 1 REGISTRO
insert into autores values 
(#VALORES
);

# INSERTAR VARIOS REGISTROS
insert into autores values 
(#VALORES DEFAULT, 11, 4, 10, 15.00, 'Curl de cuadriceps'
), # IMPORTANTE LA COMA
(#VALORES DEFAULT, 11, 3, 12, 10.00, 'Curl de biceps'
);

# CONSULTAS DE SELECCIÓN

select nombre, apellido from autores where nombre = "William";

SELECT * from autores;

select idautor, nombre, apellido from autores where nombre like 'J%';
select idautor, nombre, apellido from autores where nombre like '%l';

# CON NUMEROS
select idautor, nombre, apellido from autores where idautor = 1;

select numero1, numero2 from nombre_tabla where numero1 >= 4 and numero2 <= 5;
select numero1, numero2 from nombre_tabla where numero1 >= 4 or numero2 <= 5;

# MOSTRAR DE MAYOR A MENOR
SELECT idrutina, ejercicio, peso_kg FROM rutinas ORDER BY peso_kg DESC;

# MOSTRAR DE MENOR A MAYOR
SELECT idrutina, ejercicio, peso_kg FROM rutinas ORDER BY peso_kg ASC;

# CON FECHAS
select idprestamo, idsocio, idlibro, fecha_prestamo, fecha_devolucion from prestamos where month(fecha_prestamo) = 4;
select idautor, nombre, apellido, anio_nacimiento from autores where year(anio_nacimiento) = 1942;
select idautor, nombre, apellido, anio_nacimiento from autores where day(anio_nacimiento) = 11;

select idautor, nombre, apellido, anio_nacimiento from autores where anio_nacimiento >= '1940-01-01';

# RANGO DE FECHAS 
SELECT * FROM socios WHERE fecha_nac > '1998-01-01' AND fecha_nac < '1999-01-01';

# Consultas para 2 o más tablas
select titulo, anio_publicacion 
from libros 
inner join prestamos ON libros.idlibro = prestamos.idlibro;

SELECT socios.idsocio, socios.nombre_socio, socios.apellido, rutinas.ejercicio, rutinas.peso_kg 
FROM socios 
INNER JOIN rutinas ON socios.idsocio = rutinas.idsocio;

# si queremos agregar clausulas como nombres que empeicen con M.
SELECT socios.idsocio, socios.nombre_socio, asistencias.actividad 
FROM socios 
INNER JOIN asistencias ON socios.idsocio = asistencias.idsocio 
WHERE nombre_socio LIKE 'M%';

# Union de 4 tablas
SELECT a.apellido AS alumno, c.nombre AS curso, p.apellido AS profesor
FROM inscripciones i
INNER JOIN alumnos a ON i.id_alumno = a.id_alumno
INNER JOIN cursos c ON i.id_curso = c.id_curso
INNER JOIN profesores p ON c.id_profesor = p.id_profesor;

# DISTINCT, se usa pra eliminar datos repetititvos
SELECT DISTINCT idioma FROM cursos;












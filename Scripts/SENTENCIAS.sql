# ============================================================
# GUÍA DE SENTENCIAS SQL
# ============================================================
# Esta guía reúne ejemplos que se apoyan en varias bases:
#   biblioteca        -> autores, generos, libros, prestamos, socios
#   gimnasio          -> socios, rutinas, asistencias, ventas
#   instituto_idiomas -> alumnos, cursos, profesores, inscripciones
#   veterinaria_joins -> duenios, mascotas, tratamientos, turnos
#
# Cada sección aclara con un USE a qué base corresponde.
# Requisito: tener creadas las bases y cargados sus datos de prueba.
# ============================================================


# ============================================================
# 1. MODIFICAR LA ESTRUCTURA (DDL): agregar, borrar y modificar campos
# ============================================================
USE biblioteca;

# AGREGAR un campo
alter table autores add apellido varchar(15) not null after nombre;

# MODIFICAR el tipo de un campo (requiere que el campo exista)
alter table autores modify apellido varchar(40) not null;

# CAMBIAR el nombre de un campo
alter table generos change nombre genero varchar(30) not null;

# Ver la estructura de las tablas modificadas
describe autores;
describe generos;

# BORRAR un campo
alter table autores drop apellido;

# El DROP se deja al final del bloque: se vuelve a agregar el campo
# para que los ejemplos de las secciones siguientes puedan usarlo.
alter table autores add apellido varchar(40) not null after nombre;


# ============================================================
# 2. INSERTAR REGISTROS (DML - INSERT)
# ============================================================
USE biblioteca;

# INSERTAR 1 REGISTRO
insert into autores values
(DEFAULT, 'Mario', 'Benedetti', '1920-09-14');

# INSERTAR VARIOS REGISTROS EN UNA MISMA SENTENCIA
# Datos inventados de ejemplo, pensados para que las consultas
# de la seccion 4 (LIKE) y de la seccion 7 (fechas) tengan resultado.
insert into autores values
(DEFAULT, 'Pablo', 'Neruda', '1904-07-12'
), # IMPORTANTE LA COMA ENTRE REGISTROS
(DEFAULT, 'Isabel', 'Allende', '1942-08-02'
), # nacio en 1942 -> para YEAR(anio_nacimiento) = 1942
(DEFAULT, 'Sandra', 'Cisneros', '1954-08-11'
), # nacio un dia 11 -> para DAY(anio_nacimiento) = 11
(DEFAULT, 'Julio', 'Cortázar', '1914-08-26'
), # empieza con J -> para LIKE 'J%'
(DEFAULT, 'Jorge Luis', 'Borges', '1899-08-24'
), # empieza con J -> para LIKE 'J%'
(DEFAULT, 'Gabriel', 'García Márquez', '1927-03-06'
); # termina en l -> para LIKE '%l'


# ============================================================
# 3. MODIFICAR Y BORRAR REGISTROS (DML - UPDATE / DELETE)
# ============================================================
USE biblioteca;

# MODIFICAR el valor de un campo
update autores set apellido = "Shakespeare" where idautor = 1;

# BORRAR un registro
delete from autores where idautor = 11;


# ============================================================
# 4. CONSULTAS DE SELECCIÓN CON TEXTOS
# ============================================================
USE biblioteca;

# Igualdad exacta
select nombre, apellido from autores where nombre = "William";

# Ver todos los registros
select * from autores;

# Que empiecen con J
select idautor, nombre, apellido from autores where nombre like 'J%';

# Que terminen en l
select idautor, nombre, apellido from autores where nombre like '%l';

# Referencia de patrones LIKE (se usan como texto de ayuda, no como consulta):
# 'A%'     -> comienza con A
# '%a'     -> termina con a
# '%Pro%'  -> contiene Pro


# ============================================================
# 5. CONSULTAS DE SELECCIÓN CON NÚMEROS Y OPERADORES
# ============================================================
USE gimnasio;

# Igualdad exacta (sobre numeros)
select idsocio, nombre, apellido from socios where idsocio = 1;

# Mayor o igual, y menor o igual (AND = deben cumplirse las dos)
select ejercicio, peso_kg, repeticiones from rutinas where peso_kg >= 30 and repeticiones <= 12;

# Una u otra condicion (OR = con que se cumpla una alcanza)
select ejercicio, peso_kg, repeticiones from rutinas where peso_kg >= 60 or repeticiones <= 8;

# Combinar condiciones numericas en otra tabla
USE veterinaria_joins;
select id_tratamiento, descripcion, precio from tratamientos where precio > 5000 and precio < 15000;


# ============================================================
# 6. ORDENAR RESULTADOS (ORDER BY)
# ============================================================
USE gimnasio;

# MOSTRAR DE MAYOR A MENOR
select idrutina, ejercicio, peso_kg from rutinas order by peso_kg desc;

# MOSTRAR DE MENOR A MAYOR
select idrutina, ejercicio, peso_kg from rutinas order by peso_kg asc;


# ============================================================
# 7. CONSULTAS DE SELECCIÓN CON FECHAS
# ============================================================
USE biblioteca;

# Registros de un mes puntual
select idprestamo, idsocio, idlibro, fecha_prestamo, fecha_devolucion from prestamos where month(fecha_prestamo) = 4;

# Registros de un año puntual
select idautor, nombre, apellido, anio_nacimiento from autores where year(anio_nacimiento) = 1942;

# Registros de un dia puntual
select idautor, nombre, apellido, anio_nacimiento from autores where day(anio_nacimiento) = 11;

# Desde una fecha en adelante
select idautor, nombre, apellido, anio_nacimiento from autores where anio_nacimiento >= '1940-01-01';

# RANGO DE FECHAS: entre dos fechas (tabla socios de la base gimnasio)
USE gimnasio;
select * from socios where fecha_nac > '1998-01-01' and fecha_nac < '1999-01-01';

# Registros del año en curso con la funcion YEAR()
select producto, monto_vendido, fecha_venta from ventas where year(fecha_venta) = 2026;

# Funciones de fecha disponibles: YEAR(fecha), MONTH(fecha), DAY(fecha)


# ============================================================
# 8. CONSULTAS PARA DOS O MÁS TABLAS (JOIN)
# ============================================================
USE biblioteca;

# Unir 2 tablas con INNER JOIN
select titulo, anio_publicacion
from libros
inner join prestamos on libros.idlibro = prestamos.idlibro;

# Unir 2 tablas y filtrar con WHERE
USE gimnasio;
select socios.idsocio, socios.nombre_socio, socios.apellido, rutinas.ejercicio, rutinas.peso_kg
from socios
inner join rutinas on socios.idsocio = rutinas.idsocio;

# Unir 2 tablas agregando condiciones (nombres que empiecen con M)
select socios.idsocio, socios.nombre_socio, asistencias.actividad
from socios
inner join asistencias on socios.idsocio = asistencias.idsocio
where nombre_socio like 'M%';

# Unir 3 tablas: socio + rutina + asistencia
select s.idsocio, s.apellido, r.ejercicio, r.peso_kg, a.actividad
from socios s
inner join rutinas r on s.idsocio = r.idsocio
inner join asistencias a on s.idsocio = a.idsocio;

# Union de 4 tablas (alumno + curso + profesor a traves de inscripciones)
USE instituto_idiomas;
select a.apellido as alumno, c.nombre as curso, p.apellido as profesor
from inscripciones i
inner join alumnos a on i.id_alumno = a.id_alumno
inner join cursos c on i.id_curso = c.id_curso
inner join profesores p on c.id_profesor = p.id_profesor;

# Unir tablas y ordenar por mas de una columna (la segunda actua
# como criterio de desempate de la primera)
USE veterinaria_joins;
select *
from mascotas m
inner join duenios d on m.id_duenio = d.id_duenio
order by d.apellido, m.nombre;

# DISTINCT: elimina resultados repetidos
USE instituto_idiomas;
select distinct idioma from cursos;


# ============================================================
# 9. AGREGACIÓN: GROUP BY Y HAVING
# ============================================================
USE gimnasio;

# Funciones de agregacion disponibles:
# MAX(campo) -> maximo | MIN(campo) -> minimo | SUM(campo) -> suma
# AVG(campo) -> promedio | COUNT(campo) -> cantidad

# Cantidad de asistencias por socio (agrupar y contar)
select idsocio, count(*) as cantidad_asistencias
from asistencias
group by idsocio;

# HAVING filtra los resultados ya agrupados (a diferencia del WHERE,
# que filtra filas antes de agrupar). Ej.: socios con 2 o mas asistencias.
select idsocio, count(*) as cantidad_asistencias
from asistencias
group by idsocio
having count(*) >= 2;
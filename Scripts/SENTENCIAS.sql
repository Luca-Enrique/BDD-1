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

# Funciones de agregación disponibles: COUNT, SUM, AVG, MIN y MAX.
# La referencia completa de cada una está en la sección 10.5.

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

# ============================================================
# 10. FUNCIONES (referencia rápida)
# ============================================================
# Las funciones van sin comentar para que se destaquen.
# Las aclaraciones y los ejemplos (EJ) sí van comentados con #.

# ------------------------------------------------------------
# 10.1 FUNCIONES DE TEXTO
# ------------------------------------------------------------

CONCAT(a, b)  # une 2 o más valores en un solo texto
#   EJ: CONCAT('Luca', ' ', 'Enrique')  ->  'Luca Enrique'
#   (el ' ' del medio se usa como separador)

CONCAT_WS(sep, a, b)  # igual que CONCAT, pero recibe el separador primero
#   EJ: CONCAT_WS('-', 'A', 'B')  ->  'A-B'

UPPER(t)  # pasa el texto a mayúsculas
#   EJ: UPPER('enrique')  ->  'ENRIQUE'

LOWER(t)  # pasa el texto a minúsculas
#   EJ: LOWER('ENRIQUE')  ->  'enrique'

LENGTH(t)  # largo del texto en BYTES (la ñ y los acentos ocupan 2)
#   EJ: LENGTH('año')  ->  4

CHAR_LENGTH(t)  # largo del texto en CARACTERES
#   EJ: CHAR_LENGTH('año')  ->  3

SUBSTRING(t, pos, n)  # extrae n caracteres desde la posición pos
#   EJ: SUBSTRING('MySQL', 1, 2)  ->  'My'   (desde la 1 = 'M', 2 caracteres)

LEFT(t, n)  # toma los primeros n caracteres
#   EJ: LEFT('2026-09', 4)  ->  '2026'

RIGHT(t, n)  # toma los últimos n caracteres
#   EJ: RIGHT('2026-09', 2)  ->  '09'

TRIM(t)  # saca los espacios en blanco de ambos lados
#   EJ: TRIM(' hola ')  ->  'hola'
#   Variantes: LTRIM(t) saca solo los de la izquierda y RTRIM(t) los de la derecha

REPLACE(t, busca, nuevo)  # reemplaza todas las apariciones de "busca" por "nuevo"
#   EJ: REPLACE('a-b-c', '-', '/')  ->  'a/b/c'

LOCATE(busca, t)  # posición donde aparece "busca"; NULL si no está
#   EJ: LOCATE('@', 'ana@x.com')  ->  4

LPAD(t, n, relleno)  # rellena por la izquierda hasta llegar a n caracteres
#   EJ: LPAD('7', 3, '0')  ->  '007'


# ------------------------------------------------------------
# 10.2 FUNCIONES NUMÉRICAS
# ------------------------------------------------------------

ROUND(n, d)  # redondea a d decimales; sin d, redondea a entero
#   EJ: ROUND(7.456, 2)  ->  7.46

TRUNCATE(n, d)  # recorta a d decimales sin redondear
#   EJ: TRUNCATE(7.456, 2)  ->  7.45

CEIL(n)  # redondea siempre hacia arriba
#   EJ: CEIL(7.1)  ->  8

FLOOR(n)  # redondea siempre hacia abajo
#   EJ: FLOOR(7.9)  ->  7

ABS(n)  # valor absoluto (sin signo)
#   EJ: ABS(-5)  ->  5

MOD(a, b)  # resto de la división entera
#   EJ: MOD(10, 3)  ->  1

POW(a, b)  # a elevado a b
#   EJ: POW(2, 3)  ->  8

SQRT(n)  # raíz cuadrada
#   EJ: SQRT(16)  ->  4

RAND()  # número decimal al azar entre 0 y 1
#   EJ: RAND()  ->  0.7312...


# ------------------------------------------------------------
# 10.3 FUNCIONES DE FECHAS Y HORAS
# ------------------------------------------------------------

NOW()  # fecha y hora actuales
#   EJ: NOW()  ->  '2026-09-15 10:30:00'

CURDATE()  # solo la fecha actual
#   EJ: CURDATE()  ->  '2026-09-15'

CURTIME()  # solo la hora actual
#   EJ: CURTIME()  ->  '10:30:00'

YEAR(f) / MONTH(f) / DAY(f)  # extraen el año, el mes o el día de una fecha
#   EJ: MONTH('2026-09-15')  ->  9

DAYNAME(f)  # nombre del día (en inglés por defecto)
#   EJ: DAYNAME('2026-09-15')  ->  'Tuesday'

DATEDIFF(f1, f2)  # días de diferencia entre f1 y f2 (f1 - f2)
#   EJ: DATEDIFF('2026-09-15', '2026-09-01')  ->  14

TIMESTAMPDIFF(u, f1, f2)  # diferencia en la unidad u (YEAR, MONTH, DAY...)
#   EJ: TIMESTAMPDIFF(YEAR, '2000-05-10', CURDATE())  ->  26

DATE_ADD(f, INTERVAL n u)  # suma tiempo a una fecha (DATE_SUB resta)
#   EJ: DATE_ADD('2026-09-15', INTERVAL 7 DAY)  ->  '2026-09-22'

DATE_FORMAT(f, formato)  # muestra la fecha con el formato indicado
#   EJ: DATE_FORMAT('2026-09-15', '%d/%m/%Y')  ->  '15/09/2026'

# Códigos más usados en DATE_FORMAT:
#   %d  Día (01-31)          %H  Hora (00-23)
#   %m  Mes (01-12)          %i  Minutos (00-59)
#   %Y  Año con 4 dígitos    %s  Segundos (00-59)
#   %y  Año con 2 dígitos    %W  Nombre del día


# ------------------------------------------------------------
# 10.4 FUNCIONES DE CONTROL DE FLUJO
# ------------------------------------------------------------

IF(cond, v1, v2)  # si la condición es verdadera devuelve v1; si no, v2
#   EJ: IF(8 >= 6, 'Sí', 'No')  ->  'Sí'

IFNULL(v, alternativo)  # si v es NULL devuelve el alternativo; si no, v
#   EJ: IFNULL(NULL, 'Sin dato')  ->  'Sin dato'

COALESCE(a, b, c...)  # devuelve el primer valor que no sea NULL
#   EJ: COALESCE(NULL, NULL, 'X')  ->  'X'

NULLIF(a, b)  # devuelve NULL si a y b son iguales; si no, a
#   EJ: NULLIF(5, 5)  ->  NULL

CASE ... END  # evalúa condiciones en orden y devuelve el valor de la primera verdadera
#   EJ: CASE WHEN nota >= 9 THEN 'Excelente'
#            WHEN nota >= 6 THEN 'Aprobado'
#            ELSE 'Desaprobado' END


# ------------------------------------------------------------
# 10.5 FUNCIONES DE AGREGACIÓN
# ------------------------------------------------------------
# Ver también la sección 9 (GROUP BY y HAVING).

COUNT(*)  # cuenta todas las filas, incluidas las que tienen NULL
#   EJ: COUNT(*)  ->  30

COUNT(columna)  # cuenta solo las filas donde esa columna NO es NULL
#   EJ: COUNT(telefono)  ->  25

COUNT(DISTINCT col)  # cuenta valores distintos
#   EJ: COUNT(DISTINCT curso)  ->  3

SUM(col)  # suma los valores
#   EJ: SUM(importe)  ->  15400

AVG(col)  # promedio de los valores (ignora NULL)
#   EJ: AVG(nota)  ->  7.25

MAX(col) / MIN(col)  # valor máximo / mínimo (también funcionan con texto y fechas)
#   EJ: MAX(nota)  ->  10

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
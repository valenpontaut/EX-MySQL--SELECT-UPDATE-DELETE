/*Creo la base de datos y las tablas con las claves primarias y foraneas correspondientes*/
CREATE DATABASE DESAFIODB;
USE DESAFIODB;

CREATE TABLE deptos
(id INT(10) NOT NULL,
Nombre_departamento VARCHAR(45) NOT NULL,
Presupuesto INT(10) NOT NULL,
PRIMARY KEY(id));

CREATE TABLE empleados
(DNI INT(9) NOT NULL,
Nombre VARCHAR(45) NOT NULL,
Apellidos VARCHAR(45) NOT NULL,
Numero_departamento INT(10) NOT NULL, 
PRIMARY KEY(DNI),
CONSTRAINT FK_DeptoEmpleado
FOREIGN KEY (Numero_departamento)
REFERENCES deptos(id));

INSERT INTO deptos (id,Nombre_departamento,Presupuesto)
VALUES
(14,"Informática",80000),
(77,"Investigación",40000),
(15,"Gestión",95000),
(37,"Desarrollo",65000),
(16,"Comunicación",75000);

INSERT INTO empleados (DNI,Nombre,Apellidos,Numero_departamento)
VALUES
(31096678,"Juan","Lopez",14),
(31096675,"Martin","Zarabia",77),
(34269854,"Jose","Velez",77),
(41369852,"Paula","Madariaga",77),
(33698521,"Pedro","Perez",14),
(32698547,"Mariana","Lopez",15),
(42369854,"Abril","Sanchez",37),
(36125896,"Marti","Julia",14),
(36985471,"Omar","Diaz",15),
(32145698,"Guadalupe","Perez",77),
(32369854,"Bernardo","pantera",37),
(36125965,"Lucia","Pesaro",14),
(31236985,"Maria","diamante",14),
(32698548,"Carmen","barbieri",16);

/*2.1 obtener los apellidos de los empleados*/
SELECT Apellidos
FROM empleados;

/*2.2 obtener los apellidos de los empleados sin repeticiones*/
SELECT DISTINCT Apellidos
FROM empleados;

/*2.3 obtener los datos de los empleados que tengan el apellido Lopez*/
SELECT *
FROM empleados
INNER JOIN deptos ON empleados.Numero_departamento = deptos.id
WHERE Apellidos="Lopez";

/*2.4 obtener los datos de los empleados que tengan el apellido Lopez y los que tengan apellido Perez*/
SELECT *
FROM empleados
INNER JOIN deptos ON empleados.Numero_departamento = deptos.id
WHERE Apellidos="Lopez" OR Apellidos="Perez";

/*2.5 Obtener todos los datos de los empleados que trabajen en el departamento 14*/
SELECT *
FROM empleados
INNER JOIN deptos ON empleados.Numero_departamento = deptos.id
WHERE Numero_departamento=14;

/*2.6 Obtener todos los datos de los empleados que trabajen en el departamento 37 y 77*/
SELECT *
FROM empleados
INNER JOIN deptos ON empleados.Numero_departamento = deptos.id
WHERE Numero_departamento=37 OR Numero_departamento=77;

/*2.7 Obtener los datos de los empleados cuyo apellido comience con P*/
SELECT *
FROM empleados
INNER JOIN deptos ON empleados.Numero_departamento = deptos.id
WHERE Apellidos LIKE 'P%';

/*2.8 Obtener el presupuesto total de todos los departamentos*/
SELECT SUM(Presupuesto) AS "Suma de presupuestos"
FROM deptos;

/*2.9 Obtener un listado completo de empleados, incluyendo por cada empleado los datos del empleado y de su departamento*/
SELECT *
FROM empleados
INNER JOIN deptos ON empleados.Numero_departamento = deptos.id;

/*2.10 Obtener un listado completo de empleados, incluyendo el nombre y apellido del empleado junto al nombre y presupuesto de su departamento*/
SELECT empleados.Nombre,empleados.Apellidos,deptos.Nombre_departamento,deptos.Presupuesto
FROM empleados
INNER JOIN deptos ON empleados.Numero_departamento = deptos.id;

/*2.11 Obtener los nombres y apellidos de los empleados que trabajen en departamentos cuyo presupuesto sea mayor de 60000*/
SELECT Nombre,Apellidos
FROM empleados
INNER JOIN deptos ON empleados.Numero_departamento = deptos.id
WHERE deptos.Presupuesto > 60000;

/*2.12 Añadir un nuevo departamento: Calidad con un presupuesto de 40000 y código 11, añadir un empleado vinculado al departamento recién creado: Esther Vazquez, DNI 89267109*/
INSERT INTO deptos (id,Nombre_departamento,Presupuesto)
VALUES (11,"Calidad",40000);
INSERT INTO empleados (DNI,Nombre,Apellidos,Numero_departamento)
VALUES (89267109,"Esther","Vazquez",11);

/*2.13 Aplicar un recorte presupuestario del 10% a todos los departamentos*/
UPDATE deptos
SET Presupuesto = Presupuesto * 0.9;

/*2.14 Reasignar a los empleados del departamento de investigación (código 77) al departamento de informática (código 14)*/
UPDATE empleados
SET Numero_departamento = 14
WHERE Numero_departamento = 77;

/*2.15 Despedir a los empleados del departamento de informática (código 14)*/
DELETE FROM empleados
WHERE Numero_departamento = 14;

/*2.16 Despedir a los empleados que trabajen en departamentos con un presupuesto superior a 90000*/
DELETE empleados
FROM empleados
INNER JOIN deptos ON empleados.Numero_departamento = deptos.id
WHERE deptos.Presupuesto > 90000;
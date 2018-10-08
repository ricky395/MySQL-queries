CREATE TABLE proyectos(
	CodP VARCHAR(3) NOT NULL,
	descripcion VARCHAR(20),
	localidad VARCHAR(15),
	cliente VARCHAR(25),
	telefono VARCHAR(15)
	);

CREATE TABLE maquinas(
	CodM VARCHAR(3) NOT NULL,
	nombre VARCHAR(15),
	preciohora INTEGER
	);

CREATE TABLE conductores(
	CodC VARCHAR(3) NOT NULL,
	nombre VARCHAR(20),
	localidad VARCHAR(15),
	categoria INTEGER
	);

CREATE TABLE trabajos(
	CodC VARCHAR(3) NOT NULL,
	CodM VARCHAR(3) NOT NULL,
	CodP VARCHAR(3) NOT NULL,
	fecha DATE NOT NULL,
	tiempo INTEGER,
	PRIMARY KEY(CodC,CodM,CodP,fecha)
	);

INSERT INTO proyectos VALUES ('P01','garaje','arganda','Felipe SOL','600111111');
INSERT INTO proyectos VALUES ('P02','solado','rivas','Jose Perez','912222222');
INSERT INTO proyectos VALUES ('P03','garaje','arganda','Rosa Lopez','666999666');
INSERT INTO proyectos VALUES ('P04','techado','loeches','Jose Perez','913333333');
INSERT INTO proyectos VALUES ('P05','buhardilla','rivas','Ana Botijo',NULL);


INSERT INTO maquinas VALUES ('M01','excavadora',15000);
INSERT INTO maquinas VALUES ('M02','hormigonera',10000);
INSERT INTO maquinas VALUES ('M03','volquete',11000);
INSERT INTO maquinas VALUES ('M04','apisonadora',18000);


INSERT INTO conductores VALUES ('C01','Jose Sanchez','arganda',18);
INSERT INTO conductores VALUES ('C02','Manuel Diaz','arganda',15);
INSERT INTO conductores VALUES ('C03','Juan Perez','rivas',20);
INSERT INTO conductores VALUES ('C04','Luis Ortiz','arganda',18);
INSERT INTO conductores VALUES ('C05','Javier Martin','loeches',12);
INSERT INTO conductores VALUES ('C06','Carmen Perez','rivas',15);


INSERT INTO trabajos VALUES ('C02','M03','P01','2002-09-10',100);
INSERT INTO trabajos VALUES ('C03','M01','P02','2002-09-10',200);
INSERT INTO trabajos VALUES ('C05','M03','P02','2002-09-10',150);
INSERT INTO trabajos VALUES ('C04','M03','P02','2002-09-10',90);
INSERT INTO trabajos VALUES ('C01','M02','P02','2002-09-12',120);
INSERT INTO trabajos VALUES ('C02','M03','P03','2002-09-13',30);
INSERT INTO trabajos VALUES ('C03','M01','P04','2002-09-15',300);
INSERT INTO trabajos VALUES ('C02','M03','P02','2002-09-15',NULL);
INSERT INTO trabajos VALUES ('C01','M03','P04','2002-09-15',180);
INSERT INTO trabajos VALUES ('C05','M03','P04','2002-09-15',90);
INSERT INTO trabajos VALUES ('C01','M02','P04','2002-09-17',NULL);
INSERT INTO trabajos VALUES ('C02','M03','P01','2002-09-18',NULL);



1. Obtener el nombre de los conductores con categoría 15.

SELECT c.nombre
FROM conductores c
WHERE c.categoria=15;

2. Obtener la descripción de los proyectos en los que se haya realizado trabajos durante los días 11 al 15 de
septiembre de 2002.

SELECT DISTINCT p.descripcion
FROM proyectos p, trabajos t
WHERE p.CodP=t.CodP
AND t.fecha BETWEEN '2002-09-11' AND '2002-09-15';

3. Obtener el nombre de los conductores que hayan trabajado con una Hormigonera, ordenados
descendentemente.

SELECT DISTINCT c.nombre
FROM conductores c, trabajos t, maquinas m
WHERE c.CodC=t.CodC
AND m.CodM=t.CodM
AND m.nombre LIKE 'hormigonera'
ORDER BY c.nombre DESC;

4. Obtener el nombre de los conductores que hayan trabajado con una Hormigonera en proyectos de
Arganda.

SELECT DISTINCT c.nombre
FROM conductores c, trabajos t, maquinas m, proyectos p
WHERE c.CodC=t.CodC
AND p.CodP=t.CodP
AND m.CodM=t.CodM
AND p.localidad ='arganda'
AND m.nombre='hormigonera';

5. Obtener el nombre de los conductores y descripción del proyecto, 
para aquellos conductores que hayan trabajado con una Hormigonera en 
proyectos de Arganda durante los días 12 al 17 de Septiembre.

SELECT c.nombre, p.descripcion
FROM conductores c, trabajos t, maquinas m, proyectos p
WHERE c.CodC=t.CodC
AND m.CodM=t.CodM
AND p.CodP=t.CodP 
AND p.localidad ='arganda'
AND m.nombre='hormigonera'
AND t.fecha BETWEEN '2002-09-12' AND '2002-09-17';

6. Obtener los conductores que trabajan en los proyectos de José Pérez.

SELECT DISTINCT c.nombre
FROM conductores c, proyectos p, trabajos t
WHERE c.CodC=t.CodC
AND p.CodP=t.CodP 
AND p.cliente LIKE 'Jose Perez';

7. Obtener el nombre y localidad de los conductores que NO trabajan 
en los proyectos de José Pérez

SELECT c.nombre, c.localidad
FROM conductores c, proyectos p, trabajos t
WHERE c.CodC=t.CodC
AND p.CodP=t.CodP 
AND p.cliente NOT LIKE 'Jose Perez';


8. Obtener todos los datos de los proyectos realizados en Rivas o que 
sean de un cliente llamado José.
SELECT *
FROM proyectos p
WHERE p.localidad LIKE 'rivas'
OR p.cliente LIKE 'Jose%';

9. Obtener los conductores que habiendo trabajado en algún proyecto, 
figuren sin horas trabajadas.

SELECT DISTINCT c.nombre
  FROM conductores c, trabajos t
 WHERE t.codC = c.codC 
   AND t.tiempo IS NULL;

10. Obtener los empleados que tengan como apellido Pérez y hayan trabajado en proyectos de localidades
diferentes a las suyas

SELECT c.nombre
FROM proyectos p,conductores c, trabajos t
WHERE c.CodC=t.CodC
AND p.CodP=t.CodP 
AND c.nombre LIKE '%Perez'
AND c.localidad NOT LIKE p.localidad;


11. Obtener el nombre de los conductores y la localidad del proyecto, 
para aquellos conductores que hayan trabajado con máquinas con precio 
hora comprendido entre 10000 y 15000 ptas.
SELECT DISTINCT c.nombre, p.localidad
  FROM conductores c, proyectos p, maquinas m, trabajos t
 WHERE c.codc = t.codc
   AND p.codp = t.codp
   AND m.codm = t.codm
   AND (m.preciohora >= 10000 AND m.preciohora <= 15000);

12. Obtener el nombre y localidad de los conductores, y la localidad 
del proyecto para aquellos proyectos que sean de Rivas y en los que 
no se haya utilizado una máquina de tipo Excavadora o una máquina de
tipo Hormigonera.
SELECT DISTINCT c.nombre AS nombre_conductor, c.localidad AS localidad_conductor, p.localidad AS localidad_proyecto
  FROM conductores c, proyectos p, maquinas m, trabajos t
 WHERE c.codc = t.codc
   AND p.codp = t.codp
   AND m.codm = t.codm
   AND p.localidad LIKE "Rivas"
   AND m.nombre NOT LIKE "Excavadora" AND m.nombre NOT LIKE "Hormigonera";

13. Obtener TODOS los datos de los proyectos, y para aquellos proyectos
realizados el día 15 de Septiembre, además incluir el nombre y 
localidad de los conductores que hayan trabajado en dicho proyecto.
SELECT p
       (SELECT c.nombre AS nombre_conductor, c.localidad AS localidad_conductor
	      FROM conductores c, trabajos t, proyectos p2
		 WHERE c.codc = t.codc
		   AND p.codp = t.codp
		   AND t.fecha LIKE '2002-09-15')
  FROM proyectos p 
  
  
SELECT p.*, c.Nombre, c.Localidad
  FROM Proyectos p LEFT JOIN (SELECT *
								FROM Trabajos t2
								WHERE t2.fecha LIKE '2002-09-15') 
Trabajos2 ON p.CodP = Trabajos2.CodP
  LEFT JOIN (SELECT *
     FROM Trabajos t3
     WHERE t3.fecha NOT LIKE '2002-09-15') Trabajos3 ON p.CodP = Trabajos3.CodP
  LEFT JOIN Conductores c ON Trabajos3.CodC = c.CodC;

14. Obtener el nombre de los conductores y el nombre y localidad de los
clientes, en los que se haya utilizado la máquina con precio hora más 
elevado.
SELECT c.nombre, p.cliente, p.localidad AS localidad_cliente
  FROM conductores c, trabajos t, maquinas m, proyectos p 
 WHERE p.codp = t.codp
   AND c.codc = t.codc
   AND m.codm = t.codm
GROUP BY m.preciohora
HAVING MAX(m.preciohora);

15. Obtener todos los datos de los proyectos que siempre han utilizado 
la máquina de precio más bajo.
SELECT p.codp, p.descripcion, p.localidad, p.cliente, p.telefono
  FROM trabajos t, maquinas m, proyectos p 
 WHERE p.codp = t.codp
   AND m.codm = t.codm
GROUP BY m.preciohora
HAVING MIN(m.preciohora);


16. Obtener los proyectos en los que haya trabajado el conductor de 
categoría más alta menos dos puntos, con la máquina de precio hora 
más bajo.

SELECT p.codp, p.descripcion, p.localidad, p.cliente, p.telefono
  FROM trabajos t, maquinas m, proyectos p, conductores c
 WHERE p.codp = t.codp
   AND c.codc = t.codc
   AND m.codm = t.codm
GROUP BY c.categoria
HAVING ((c.categoria = MAX(c.categoria)-2) AND MIN(m.preciohora));


17. Obtener por cada uno de los clientes el tiempo total empleado en 
sus proyectos.
SELECT DISTINCT p.cliente, 

		(SELECT SUM(t2.tiempo)
		   FROM trabajos t2
          WHERE t2.tiempo IS NOT NULL
		  GROUP BY t.codp
			HAVING SUM(t2.tiempo) = MAX(SUM(t2.tiempo))) AS suma_tiempo
                           
		   FROM proyectos p, trabajos t
		  WHERE p.codp = t.codp;


18. Obtener por cada uno de los proyectos existentes en la BD, la 
descripción del proyecto, el cliente y el total a facturar en ptas 
y en euros. Ordenar el resultado por uno de los totales y por cliente.

SELECT p.Descrip, p.Cliente, SUM(m.PrecioHora*t.Tiempo), SUM((m.PrecioHora*t.Tiempo)*166.386)
FROM Proyectos p, Trabajos t, Maquinas m
WHERE p.CodP = t.CodP
AND m.CodM = t.CodM
GROUP BY (p.CodP)
ORDER BY SUM(m.PrecioHora*t.Tiempo), p.Cliente DESC

1) Sacame todas esas cuentas
2) Cruzando las tablas que necesito
3) AGRUPO POR PROYECTO, puesto que el enunciado dice "Obtener por 
cada uno de los proyectos existentes"... recordad que el "por cada tal"
es un GROUP BY de libro, es fácil reconocerlo así
4) Finalmente ordeno por lo que me dicen que ordene, que podríamos 
haber usado un alias pero como soy un enfermo de la programación 
funcional sin variables paso.

SELECT p.Descrip, p.Cliente, m.PrecioHora AS Ph_Peseta, m.PrecioHora/166.386 AS Ph_Euro
FROM proyectos p, maquinas m, trabajos t
WHERE p.CodP = t.CodP
AND m.CodM = t.CodM
ORDER BY p.Cliente, m.PrecioHora;

19. Obtener para el proyecto que más se vaya a facturar la descripción 
del proyecto, el cliente y el total a facturar en Ptas. y en euros

SELECT p.descrip, p.cliente, SUM(m.preciohora * t.tiempo) total_euros, SUM(m.preciohora * t.tiempo * 166) total_ptas
  FROM proyectos p, maquinas m, trabajos t
 WHERE p.CodP = t.CodP
   AND m.CodM = t.CodM
 GROUP BY t.codP
HAVING SUM(m.preciohora * t.tiempo) =  (SELECT SUM(m2.preciohora * t2.tiempo)
										  FROM maquinas m2, trabajos t2
										 WHERE m2.CodM = t2.CodM
										 GROUP BY t2.CodP
										 ORDER BY SUM(m2.preciohora * t2.tiempo) DESC
										   LIMIT 1	)

20. Obtener los conductores que hayan trabajado en todos los proyectos 
de la localidad de Arganda.
SELECT DISTINCT c.nombres
  FROM conductores c, proyectos p, trabajos t 
 WHERE p.codp = t.codp
   AND c.codc = t.codc
   AND p.localidad = 'Arganda'

   
   SELECT DISTINCT p.Descripcion
FROM Proyectos p, Trabajos t, Conductores c
WHERE p.CodP = t.CodP
  AND c.CodC = t.CodC
  AND c.CodC = (SELECT c.CodC
                FROM Conductores c
				AND mm.CodM IN (  
    
				SELECT m.CodM
				FROM maquinas m,
				WHERE m.PrecioHora ORDER BY ASC
				LIMIT 1
    
				);
                WHERE categoria = (SELECT MAX(categoria) - 2
                FROM Conductores c)
                );

21. Obtener el tiempo máximo dedicado a cada proyecto para aquellos 
proyectos en los que haya participado más de un conductor diferente.

SELECT CodP, MAX(tiempo) AS T_Max
  FROM trabajos
 GROUP BY CodP
HAVING COUNT(DISTINCT CodC) > 1;


22. Obtener el número de partes de trabajo, código del proyecto, 
descripción y cliente para aquél proyecto que figure con más partes 
de trabajo.

SELECT p.CodP, p.descripcion, p.cliente, COUNT(*) As Número_Trabajos
  FROM proyectos p, trabajos t
 WHERE p.codP = t.codP
 GROUP BY p.CodP, p.descripcion, p.cliente
HAVING COUNT(*) >= (SELECT COUNT(*) 
					  FROM trabajos 
					 GROUP BY CodP);


23. Obtener la localidad cuyos conductores (al menos uno) haya 
participado en más de dos proyectos diferentes.

SELECT c.localidad
  FROM conductores c
 WHERE c.CodC IN (SELECT t.CodC
				    FROM trabajos t
				   GROUP BY t.CodC
				  HAVING COUNT(DISTINCT t.CodP) > 2);


24. Subir el precio por hora en un 10% del precio por hora más bajo 
para todas las máquinas excepto para aquella que tenga el valor más alto.

UPDATE maquinas
   SET preciohora = (SELECT MIN(preciohora)*1.1 
					   FROM maquinas);


25. Subir la categoría un 15% a los conductores que no hayan 
trabajado con Volquete y hayan trabajado en más de un proyecto distinto.
UPDATE conductores c
   SET c.categoria = c.categoria * 1.15
 WHERE c.CodC IN (SELECT c.Nombre, c.CodC
				 FROM conductores c, trabajos t, maquinas m
				 WHERE c.CodC = t.CodC
				   AND m.Nombre NOT LIKE 'Volquete'
 				 GROUP BY t.CodC
				 HAVING COUNT(t.codC) > 1) ;

			

26. Eliminar el proyecto Solado de José Pérez.
DELETE FROM proyectos p
WHERE p.Descripcion='Solado' AND p.Cliente='Jose Perez';

27. Modificar la estructura de la base de datos, añadiendo las claves 
foráneas, sin ninguna opción de integridad referencial.

ALTER TABLE trabajos
ADD FOREIGN KEY (codC) REFERENCES conductores (codC);

ALTER TABLE trabajos
ADD FOREIGN KEY (codM) REFERENCES maquinas (codM);

ALTER TABLE trabajos
ADD FOREIGN KEY (codP) REFERENCES proyectos (codP);


28. Insertar en la tabla trabajos la fila ‘C01’, ‘M04’,’P07’,’19/09/02’,100.
INSERT INTO trabajos VALUES ('C01', 'M04', 'P07', '2002-09-19', 100);

29. Eliminar el conductor ‘C01’ de la tabla conductores.
DELETE FROM conductores c
 WHERE c.CodC='C01';

30. Modificar el código del conductor ‘C01’ de la tabla conductores, por el código ‘C05’.
UPDATE conductores
   SET c.CodC = 'C05'
 WHERE c.CodC = 'C01';
  
 
 
 
 
 
 
 

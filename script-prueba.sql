/*INSERCION DE DATOS*/

/*INSERT ROLES*/
INSERT INTO rol(id,descripcion) VALUES (1,'Desarrollador');
INSERT INTO rol(id,descripcion)  VALUES (2,'Tester');
INSERT INTO rol(id,descripcion)  VALUES (3,'Administrador');
INSERT INTO rol(id,descripcion)  VALUES (4,'Devop');
INSERT INTO rol(id,descripcion)  VALUES (5,'Project Manager');


/*INSERT PARTICIPANTE*/
INSERT INTO participante (id, nombre, apellido, id_rol) VALUES (1, 'Leandro', 'Sanchez',1);
INSERT INTO participante (id, nombre, apellido, id_rol) VALUES (2, 'Sandra', 'Martinez',1);
INSERT INTO participante (id, nombre, apellido, id_rol) VALUES (3, 'José', 'Perez',2);
INSERT INTO participante (id, nombre, apellido, id_rol) VALUES (4, 'Jesica', 'Gonzalez',3);
INSERT INTO participante (id, nombre, apellido, id_rol) VALUES (5, 'María', 'Cosi',3);
INSERT INTO participante (id, nombre, apellido, id_rol) VALUES (6, 'María', 'Matienzo',4);
INSERT INTO participante (id, nombre, apellido, id_rol) VALUES (7, 'Sofia', 'Caras',5);


/*INSERT PROYECTO*/
INSERT INTO proyecto (nombre, costo_proyecto, costo_hora, pack_horas) VALUES ('La Libreria', 25000, 125, 200 );
INSERT INTO proyecto (nombre, costo_proyecto, costo_hora, pack_horas) VALUES ('Consorcio San Martin 432', 55000, 220, 250 );
INSERT INTO proyecto (nombre, costo_proyecto, costo_hora, pack_horas) VALUES ('Hotel Las Brisas', 150000, 428.57, 350 );


/*INSERT HORAS ASIGNADAS*/
/*proyecto 1*/
INSERT INTO horas_asignadas(id_proyecto,id_participante, horas_asignadas_proyecto)
VALUES
(1,1,60.00);
INSERT INTO horas_asignadas(id_proyecto,id_participante, horas_asignadas_proyecto)
VALUES
(1,2,60.00);
INSERT INTO horas_asignadas(id_proyecto,id_participante, horas_asignadas_proyecto)
VALUES
(1,3,30.00);
INSERT INTO horas_asignadas(id_proyecto,id_participante, horas_asignadas_proyecto)
VALUES
(1,4,40.00);
INSERT INTO horas_asignadas(id_proyecto,id_participante, horas_asignadas_proyecto)
VALUES
(1,7,10.00);
SELECT * FROM horas_asignadas;

/*prueba carga diaria*/
call RendicionHorasDia
('2021-09-13', 8.00, 1,1);
call RendicionHorasDia
('2021-09-14', 8.00, 1,1);
call RendicionHorasDia
('2021-09-15', 8.00, 1,1);

/*prueba carga semanal*/
call RendicionHorasSemana
('2021-09-13','2021-09-17',40.00,1,2);

/*prueba carga mensual*/
call RendicionHorasMes
('2021-08-03', '2021-08-31',35.00,1,3);

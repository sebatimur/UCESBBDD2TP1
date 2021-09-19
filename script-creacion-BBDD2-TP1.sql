CREATE DATABASE BBDD2;

USE  BBDD2;

CREATE TABLE participante(
id int auto_increment,
nombre varchar (50) not null,
apellido varchar (50) not null,
id_rol int,
constraint primary key(id)
);

CREATE TABLE rol(
id int,
descripcion varchar(150) not null,
constraint primary key (id)
);

CREATE TABLE proyecto(
id int auto_increment,
nombre varchar(50) not null,
costo_proyecto decimal(10,2),
costo_hora decimal(6,2),
pack_horas decimal (12,2) not null; /*Modificado*/
constraint primary key(id)
);

CREATE TABLE horas_asignadas(
id_horas_asignadas int auto_increment,
id_proyecto int,
id_participante int,
horas_asignadas_proyecto decimal not null,
constraint primary key(id_horas_asignadas)
);

CREATE TABLE carga_diaria(
id_diario int auto_increment,
dia date,
hora decimal(5,2),
id_proyecto int,
id_participante int,
constraint primary key (id_diario)
);

CREATE TABLE carga_semanal(
id_semanal int auto_increment,
s_inicial date,
s_final date,
hora decimal(5,2),
id_proyecto int,
id_participante int,
constraint primary key (id_semanal)
);

CREATE TABLE carga_mensual(
id_mensual int auto_increment,
m_inicial date,
m_final date,
hora decimal(5,2),
id_proyecto int,
id_participante int,
constraint primary key(id_mensual)
);

CREATE TABLE cliente(
id int auto_increment,
id_proyecto int,
constraint primary key(id)
);

CREATE TABLE facturacion(
id int auto_increment,
id_cliente int not null,
monto_factura decimal(10,2),
constraint primary key(id)
);


ALTER TABLE participante ADD foreign key (id_rol) references rol(id);

alter table horas_asignadas add constraint foreign key (id_participante) references participante(id);
alter table horas_asignadas add constraint foreign key (id_proyecto) references proyecto(id);

alter table cliente add constraint foreign key (id_proyecto) references proyecto(id);
alter table facturacion add constraint foreign key (id_cliente) references cliente(id);

alter table carga_diaria add constraint foreign key (id_proyecto) references proyecto(id);
alter table carga_diaria add constraint foreign key (id_participante) references participante(id);


alter table carga_semanal add constraint foreign key (id_proyecto) references proyecto(id);
alter table carga_semanal add constraint foreign key (id_participante) references participante(id);

alter table carga_mensual add constraint foreign key (id_proyecto) references proyecto(id);
alter table carga_mensual add constraint foreign key (id_participante) references participante(id);








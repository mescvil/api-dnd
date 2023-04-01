drop schema if exists dnd;

create schema dnd;
use dnd;

drop table if exists usuarios;
drop table if exists personajes;
drop table if exists razas;
drop table if exists rasgos;
drop table if exists trasfondos;
drop table if exists idiomas;
drop table if exists competencias;
drop table if exists clases;
drop table if exists armaduras;
drop table if exists armas;
drop table if exists hechizos;
drop table if exists rasgos_de_clases;
drop table if exists especialidad;
drop table if exists rasgos_razas;
drop table if exists trasfondos_idiomas;
drop table if exists trasfondos_competencias;
drop table if exists clases_competencias;
drop table if exists clases_rasgos_de_clases;
drop table if exists clases_armaduras;
drop table if exists clases_armas;
drop table if exists clases_hechizos;

create table usuarios (
	correo varchar (200),
	contrasenia varchar (100),
    nombre varchar (100),

	constraint pk_usuarios primary key (correo)
);

create table personajes (
	id bigint,
    correo_usuario varchar (200),
    imagen varchar (100),
    nombre varchar (100),
    edad tinyint,
	alineamiento enum (
    'Legal bueno','Neutral bueno','Caótico bueno',
	'Legal neutral','Neutral puro','Caótico neutral',
	'Legal malo','Neutral malo','Caótico malo'
    ),
    tamanio float,
    fuerza tinyint,
    destreza tinyint,
    constitucion tinyint,
    inteligencia tinyint,
    sabidurida tinyint,
	carisma tinyint,
    clase_armadura tinyint,
    
    constraint pk_personajes primary key (id,correo_usuario),
    constraint fk_correo_usuario_personaje foreign key (correo_usuario) references usuarios(correo)
);

create table razas (
	nombre varchar (100),
    id_personaje bigint,
    correo_usuario_personaje varchar (200),
    edad_minima tinyint,
    edad_maxima tinyint,
    tamanio_minimo float,
    tamanio_maximo float,
    velocidad tinyint,
    
    constraint pk_razas primary key (nombre),
    constraint fk_razas_id_personaje foreign key (id_personaje) references personajes(id),
    constraint fk_razas_correo_usuario_personaje foreign key (correo_usuario_personaje) references personajes(correo_usuario)
);

create table trasfondos (
	nombre varchar (100),
    id_personaje bigint,
    correo_usuario_personaje varchar (200),
    descripcion varchar (300),
    
    constraint pk_trasfondos primary key (nombre),
    constraint fk_trasfondos_id_personaje foreign key (id_personaje) references personajes(id),
    constraint fk_trasfondos_correo_usuario_personaje foreign key (correo_usuario_personaje) references personajes(correo_usuario)
);

create table clases (
	nombre varchar (100),
    id_personaje bigint,
    correo_usuario_personaje varchar (200),
    dados_de_golpe varchar (10),
    caracteristica_principal varchar (50),
    tiradas_de_salvacion varchar (50),
    descripcion varchar (300),
    
    constraint pk_clases primary key (nombre),
    constraint fk_clases_id_personaje foreign key (id_personaje) references personajes(id),
    constraint fk_clases_correo_usuario_personaje foreign key (correo_usuario_personaje) references personajes(correo_usuario)
);

create table rasgos (
	nombre varchar (100),
    descripcion varchar (300),
    
    constraint pk_rasgos primary key (nombre)
);

create table idiomas (
	nombre varchar (100),
    
    constraint pk_idiomas primary key (nombre)
);

create table competencias (
	nombre varchar (100),
    descripcion varchar (300),
    
    constraint pk_competencias primary key (nombre)
);

create table armaduras (
	nombre varchar (100),
    peso tinyint,
    clase_de_armadura tinyint,
    precio float,
    fuerza_requerida tinyint,
    desventaja_sigilo boolean,
    
    constraint pk_armaduras primary key (nombre)
);

create table armas (
	nombre varchar (100),
    danio varchar (50),
    dos_manos boolean,
    arrojadiza boolean,
    propiedad varchar (100),
    
    constraint pk_armas primary key (nombre)
);

create table hechizos (
	nombre varchar (100),
    nivel tinyint,
    tiempo_de_lanzamiento tinyint,
    alcance tinyint,
    duracion tinyint,
    tirada_de_salvacion varchar (30),
    descripcion varchar (100),
    
    constraint pk_hechizos primary key (nombre)
);

create table rasgos_de_clases (
	nombre varchar (100),
    descripcion varchar (300),
    
     constraint pk_rasgos_de_clases primary key (nombre)
);

create table especialidad (
	nombre varchar (100),
    nombre_clase varchar (100),
    descripcion varchar (300),
    
    constraint pk_especialidad primary key (nombre,nombre_clase),
    constraint fk_especialidad_nombre_clase foreign key (nombre_clase) references clases(nombre)
);

/*RELACIONES*/

create table rasgos_razas (
	nombre_raza varchar (100),
    nombre_rasgo varchar (100),
    
    constraint pk_rasgos_razas primary key (nombre_raza,nombre_rasgo),
    constraint fk_nombre_raza_RR foreign key (nombre_raza) references razas(nombre),
    constraint fk_nombre_rasgo_RR foreign key (nombre_rasgo) references rasgos(nombre)
);

create table trasfondos_idiomas (
	nombre_trasfondo varchar (100),
    nombre_idioma varchar (100),
    
    constraint pk_trasfondos_idiomas primary key (nombre_trasfondo,nombre_idioma),
    constraint fk_nombre_trasfondo_TI foreign key (nombre_trasfondo) references trasfondos(nombre),
    constraint fk_nombre_idioma_TI foreign key (nombre_idioma) references idiomas(nombre)
);

create table trasfondos_competencias (
	nombre_trasfondo varchar (100),
    nombre_competencia varchar (100),
    
    constraint pk_trasfondos_competencias primary key (nombre_trasfondo,nombre_competencia),
    constraint fk_nombre_trasfondo_TC foreign key (nombre_trasfondo) references trasfondos(nombre),
    constraint fk_nombre_competencia_TC foreign key (nombre_competencia) references competencias(nombre)
);

create table clases_competencias(
	nombre_clase varchar (100),
    nombre_competencia varchar (100),
    
    constraint pk_clases_competencias primary key (nombre_clase,nombre_competencia),
    constraint fk_nombre_clase_CC foreign key (nombre_clase) references clases(nombre),
    constraint fk_nombre_competencia_CC foreign key (nombre_competencia) references competencias(nombre)
);

create table clases_rasgos_de_clases(
	nombre_clase varchar (100),
    nombre_rasgo_de_clase varchar (100),
    
    constraint ok_clases_rasgos_de_clases primary key (nombre_clase,nombre_rasgo_de_clase),
    constraint fk_nombre_clase_CRC foreign key (nombre_clase) references clases(nombre),
    constraint fk_nombre_rasgo_de_clase_CRC foreign key (nombre_rasgo_de_clase) references rasgos_de_clases(nombre)
);

create table clases_armaduras(
	nombre_clase varchar (100),
    nombre_armadura varchar (100),
    
    constraint ok_clases_armaduras primary key (nombre_clase,nombre_armadura),
    constraint fk_nombre_clase_CA foreign key (nombre_clase) references clases(nombre),
    constraint fk_nombre_armadura_CA foreign key (nombre_armadura) references armaduras(nombre)
);

create table clases_armas(
	nombre_clase varchar (100),
    nombre_arma varchar (100),
    
    constraint ok_clases_armas primary key (nombre_clase,nombre_arma),
    constraint fk_nombre_clase_CAr foreign key (nombre_clase) references clases(nombre),
    constraint fk_nombre_arma_CAr foreign key (nombre_arma) references armas(nombre)
);

create table clases_hechizos(
	nombre_clase varchar (100),
    nombre_hechizo varchar (100),
    
    constraint ok_clases_hechizos primary key (nombre_clase,nombre_hechizo),
    constraint fk_nombre_clase_CH foreign key (nombre_clase) references clases(nombre),
    constraint fk_nombre_hechizo_CH foreign key (nombre_hechizo) references hechizos(nombre)
);

/*DATOS*/


DROP table categorias;
DROP table peliculas;
DROP TABLE actores;
DROP TABLE pelicula_actor;
Drop table peliculas;


create table peliculas(
    cod_pelicula int primary key,
    titulo varchar,
    descripcion varchar,
    estreno varchar,
    duracion int,
    diasRenta int,
    costoRenta float,
    costoDaño float,
    clasificacion varchar
);


create table categorias(
    categoria varchar,
    pelicula int,
    foreign key (pelicula) references peliculas (cod_pelicula)
);

create table actores(
    cod_actor int primary key,
    nombre varchar,
    apellido varchar
);

create table pelicula_actor(
    cod_actor int,
    cod_pelicula int,
    foreign key (cod_actor) references actores (cod_actor),
    foreign key (cod_pelicula) references peliculas (cod_pelicula)
);

create table idiomas(
    idioma varchar,
    pelicula int,
    foreign key (pelicula) references peliculas(cod_pelicula)
);

create table tiendas(
    cod_tienda int PRIMARY KEY,
    direccion varchar,
    jefeTienda int
);

create table empleados(
    cod_empleado int PRIMARY KEY,
    nombre varchar, 
    apellido varchar,
    direccion varchar,
    email varchar,
    estado varchar,
    usuario varchar,
    psswrd varchar,
    tienda int,
    foreign key (tienda) references tiendas(cod_tienda) 
);
Alter table tiendas add foreign key (jefeTienda) references empleados(cod_empleado);

ALTER TABLE tiendas DROP FOREIGN KEY jefeTienda;

create table inventario(
    tienda int,
    pelicula int,
    cantidad int,
    foreign key (tienda) references tiendas(cod_tienda),
    foreign key (pelicula) references peliculas(cod_pelicula)
);

create table clientes(
    cod_cliente int primary key,
    nombre varchar,
    apellido varchar,
    email varchar,
    fechaRegistro date,
    direccion varchar,
    estado varchar,
    tiendaFav int,
    distrito varchar, 
    codPostal varchar,
    ciudad varchar,
    pais varchar,
    foreign key (tiendaFav) references tiendas (cod_tienda)
);

create table renta (
    cod_renta int primary key,
    cantidadPago float,
    fechaPago date,
    empleado int,
    fechaRenta date,
    fechaRegreso date,
    foreign key (empleado) references empleados(cod_empleado)
);

create table pelicula_tienda (
    renta int,
    pelicula int,
    foreign key (renta) references renta(cod_renta),
    foreign key (pelicula) references peliculas(cod_pelicula)
);

select * from pelicula_actor;


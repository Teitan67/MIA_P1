drop table categorias;
drop table idiomas;
drop table renta;
drop table clientes;
drop table actores;
ALTER TABLE tiendas DROP COLUMN jefeTienda;
drop table empleados;
drop table tiendas;
drop table peliculas;




create table peliculas(
    cod_pelicula serial primary key,
    titulo varchar,
    descripcion varchar,
    estreno varchar,
    duracion int,
    diasRenta int,
    costoRenta float,
    costoDaño float,
    clasificacion varchar,
    categoria varchar
);

--Alter table peliculas add column categoria varchar;

create table tiendas(
    cod_tienda serial PRIMARY KEY,
    nombre varchar,
    direccion varchar,
    codigoPostal varchar,
    ciudad varchar,
    pais varchar,
    jefeTienda int
);

create table empleados(
    cod_empleado serial PRIMARY KEY,
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


/*
create table pelicula_tienda (
    renta int,
    pelicula int,
    foreign key (renta) references renta(cod_renta),
    foreign key (pelicula) references peliculas(cod_pelicula)
);

create table inventario(
    tienda int,
    pelicula int,
    cantidad int,
    foreign key (tienda) references tiendas(cod_tienda),
    foreign key (pelicula) references peliculas(cod_pelicula)
);*/

create table clientes(
    cod_cliente serial primary key,
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

create table idiomas(
    idioma varchar,
    pelicula int,
    foreign key (pelicula) references peliculas(cod_pelicula)
);

create table categorias(
    categoria varchar,
    pelicula int,
    foreign key (pelicula) references peliculas (cod_pelicula)
);


create table actores(
    pelicula int,
    nombre varchar,
    foreign key (pelicula) references peliculas (cod_pelicula)
);
create table renta (
    cliente int,
    pelicula int,
    empleado int,
    tienda int,
    fechaRenta timestamp,
    fechaRetorno timestamp,
    montoPago float,
    fechaPago timestamp,
    foreign key (cliente) references clientes(cod_cliente),
    foreign key (pelicula) references peliculas(cod_pelicula) ,
    foreign key (empleado) references empleados(cod_empleado) ,
    foreign key (tienda) references tiendas(cod_tienda) 
);
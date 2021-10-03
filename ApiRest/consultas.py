#Mostrar consulta 1 /consulta1
consulta1 = """
select 
    count(renta.pelicula) as Cantidad_sugarWonka
from 
    renta,
    peliculas
WHERE
    renta.pelicula = peliculas.cod_pelicula and 
    lower(peliculas.titulo) = 'sugar wonka'
"""
#Mostrar consulta 2 /consulta2
consulta2 = """
Select 
    clientes.nombre, 
    Sum(renta.montopago)as totalPago,
    count(clientes.nombre) As Cantidad
from 
    renta, 
    clientes 
where 
    clientes.cod_cliente=renta.cliente 
group by  
    clientes.nombre 
HAVING
	count(clientes.nombre) >= 40 
"""
#Mostrar consulta 3 /consulta3
consulta3 = """
select 
    actores.nombre as Nombre_Actores
from 
    actores 
where 
    lower(split_part(actores.nombre, ' ', 2)) like '%son%'
group by 
    actores.nombre 
order by
    actores.nombre
"""
#Mostrar consulta 4 /consulta4
consulta4="""
select 
    split_part(actores.nombre, ' ', 1) as nombre,
    split_part(actores.nombre, ' ', 2) as apellido,
    peliculas.estreno
from 
    actores,
    peliculas
where 
    actores.pelicula=peliculas.cod_pelicula and 
    lower(peliculas.descripcion) like '%crocodile%' and 
    lower(peliculas.descripcion) like '%shark%'

group by 
    actores.nombre,
    peliculas.estreno
order by
    split_part(actores.nombre, ' ', 2) asc
"""
#Mostrar consulta 5 /consulta5
consulta5 = """
select 
    c.pais,
    (
        select 
            c3.nombre
        from  
            clientes c3,
            renta r3 
        where 
            r3.cliente = c3.cod_cliente and 
            c3.pais = c.pais
        group by
            c3.pais,
            c3.nombre
        order by 
            Count(r3.cliente) desc 
        limit 1
    ) as nombre_,
    (
        select 
            Count(r1.cliente) rentas1
        from  
            clientes c1,
            renta r1 
        where 
            r1.cliente = c1.cod_cliente and 
            c1.pais = c.pais
        group by
            c1.pais,
            c1.nombre
        order by 
            rentas1 desc 
        limit 1
    )*100
    /
    (
        select 
            Count(r2.cliente) rentas2
        from  
            clientes c2,
            renta r2 
        where 
            r2.cliente = c2.cod_cliente and 
            c2.pais = c.pais
        order by 
        rentas2 desc 
        limit 1
    ) as porcentaje
from  
    clientes c,
    renta r 
where 
    r.cliente = c.cod_cliente 

group by
    c.pais,
    nombre_,
    porcentaje
"""
#Mostrar consulta 6 /consulta6
consulta6 ="""
select  
    CAST(Count(clientes.nombre) as float) * 100
    /
    (
        select  
            Count(c.nombre)
        from 
            clientes c
        where
            c.pais = clientes.pais 
        group by 
            c.pais
    ) As Porcentaje,
    clientes.ciudad,
    clientes.pais
from 
    clientes
group by 
    clientes.pais,
    clientes.ciudad
order by 
    clientes.pais 

"""
#Mostrar consulta 7 /consulta7
consulta7 ="""

select 
    c1.pais,
    c1.ciudad,
    Cast(
    (
        select 
            Count(r.cliente)
        from 
            renta r,
            clientes c
        where
            r.cliente =c.cod_cliente and 
            c.ciudad = c1.ciudad
        
    ) as float)/
    (
       select 
            count(distinct c.ciudad)
        from 
            renta r,
            clientes c
        where
            r.cliente =c.cod_cliente and 
            c.pais = c1.pais
    )as Promedio
from
    clientes c1
group by 
    c1.pais,c1.ciudad
order by
    c1.pais
"""
#Mostrar consulta 8 /consulta8
consulta8="""
select 
    c.pais,
    Count(renta.cliente)
    /
    CAST((
        select 
            Count(renta.cliente) as total_renta
        from
            clientes,
            renta,
            peliculas
        where
            renta.pelicula = peliculas.cod_pelicula and 
            renta.cliente = clientes.cod_cliente AND 
            clientes.pais = c.pais
        group by
            clientes.pais
        order by
            clientes.pais
    ) AS FLOAT)* 100
     as Porcentaje_de_“Sports”
from
    clientes c,
    renta,
    peliculas
where
    renta.pelicula = peliculas.cod_pelicula and 
    renta.cliente = c.cod_cliente and
    lower(peliculas.categoria) = 'sports'
group by
    c.pais
order by
    c.pais

"""
#Mostrar consulta 9 /consulta9
consulta9="""
SELECT
    c.ciudad,
    count(renta.cliente) as no_rentas
FROM
    clientes c,
    renta
WHERE
    c.pais = 'United States' and 
    renta.cliente = c.cod_cliente and 
    (
        SELECT
            count(renta.cliente)
        FROM
            clientes,
            renta
        WHERE
            clientes.pais = 'United States' and 
            renta.cliente = clientes.cod_cliente and 
            lower(clientes.ciudad) = 'dayton'
        GROUP by 
            clientes.ciudad
        ORDER BY 
            clientes.ciudad
    ) < (
        SELECT
            count(renta.cliente)
        FROM
            clientes,
            renta
        WHERE
            clientes.pais = 'United States' and 
            renta.cliente = clientes.cod_cliente and 
            clientes.ciudad = c.ciudad
        GROUP by 
            clientes.ciudad
        ORDER BY 
            clientes.ciudad
    )
GROUP by 
    c.ciudad
ORDER BY 
    c.ciudad
"""
#Mostrar consulta 10 /consulta10
consulta10="""

select
    clientes.pais,
    clientes.ciudad
from
    clientes 
where 
    (
        select 
            Count(r.cliente) as no_rentas
        FROM
            clientes c,
            renta r,
            peliculas p
        WHERE
            c.cod_cliente = r.cliente and 
            p.cod_pelicula = r.pelicula and
            c.ciudad = clientes.ciudad and
            lower(p.categoria) = 'horror'
        GROUP by
            p.categoria
        order by
            no_rentas desc
        limit 1
    )
    >=
    (
        select 
            Count(r.cliente) as no_rentas
        FROM
            clientes c,
            renta r,
            peliculas p
        WHERE
            c.cod_cliente = r.cliente and 
            p.cod_pelicula = r.pelicula and
            c.ciudad = clientes.ciudad and
            lower(p.categoria) <> 'horror'
        GROUP by
            p.categoria
        order by
            no_rentas desc
        limit 1
    )
order by 
    clientes.pais
;

"""
#Eliminar datos de la tabla temporal /eliminarTemporal
eliminarTemporal = """
DROP TABLE TEMPORAL;
create table TEMPORAL(
    NOMBRE_CLIENTE VARCHAR,
    CORREO_CLIENTE VARCHAR,
    CLIENTE_ACTIVO VARCHAR,
    FECHA_CREACION VARCHAR,
    TIENDA_PREFERIDA VARCHAR,
    DIRECCION_CLIENTE VARCHAR,
    CODIGO_POSTAL_CLIENTE VARCHAR,
    CIUDAD_CLIENTE VARCHAR,
    PAIS_CLIENTE VARCHAR,
    FECHA_RENTA VARCHAR,
    FECHA_RETORNO VARCHAR,
    MONTO_A_PAGAR VARCHAR,
    FECHA_PAGO VARCHAR,
    NOMBRE_EMPLEADO VARCHAR,
    CORREO_EMPLEADO VARCHAR,
    EMPLEADO_ACTIVO VARCHAR,
    TIENDA_EMPLEADO VARCHAR,
    USUARIO_EMPLEADO VARCHAR,
    PASSWORD_EMPLEADO VARCHAR,
    DIRECCION_EMPLEADO VARCHAR,
    CODIGO_POSTAL_EMPLEADO VARCHAR,
    CIUDAD_EMPLEADO VARCHAR,
    PAIS_EMPLEADO VARCHAR,
    NOMBRE_TIENDA VARCHAR,
    ENCARGADO_TIENDA VARCHAR,
    DIRECCION_TIENDA VARCHAR,           --DIRECCION TIENDA
    CODIGO_POSTAL_TIENDA VARCHAR,       --CODIGO POSTAL
    CIUDAD_TIENDA VARCHAR,              --CIUDAD
    PAIS_TIENDA VARCHAR,                --PAIS
    TIENDA_PELICULA VARCHAR,
    NOMBRE_PELICULA VARCHAR,
    DESCRIPCION_PELICULA VARCHAR,
    LANZAMIENTO VARCHAR,
    DIAS_RENTA VARCHAR,
    COSTO_RENTA VARCHAR,
    DURACION VARCHAR,
    COSTO_POR_DANO VARCHAR,
    CLASIFICACION VARCHAR,
    LENGUAJE_PELICULA VARCHAR,
    CATEGORIA_PELICUL VARCHAR,  
    ACTOR_PELICULA VARCHAR              --CARGADO
);
"""
#Elimina las tablas del modelo de datos /eliminarModelo
elimnarModelo = """
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


"""

#Carga masiva de datos a tabla temporal /cargarTemporal

cargarTemporal = """
copy TEMPORAL FROM '/home/teitan67/MIA_P1/BlockbusterData.csv' DELIMITER ';' CSV HEADER ENCODING 'WIN1252';
"""
#Crear tablas del modelo y cargarle los datos /cargarModelo


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

copy TEMPORAL FROM '/home/teitan67/MIA_P1/BlockbusterData.csv' DELIMITER ';' CSV
copy TEMPORAL FROM '/home/teitan67/MIA_P1/BlockbusterData.csv' DELIMITER ';' CSV HEADER ENCODING 'WIN1252';

select * from temporal limit 10;

delete from temporal ;
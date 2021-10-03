--INSERTANDO EN ACTORES
insert into actores(nombre) select distinct ACTOR_PELICULA FROM temporal where ACTOR_PELICULA <> '-';
--INSERTANDO EN PELICULAS
insert into 
    peliculas(
        titulo,
        descripcion,
        estreno,
        duracion,
        diasrenta,
        costorenta,
        costodaño,
        clasificacion,
        categoria) 
    select distinct 
        NOMBRE_PELICULA,
        descripcion_pelicula,
        LANZAMIENTO,
        CAST(DURACION AS int),
        CAST(DIAS_RENTA AS int),
        CAST(COSTO_RENTA AS float),
        CAST(COSTO_POR_DANO  AS float),
        CLASIFICACION ,
        CATEGORIA_PELICUL
    FROM temporal 
    where LANZAMIENTO <> '-';
--tiendas
insert into 
    tiendas
    (
        nombre,
        direccion,
        codigoPostal,
        ciudad,
        pais
    ) 
select  
    nombre_tienda,
    DIRECCION_TIENDA,
    codigo_postal_tienda,
    ciudad_tienda,
    pais_tienda 
FROM temporal 
WHERE nombre_tienda <> '-'
group by nombre_tienda, codigo_postal_tienda,DIRECCION_TIENDA,ciudad_tienda,pais_tienda
;
--Empleados

insert into 
    empleados
    (
        nombre,
        direccion,
        email,
        estado,
        usuario,
        psswrd,
        tienda
    ) 
select  
    temporal.nombre_empleado,
    temporal.direccion_empleado,
    temporal.correo_empleado,
    temporal.empleado_activo,
    temporal.usuario_empleado,
    temporal.password_empleado, 
    tiendas.cod_tienda
    from temporal, tiendas
    where nombre_empleado <> '-' and temporal.nombre_tienda=tiendas.nombre
    group by 
    temporal.nombre_empleado,
    temporal.direccion_empleado,
    temporal.correo_empleado,
    temporal.empleado_activo,
    temporal.usuario_empleado,
    temporal.password_empleado,
    tiendas.cod_tienda 
;
--clientes

insert into 
    clientes(
        nombre,
        email,
        fecharegistro,
        direccion,
        estado,
        codpostal,
        ciudad,
        pais,
        tiendafav
    )
SELECT 
    temporal.NOMBRE_CLIENTE,
    temporal.correo_cliente,
    CAST(temporal.FECHA_CREACION AS DATE),
    temporal.direccion_cliente,
    temporal.cliente_activo,
    temporal.codigo_postal_cliente,
    temporal.ciudad_cliente,
    temporal.pais_cliente,
    tiendas.cod_tienda 
    from temporal, tiendas
    WHERE temporal.TIENDA_PREFERIDA = tiendas.nombre
    group by 
    temporal.NOMBRE_CLIENTE,
    temporal.correo_cliente,
    temporal.FECHA_CREACION,
    temporal.direccion_cliente,
    temporal.cliente_activo,
    temporal.codigo_postal_cliente,
    temporal.ciudad_cliente,
    temporal.pais_cliente,
    tiendas.cod_tienda   
;

--Relacion empleado y tiendas


  update tiendas
  set jefetienda=empleados.cod_empleado
  FROM empleados
  WHERE tiendas.cod_tienda = empleados.tienda;


--Idiomas

insert into 
    idiomas(
        idioma,
        pelicula
    )
select 
    temporal.LENGUAJE_PELICULA,
    peliculas.cod_pelicula
    from
    temporal,peliculas
    WHERE temporal.NOMBRE_PELICULA = peliculas.titulo
    GROUP by
    temporal.LENGUAJE_PELICULA,
    peliculas.cod_pelicula;

--Categorias
insert into 
    categorias(
        categoria,
        pelicula
    )
select 
    temporal.CATEGORIA_PELICUL,
    peliculas.cod_pelicula
    from
    temporal,peliculas
    WHERE temporal.NOMBRE_PELICULA = peliculas.titulo
    GROUP by
    temporal.CATEGORIA_PELICUL,
    peliculas.cod_pelicula

;
--ACTOR
insert into 
    actores(
        nombre,
        pelicula
    )
select 
    temporal.ACTOR_PELICULA,
    peliculas.cod_pelicula
    from
    temporal,peliculas
    WHERE temporal.NOMBRE_PELICULA = peliculas.titulo and temporal.actor_pelicula <> '-'
    GROUP by
    temporal.ACTOR_PELICULA,
    peliculas.cod_pelicula
;
 --Rentas 
insert into 
    renta(
        cliente,
        pelicula,
        empleado,
        tienda,
        fechaRenta,
        fechaRetorno,
        montoPago,
        fechapago
    )
SELECT 
    clientes.cod_cliente,
    peliculas.cod_pelicula,
    empleados.cod_empleado,
    tiendas.cod_tienda,
    CAST(temporal.fecha_renta AS timestamp),
    CAST(temporal.fecha_retorno AS timestamp),
    CAST(temporal.monto_a_pagar AS FLOAT),
    CAST(temporal.fecha_pago AS timestamp)
    FROM
    temporal,clientes,peliculas,empleados,tiendas
    where 
    temporal.nombre_pelicula=peliculas.titulo AND
    temporal.nombre_cliente=clientes.nombre AND
    temporal.nombre_empleado=empleados.nombre AND
    temporal.nombre_tienda=tiendas.nombre AND
    temporal.fecha_retorno <> '-'
    GROUP by
    clientes.cod_cliente,
    peliculas.cod_pelicula,
    empleados.cod_empleado,
    tiendas.cod_tienda,
    temporal.fecha_renta,
    temporal.fecha_retorno,
    temporal.monto_a_pagar,
    temporal.fecha_pago
;


/*
1. Mostrar la cantidad de copias que existen en el inventario para la película
“Sugar Wonka”
*/

select 
    count(renta.pelicula) as Cantidad_sugarWonka
from 
    renta,
    peliculas
WHERE
    renta.pelicula = peliculas.cod_pelicula and 
    lower(peliculas.titulo) = 'sugar wonka'
/*
 2) Mostrar el nombre, apellido y pago total de todos los clientes que han
 rentado películas por lo menos 40 veces
*/

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
;
/*
    3) Mostrar el nombre y apellido (en una sola columna) de los actores que
    contienen la palabra “SON” en su apellido, ordenados por su primer
    nombre.
*/
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
;
/*
    4. Mostrar el nombre y apellido de los actores que participaron en una
    película cuya descripción incluye la palabra “crocodile” y “shark” junto
    con el año de lanzamiento de la película, ordenados por el apellido del
    actor en forma ascendente.
*/

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
;

/*
    5 Mostrar el país y el nombre del cliente que más películas rentó así como
    también el porcentaje que representa la cantidad de películas que rentó
    conrespecto al resto de clientes del país.
*/
--Maximo del pais 
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
;

/*
    6. Mostrar el total de clientes y porcentaje de clientes por ciudad y país. El
    ciento por ciento es el total de clientes por país. (Tip: Todos los
    porcentajes por ciudad de un país deben sumar el 100%).

*/
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

/*
7. Mostrar el nombre del país, la ciudad y el promedio de rentas por ciudad.
Por ejemplo: si el país tiene 3 ciudades, se deben sumar todas las rentas de
la ciudad y dividirlo dentro de tres (número de ciudades del país).
*/


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
--opcional
limit 10


/*
8. Mostrar el nombre del país y el porcentaje de rentas de películas de la
categoría “Sports”. El porcentaje es sobre el número total de rentas de
cada país
*/
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


/*
9. Mostrar la lista de ciudades de Estados Unidos y el número de rentas de
películas para las ciudades que obtuvieron más rentas que la ciudad
“Dayton”.
*/ 
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


        


/*
10.Mostrar todas las ciudades por país en las que predomina la renta de
películas de la categoría “Horror”. Es decir, hay más rentas que las otras
categorías.
*/

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



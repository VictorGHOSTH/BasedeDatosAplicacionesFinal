--crear base de datos para demostrar el uso del left join 

create DATABASE pruebajoins;

--utilizamos la base de datos

use pruebajoins;

--crear la tabla categorias 
create table categotias(
    categoriaid int not null IDENTITY (1,1),
    nombre varchar (50) not null default 'no categoria',
    CONSTRAINT pk_categoria
    PRIMARY key (categoriaid)
);

--crear la tabla producto
create table producto(
    productoid int not null IDENTITY (1,1),
    nombre VARCHAR(50) not null,
    existencia int not null,
    precio money not null,
    categoriaid int,
    constraint pk_producto
    PRIMARY key (productoid),
    CONSTRAINT unico_nombre
    unique (nombre),
    CONSTRAINT fk_producto_categoria
    FOREIGN key (categoriaid)
    references categotias(categoriaid)
);

--agregar registros a la tabla categoria
insert into categotias(nombre)
values ('LB'),
       ('Lacteos'),
       ('Ropa'),
       ('Bebidas'),
       ('Carnes frias');


--Agregar registros a la tabla producto
select * from categotias;

insert into producto(nombre, existencia, precio, categoriaid)
values ('Refrigerador', 3, 10000.0, 1),
       ('Estufa', 2, 10.5, 2),
       ('Yougurt', 3, 13.45, 2);

 --comando para reiniciar los idetity 
 DBCC checkident (tblname, RESEED, 0
       
select * 
from producto as p 
inner join categotias as c 
on p.categoriaid = c.categoriaid ;

--consulta utilizando un left join 
--seleccionar todas las categorias que no tienen asignados productos
select * 
from categotias as c 
inner join producto as p 
on p.categoriaid = c.categoriaid;

select *
from categotias as c 
LEFT join producto as p 
on p.categoriaid = c.categoriaid;

select *
from categotias as c 
RIGHT join producto as p 
on p.categoriaid = c.categoriaid;

select c.categoriaid, c.nombre
from categotias as c 
left join producto as p 
on p.categoriaid = c.categoriaid
where p.productoid is null;

--full join 
select * 
from categotias as c 
full join producto as p 
on p.categoriaid = c.categoriaid;

--Ejercicio 
--1.-crear una base de datos llamada ejercicio join 
create database ejerciciojoins;
use ejerciciojoins;

--2.-crear unna tabla llamada empleados tomando como base la tabla employees de nortwhind (no tomar todos los datos)
select * from northwind .dbo.employees;

select top 0 employeeid as 'empleadoid',
       CONCAT(firstname,' ',lastname) as 'nombrecompleto',
       title as 'titulo',
       hiredate as 'fechacontratacion'
into ejerciciojoins.dbo.empleados
from northwind.dbo.employees;

select * from ejerciciojoins.dbo.empleados;

--3.-llenar la tabla con una consulta a la tabla employees 
insert into ejerciciojoins.dbo.empleados(nombrecompleto,titulo,fechacontratacion)
select 
      CONCAT(firstname,' ',lastname) as 'nombrecompleto',
      title as 'titulo',
       hiredate as 'fechacontratacion'
from northwind.dbo.employees;

select top 0 *
into ejerciciojoins.dbo.dimempleados
from ejerciciojoins.dbo.empleados

select * from dimempleados

--4.-agregar nuevos datos a la tabla dimempleados por lo menos dos
INSERT INTO dimempleados (EmpleadoID, Nombre, Apellido, Departamento, FechaContratacion)
VALUES
(101, 'Juan', 'Pérez', 'Ventas', '2023-01-15'),
(102, 'María', 'González', 'Marketing', '2022-11-30');

select * from dimempleados

--5.-actializar la tabla empleados con los nuevos registros, la cual se llenaran en una nueva tabla llamada dim_producto

UPDATE empleados
SET 
    Nombre = 'NuevoNombre',
    Apellido = 'NuevoApellido',
    Departamento = 'NuevoDepartamento',
    FechaContratacion = 'NuevaFechaContratacion'
WHERE EmpleadoID = 'IDEspecifico';

CREATE TABLE dim_producto (
    ProductoID INT PRIMARY KEY,
    NombreProducto VARCHAR(255),
    Categoria VARCHAR(255),
    Precio DECIMAL(10, 2),
    FechaIngreso DATE
);

INSERT INTO dim_producto (ProductoID, NombreProducto, Categoria, Precio, FechaIngreso)
VALUES
(1, 'ProductoA', 'CategoríaA', 100.00, '2024-07-01'),
(2, 'ProductoB', 'CategoríaB', 150.00, '2024-07-02');

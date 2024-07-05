--consultas simples (consultas a una sola tabla)

 use Northwind;

 --seleccionar todos los customers (clientes)
 select * from Customers

 --proyecccion, selecciona 10 registos de los clientes
 select top 10 CustomerID, CompanyName, City, Country
 from  Customers

 --alias de columna
 --country as pais
 --country pais
 --country 'pais'
 --country as 'pais'
 --country as 'pais de las maravillas'

 select top 10 CustomerID as 'numero cliente', 
 CompanyName as NombreEmpresa, City as 'ciudad', Country 'pais'
 from  Customers

 --Alias de tablas
 select 

 select Customers.CustomerID, Customers.CompanyName, 
 Customers.City, Customers.Country
 from  Customers

  select c.CustomerID, c.CompanyName, c.City, c.Country
 from  Customers as c

 --campo calculado

 select *, (p.UnitPrice * p.UnitsInStock) as 'Costo inventario'
 from Products as p

select ProductName as 'Nombre Producto',
UnitsInStock as 'Existencia',
UnitPrice as 'Precio Unitario',
(p.UnitPrice * p.UnitsInStock) as 'Costo inventario'
from Products as p

--Filtrar datos 
--clausula where y operadores relacionales 
/*
<  ->Menor que 
> -> MAyor que
<= ->Menor igual
>= ->Mayor igual
<> ->Diferente
!= ->Diferente
= ->Igual a
*/

select * from Customers

--selecionar todos los clientes de alemania

select * 
from Customers
where Country = 'Germany'

--seleccionar todos los productos que tengan un stock mayor a 20 
--mostrando solamente el nombre del producto, precio y la existencia

select p.ProductID as 'nombre del producto',
p.UnitPrice as 'Precio',
p.UnitsInStock as 'Existencia'
from Products as p
where p.UnitsInStock > 20
order by p.UnitsInStock asc

--seleccionar todos los clientes ordenados de forma acendente 
-- por pais y dentro del pais ordenads de forma descendente por cuidad

select c.Country, c.City from Customers as c
where Country = 'Germany'
order by country, c.city asc

--eliminar valores repetidos en una consulta
--seleccionar los paises de los clientes

select distinct country from Customers
order by 1 asc

select count(distinct country)
from Customers

--seleccciona todos los productos donde el precio es mayor o igual a 18
select * from Products as p
where p.UnitPrice >= 18.0

select count (*) from Products as p
where p.UnitPrice <> 18.0

select * from Products as p
where p.UnitPrice != 18.0

--operadores logicos en sql (and, or, not)

--seleccionar todos los productos que tegan un precio entre 18 y 25 dolares

select * from Products as p
where p.UnitPrice between 18 and 25

select * from Products as p
where p.UnitPrice >=18 and p.UnitPrice <=25

--seleccioar todos los productos que no tengan un precio entre 18 y 25 dolares
select * from Products as p 
where p.UnitPrice not between 18 and 25

select * from Products as p 
where not (p.UnitPrice >= 18 and p.UnitPrice <= 25)


--seleccionar todos los productos donde el precio sea mayor o igual a 38 y su existencia sea mayor e igual a 22

select *from Products as p 
where p.UnitPrice >38 and p.UnitsInStock >=22

--seleccionar todos loc clientes de alemanai, mexico y francia 

select Country from Customers as c
where c.Country = 'Germany' or c.Country = 'Mexico'
or c.Country = 'France'

select Country from Customers as c
where c.Country in ('Germany', 'Mexico', 'France')

--seleccionar todos los clientes que no tengan region

select * from Customers as c
where c.Region is null

--que si tienen region
select * from Customers as c
where c.Region is not null


--seleccionar todas las ordenes enviadas de julio de 1996 a abril de 1998 para los empleados de buchanan, leverling, davolio

select * from Orders as o
where o.ShippedDate between '1996-07-01' and '1997-04-30'
and o.EmployeeID in (5,3,1)

select e.LastName as 'Empleado' from 
Employees as e
inner join Orders as o
on e.EmployeeID = o.EmployeeID
where o.ShippedDate between '1996-07-01' and '1997-04-30'
and e.LastName in ('buchanan','leverling', 'Davolio')
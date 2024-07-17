create or alter procedure spu_empleado
--parametros de entrada , salida
@empleadoid int,
@nombre varchar (50),
@salario money
as
begin
insert into empleado(idempleado,nombre,salario)
values(@empleadoid,@nombre,@salario);
insert into auditoria(evento,fecha)
values('insert',getdate());
end
exec spu_empleado (2,'vania',95000)
exec spu_empleado @nombre = 'vania', @salario=300, @empleadoid=3

create or alter proc spu_salida
@numeroregistros int outpput
as
begin
select @numeroregistros = COUNT(*)
from empleado;
end;

declare @resultado int
spu_salida @numeroregistros = @resultado output
print @resultado


--realizar un sp que muestre el total de ventas realizadas a cada uno de los clientes por un rango de años
use Northwind

--se realiza primero la consulta a la tabla
select c.CompanyName,od.UnitPrice, od.Quantity
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID 
inner join [Order Details] as od
on o.OrderID = od.OrderID


/*

*/
create or alter proc spu_ventas
@añoinicial int,
@añofinal int
select c.CompanyName,sum(od.UnitPrice*od.Quantity) as total
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID 
inner join [Order Details] as od
on o.OrderID = od.OrderID
where DATEPART(year,o.OrderDate)between @añoinicial and @añofinal
group by c.CompanyName

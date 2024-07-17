/*
actualizar los precios de los productos y que guarde en una tabla de historicos, id de la tabla, id del producto, precio anterior, precio nuevo y fecha en que se realizo 

que elimine una orden y que alctualice el stock del producto
*/

use Northwind;

select * from [Order Details]
select * from Products
select * from Orders

create or alter procedure sp_actualizarStock
@OrdenID int
as
begin 
begin transaction;

begin try

delete from [Order Details]
where OrderID = @OrdenID;

delete from Orders
where OrderID = @OrdenID;

UPDATE p
SET p.UnitsInStock = p.UnitsInStock + od.Quantity
FROM [Order Details] as od
INNER JOIN Products as p 
ON od.ProductID = p.ProductID
WHERE od.OrderID = @OrdenID;

commit transaction;
end try
begin catch
rollback transaction;
declare @mensajeERROR varchar (max)
set @mensajeERROR = ERROR_MESSAGE()
print @mensajeERROR
end catch;
end;
go

exec sp_actualizarStock @ordenID = '10248'
go

rollback
declare @x int = 1

if @x>0
BEGIN
print 'el numero es positivo'
end 
ELSE
BEGIN
print 'el numero es negativo'
END

declare @i int 
set @i,= 1

while @i<=10
BEGIN
PRINT 'el primer valor es :'+CAST(@i as varchar)
set @i = @i+1
end


--crear un sp
create PROCEDURE Procedure_Ciclo
as

declare @x INT
set @x=10

print 'El valor de x es: '+ cast(@x as VARCHAR)

if @x >=0
BEGIN
print 'El numero es positivo'
END
ELSE
BEGIN
PRINT 'El numero es negativo'
END

DECLARE @i as INT set @i=1
while (@i<=10)
BEGIN
print cast (@i as VARCHAR)
set @i=@i+1
end 


declare @li int = 1


while @li <=2
BEGIN
     exec Procedure_Ciclo
     set @li = @li + 1
end

drop procedure Procedure_Ciclo
@n1 as INT
@sn2 as int 


create procedure sp_suma1
AS
BEGIN

declare @suma int
set @suma =4+5
print 'la suma es :'+cast (@suma as varchar)
end 

execute sp_suma1 5,6


--realizar un store procedure que muestre todas las ventas realizadas por cliente para 1 año cualquiera
use northwind

select c.CompanyName as 'nombre del cliente',
sum(od.Quantity * od.UnitPrice) as total 
from Customers as c 
inner join Orders as o 
on c.CustomerID = o.CustomerID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
where DATEPART (year,o.OrderDate) = 1996
group by c.CompanyName;


create or alter PROC sp_ventasCliente
--parametros
@year as int 
as 
BETWEEN

select c.CompanyName as 'nombre del cliente',
sum(od.Quantity * od.UnitPrice) as total 
from Customers as c 
inner join Orders as o 
on c.CustomerID = o.CustomerID
inner join [Order Details] as od 
on od.OrderID = o.OrderID
where DATEPART (year,o.OrderDate) = @year
group by c.CompanyName

end


--Ejeutar el sp
exec sp_ventasporcliente 1997

execute sp_ventasporcliente 1996

exec sp_ventasporcliente @year = 1998

--Ejercicio 1: realizar un store procedure que muestre un reporte de ventas,
-- por cliente y producto (agrupado), de un rango de fechas


--Ejercicio 2: realizar un store procedure que inserte un cliente nuevo
create or alter procedure agregar_cliente
--parametros

AS 
     @CustomerID nchar(5),
     @CompanyName nvarchar(40),
     @ContactName nvarchar(30) = null,
     @ContactTitle nvarchar(30) = null,
     @Address nvarchar(60) = null,
     @City nvarchar(15) = null,
     @Region nvarchar(15) = null,
     @PostalCode nvarchar(10) = null,
     @Country nvarchar(15) = null,
     @Phone nvarchar(24) = null,
     @Fax nvarchar(24) = null
BEGIN
     INSERT INTO [dbo].[Customers]
           ([CustomerID],
           [CompanyName],
           [ContactName],
           [ContactTitle],
           [Address],
           [City],
           [Region],
           [PostalCode],
           [Country],
           [Phone],
           [Fax])
     VALUES(@CustomerID,
           @CompanyName,
           @ContactName,
           @ContactTitle,
           @Address,
           @City,
           @Region,
           @PostalCode,
           @Country,
           @Phone,
           @Fax)

end;

exec agregar_cliente
     @CustomerID = 'gtig3',
     @CompanyName = 'edith capmos cruz',
     @ContactName = 'edith campos',
     @ContactTitle = 'tutora',
     @Address = 'calle del infierno',
     @City = 'tula',
     @Region = 'sur',
     @PostalCode = '42800',
     @Country = 'mexico',
     @Phone = '5527613160',

     select * from Customers
     where 

/*02-07-24*/
--store procedure (parametros de salida)
--crear un store procedure que calcule el area de un circulo

create or alter procedure sp_calcular_area_circulo
@radio float, --parametro de entrada
@area float output
As
begin
    set @area = PI() * @radio * @radio

end;

go

declare @resultado float
exec sp_calcular_area_circulo @radio = 22.3, @area = @resultado output

print 'el valor del area es: ' + cast(@resultado as varchar);



create or alter proc obtener_info_empleado
@employeeid int = -1,
@apellido nvarchar(20) output,
@nombre nvarchar (10) output 
as 
begin 
if @employeeid <> -1
begin 
select @nombre = FirstName, @apellido = LastName  
from Employees
where EmployeeID = @employeeid
end
else
begin
print('el valor del empleado no es valido')
end
end

--con employeeid
declare @firstname as nvarchar(10),
@lastname nvarchar(20)

exec obtener_info_empleado @employeeid = 1,@nombre = @firstname output,
@apellido = @lastname output
print ('el nombre es: '+ @firstname)
print ('el apellido es: '+ @lastname)

--sin employeeid
declare @firstname as nvarchar(10),
@lastname nvarchar(20)

exec obtener_info_empleado
@nombre = @firstname output, @apellido = @lastname output
print ('el nombre es: '+ @firstname)
print ('el apellido es: '+ @lastname)


--obtener el nombre de un empledado dado verificar si el empleado introdcido existe
create or alter proc obtener_info_empleado2
@employeeid int = -1,
@apellido nvarchar(20) output,
@nombre nvarchar (10) output 
as 
begin 

declare @existe int
set @existe=(select count(*) from Employees where EmployeeID= @employeeid)
--select @existe = count(*) from Employees where EmployeeID= @employeeid

if @employeeid <> -1 or @existe >0
begin 
select @nombre = FirstName, @apellido = LastName  
from Employees
where EmployeeID = @employeeid
end
else
begin
if @employeeid = -1 
begin
print('se debe introducir un valor')
end
else if @existe = 0
begin 
print ('el valor del empleado no existe en la tabla')
end
end
end

-----------------------------------------------------------------
declare @firstname as nvarchar(10),
@lastname nvarchar(20)

exec obtener_info_empleado2 @employeeid = 10,
@nombre = @firstname output,@apellido = @lastname output
print ('el nombre es: '+ @firstname)
print ('el apellido es: '+ @lastname)

--realizar un sp que guarde en una variable de salida el total de campos que ha realizado un cliente dado en un rango de fechas
create or alter proc obtener_ventas_por_cliente
@customerid nchar(5),
@fechainicial date,
@fechafinal date,
@total decimal(10,2) output
as
begin
select @total = sum(od.UnitPrice * od.Quantity)
from [Order Details] as od 
inner join Orders as o
on od.OrderID = o.OrderID
where CustomerID = @customerid and 
OrderDate between @fechainicial and @fechafinal;
end

exec obtener_ventas_por_cliente @customerid = 3,
@fechainicial = '',
@fechafinal = ''

-- Ejercici 1: 
-- Realizar una venta dentro de la base de datos nothwind, 
-- Utilizando transacciones y store procedures
use northwind;
Go

Create or Alter proc sp_nueva_venta
@CustomerID nchar(5),
@EmployeeID int,
@OrderDate datetime,
@RequiredDate datetime,
@ShippedDate  datetime,
@ShipVia int,
@Freight money = null,
@ShipName nvarchar(40) = null,
@ShipAddress nvarchar(60) = null,
@ShipCity nvarchar(15) = null,
@ShipRegion nvarchar(15) = null,
@ShipPostalCode nvarchar(15) = null,
@ShipCountry nvarchar(15) = null,
@ProductID int,
@UnitPrice money,
@Quantity smallint,
@Discount real
AS
begin 
    Begin Transaction
    
	begin try
	-- Insertar en la tabla order
	INSERT INTO [dbo].[Orders]
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
     VALUES
           (@CustomerID,
            @EmployeeID, 
			@OrderDate, 
			@RequiredDate, 
			@ShippedDate, 
			@ShipVia, 
			@Freight, 
			@ShipName, 
			@ShipAddress, 
			@ShipCity,
			@ShipRegion,
			@ShipPostalCode,
			@ShipCountry);

			-- Obtener el id insertado de la orden
			Declare @orderid int 
			SET @orderid = SCOPE_IDENTITY();

			-- Insertar en detalle_orden el producto
			-- Obtener el precio del producto a insertar
			Declare @precioVenta money
		
			Select @precioVenta = UnitPrice from products
			where ProductID = @ProductID

		   --set @precioVenta = (Select  UnitPrice from products
		   -- where ProductID = 3)

		   -- insertar en la tabla orderdetails
		   INSERT INTO [dbo].[Order Details]
           ([OrderID]
           ,[ProductID]
           ,[UnitPrice]
           ,[Quantity]
           ,[Discount])
     VALUES
           (
		    @orderid,
		    @ProductID,
            @precioVenta,
            @Quantity,
            @Discount);

	-- Actualizar la tabla products reduciendo el unitinstock con 
	-- a cantidad vendida
	update products
	set UnitsInStock = UnitsInStock - @Quantity
	where ProductID = @ProductID;

	commit transaction;

	end try
	begin catch
	  rollback transaction;
	  declare @mensajeError varchar(400);
	  set @mensajeError = ERROR_MESSAGE();
	  print @mensajeError;
	end catch

end;
go


select * from Products
where ProductID = 9

select max(orderid)
from Orders






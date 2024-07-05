--1.- inserte o actualice los registros nuevos o los cambios en la tabla Product, Suppliers, Customers, Emplpyees 
--tomando como base Northwind (Store Procedure)
create procedure insertProducto



--2.-Crear un sp que actualice la tabla ventas
CREATE PROCEDURE actualizarVentas (
    @OrderID INT,
    @CustomerID NCHAR(5),
    @EmployeeID INT,
    @OrderDate DATETIME,
    @RequiredDate DATETIME,
    @ShippedDate DATETIME,
    @ShipVia INT,
    @Freight MONEY,
    @ShipName NVARCHAR(40),
    @ShipAddress NVARCHAR(60),
    @ShipCity NVARCHAR(15),
    @ShipRegion NVARCHAR(15),
    @ShipPostalCode NVARCHAR(10),
    @ShipCountry NVARCHAR(15)
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Orders WHERE OrderID = @OrderID)
    BEGIN
        UPDATE Orders
        SET CustomerID = @CustomerID,
            EmployeeID = @EmployeeID,
            OrderDate = @OrderDate,
            RequiredDate = @RequiredDate,
            ShippedDate = @ShippedDate,
            ShipVia = @ShipVia,
            Freight = @Freight,
            ShipName = @ShipName,
            ShipAddress = @ShipAddress,
            ShipCity = @ShipCity,
            ShipRegion = @ShipRegion,
            ShipPostalCode = @ShipPostalCode,
            ShipCountry = @ShipCountry
        WHERE OrderID = @OrderID;
    END
    ELSE
    BEGIN
        RAISERROR('OrderID %d does not exist.', 16, 1, @OrderID);
    END
END
GO

--3.-Crear un sp que permita vizualizar cuantas ordenes se han echo por año y pais
CREATE PROCEDURE ordenesAñoyPais
AS
BEGIN
    SELECT 
        YEAR(OrderDate) AS OrderYear,
        ShipCountry,
        COUNT(*) AS OrderCount
    FROM Orders
    GROUP BY YEAR(OrderDate), ShipCountry
    ORDER BY OrderYear, ShipCountry;
END
GO
---EJEMPLO
companyname, (unitprice * quantity)

create or alter proc sp_ventas_provedor
@year int, @month int, @day int
as
begin
select s.CompanyName, 
sum (od.UnitPrice * od.Quantity) as 'importe'
from 
Suppliers as s
inner join Products as p 
on s.SupplierID = p.SupplierID
inner join [Order Details] as od
on p.ProductID = od.ProductID
inner join Orders as o 
on o.OrderID = od.OrderID
where datepart(year,o.OrderDate) = @year
and datepart (month, o.OrderDate) =@month
and datepart (day, o.OrderDate) = @day
group by s.CompanyName
order by s.CompanyName;
end

go

--Formas de ejeutar el sp
exec sp_ventas_provedor 1995,07,05
exec sp_ventas_provedor 1996,07,04


exec sp_ventas_provedor @day=04, @year=1996, @month='july'

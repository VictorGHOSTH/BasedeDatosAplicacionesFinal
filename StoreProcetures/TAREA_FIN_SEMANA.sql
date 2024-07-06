--1.- inserte o actualice los registros nuevos o los cambios en la tabla Product, Suppliers, Customers, Emplpyees 
--tomando como base Northwind (Store Procedure)

--Products
CREATE PROCEDURE sp_InsertOrUpdateProduct
    @ProductID INT,
    @ProductName NVARCHAR(40),
    @SupplierID INT,
    @CategoryID INT,
    @QuantityPerUnit NVARCHAR(20),
    @UnitPrice DECIMAL(18, 2),
    @UnitsInStock SMALLINT,
    @UnitsOnOrder SMALLINT,
    @ReorderLevel SMALLINT,
    @Discontinued BIT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID)
    BEGIN
        UPDATE Products
        SET
            ProductName = @ProductName,
            SupplierID = @SupplierID,
            CategoryID = @CategoryID,
            QuantityPerUnit = @QuantityPerUnit,
            UnitPrice = @UnitPrice,
            UnitsInStock = @UnitsInStock,
            UnitsOnOrder = @UnitsOnOrder,
            ReorderLevel = @ReorderLevel,
            Discontinued = @Discontinued
        WHERE ProductID = @ProductID;
    END
    ELSE
    BEGIN
        INSERT INTO Products (
            ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
        VALUES (
            @ProductName, @SupplierID, @CategoryID, @QuantityPerUnit, @UnitPrice, @UnitsInStock, @UnitsOnOrder, @ReorderLevel, @Discontinued);
    END
END;

--Suppliers
CREATE PROCEDURE sp_InsertOrUpdateSupplier
    @SupplierID INT,
    @CompanyName NVARCHAR(40),
    @ContactName NVARCHAR(30),
    @ContactTitle NVARCHAR(30),
    @Address NVARCHAR(60),
    @City NVARCHAR(15),
    @Region NVARCHAR(15),
    @PostalCode NVARCHAR(10),
    @Country NVARCHAR(15),
    @Phone NVARCHAR(24),
    @Fax NVARCHAR(24),
    @HomePage NTEXT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Suppliers WHERE SupplierID = @SupplierID)
    BEGIN
        UPDATE Suppliers
        SET
            CompanyName = @CompanyName,
            ContactName = @ContactName,
            ContactTitle = @ContactTitle,
            Address = @Address,
            City = @City,
            Region = @Region,
            PostalCode = @PostalCode,
            Country = @Country,
            Phone = @Phone,
            Fax = @Fax,
            HomePage = @HomePage
        WHERE SupplierID = @SupplierID;
    END
    ELSE
    BEGIN
        INSERT INTO Suppliers (
            CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax, HomePage)
        VALUES (
            @CompanyName, @ContactName, @ContactTitle, @Address, @City, @Region, @PostalCode, @Country, @Phone, @Fax, @HomePage);
    END
END;

--Customers
CREATE PROCEDURE sp_InsertOrUpdateCustomer
    @CustomerID NCHAR(5),
    @CompanyName NVARCHAR(40),
    @ContactName NVARCHAR(30),
    @ContactTitle NVARCHAR(30),
    @Address NVARCHAR(60),
    @City NVARCHAR(15),
    @Region NVARCHAR(15),
    @PostalCode NVARCHAR(10),
    @Country NVARCHAR(15),
    @Phone NVARCHAR(24),
    @Fax NVARCHAR(24)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
    BEGIN
        UPDATE Customers
        SET
            CompanyName = @CompanyName,
            ContactName = @ContactName,
            ContactTitle = @ContactTitle,
            Address = @Address,
            City = @City,
            Region = @Region,
            PostalCode = @PostalCode,
            Country = @Country,
            Phone = @Phone,
            Fax = @Fax
        WHERE CustomerID = @CustomerID;
    END
    ELSE
    BEGIN
        INSERT INTO Customers (
            CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax)
        VALUES (
            @CustomerID, @CompanyName, @ContactName, @ContactTitle, @Address, @City, @Region, @PostalCode, @Country, @Phone, @Fax);
    END
END;

--Employees
CREATE PROCEDURE sp_InsertOrUpdateEmployee
    @EmployeeID INT,
    @LastName NVARCHAR(20),
    @FirstName NVARCHAR(10),
    @Title NVARCHAR(30),
    @TitleOfCourtesy NVARCHAR(25),
    @BirthDate DATETIME,
    @HireDate DATETIME,
    @Address NVARCHAR(60),
    @City NVARCHAR(15),
    @Region NVARCHAR(15),
    @PostalCode NVARCHAR(10),
    @Country NVARCHAR(15),
    @HomePhone NVARCHAR(24),
    @Extension NVARCHAR(4),
    @Photo VARBINARY(MAX),
    @Notes NTEXT,
    @ReportsTo INT,
    @PhotoPath NVARCHAR(255)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Employees WHERE EmployeeID = @EmployeeID)
    BEGIN
        UPDATE Employees
        SET
            LastName = @LastName,
            FirstName = @FirstName,
            Title = @Title,
            TitleOfCourtesy = @TitleOfCourtesy,
            BirthDate = @BirthDate,
            HireDate = @HireDate,
            Address = @Address,
            City = @City,
            Region = @Region,
            PostalCode = @PostalCode,
            Country = @Country,
            HomePhone = @HomePhone,
            Extension = @Extension,
            Photo = @Photo,
            Notes = @Notes,
            ReportsTo = @ReportsTo,
            PhotoPath = @PhotoPath
        WHERE EmployeeID = @EmployeeID;
    END
    ELSE
    BEGIN
        INSERT INTO Employees (
            LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Photo, Notes, ReportsTo, PhotoPath)
        VALUES (
            @LastName, @FirstName, @Title, @TitleOfCourtesy, @BirthDate, @HireDate, @Address, @City, @Region, @PostalCode, @Country, @HomePhone, @Extension, @Photo, @Notes, @ReportsTo, @PhotoPath);
    END
END;





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

exec sp_ventas_provedor 1995,07,05
exec sp_ventas_provedor 1996,07,04


exec sp_ventas_provedor @day=04, @year=1996, @month='july'

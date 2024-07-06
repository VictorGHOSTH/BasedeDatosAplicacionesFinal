-- Consultas Avanzadas
select c.CategoryName As 'Nombre Categoria', 
p.ProductName as 'Nombre Producto', 
p.UnitPrice as 'Precio', 
p.UnitsInStock as 'Existencia'
from 
Categories AS c
inner join Products As p
on c.CategoryID = p.CategoryID
where CategoryName  in ('Beverages', 'Produce')

-- Ejercicio 1: Obtener el nombre del cliente y el nombre del empleado 
-- del representante de ventas de cada pedido.

SELECT o.orderid as 'Numero de orden',
o.orderdate as 'Fecha de orden',c.CompanyName as 'Nombre del Cliente',
CONCAT(e.firstname, ' ', e.lastname) as 'Nombre del Empleado' 
FROM 
Employees as e
INNER JOIN 
Orders AS o
on  e.EmployeeID = o.EmployeeID
INNER JOIN 
customers as c
on o.CustomerID = c.CustomerID;





--Ejercicio 2: Mostrar el nombre del producto, el nombre del proveedor y el precio unitario de cada producto.
SELECT 
    p.ProductName, 
    s.CompanyName AS SupplierName, 
    p.UnitPrice
FROM 
    Products p
JOIN 
    Suppliers s ON p.SupplierID = s.SupplierID;


--Ejercicio 3: Listar el nombre del cliente, el ID del pedido y la fecha del pedido para cada pedido.
SELECT 
    c.CompanyName AS CustomerName, 
    o.OrderID, 
    o.OrderDate
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID;

--Ejercicio 4: Obtener el nombre del empleado, el título del cargo y el departamento del empleado para cada empleado.
SELECT 
    CONCAT(FirstName, ' ', LastName) AS EmployeeName,
    Title AS JobTitle
FROM 
    Employees;


--Ejercicio 5: Mostrar el nombre del proveedor, el nombre del contacto y el teléfono del contacto para cada proveedor.
SELECT 
    CompanyName AS SupplierName,
    ContactName AS ContactPersonName,
    Phone AS ContactPhone
FROM 
    Suppliers;

--Ejercicio 6: Listar el nombre del producto, la categoría del producto y el nombre del proveedor para cada producto.
SELECT 
    p.ProductName AS ProductName,
    c.CategoryName AS Category,
    s.CompanyName AS SupplierName
FROM 
    Products p
JOIN 
    Categories c ON p.CategoryID = c.CategoryID
JOIN 
    Suppliers s ON p.SupplierID = s.SupplierID;

--Ejercicio 7: Obtener el nombre del cliente, el ID del pedido, el nombre del producto y la cantidad del producto para cada detalle del pedido.
SELECT 
    c.CompanyName AS CustomerName,
    o.OrderID,
    p.ProductName,
    od.Quantity
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID;

--Ejercicio 8: Obtener el nombre del empleado, el nombre del territorio y la región del territorio para cada empleado que tiene asignado un territorio.
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    t.TerritoryDescription AS TerritoryName,
    r.RegionDescription AS RegionName
FROM 
    Employees e
JOIN 
    EmployeeTerritories et ON e.EmployeeID = et.EmployeeID
JOIN 
    Territories t ON et.TerritoryID = t.TerritoryID
JOIN 
    Region r ON t.RegionID = r.RegionID;

--Ejercicio 9: Mostrar el nombre del cliente, el nombre del transportista y el nombre del país del transportista para cada pedido enviado por un transportista.
SELECT 
    c.CompanyName AS CustomerName,
    s.ShipperName AS ShipperName,
    s.ShipperCountry AS ShipperCountry
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    Shippers s ON o.ShipVia = s.ShipperID;

--Ejercicio 10: Obtener el nombre del producto, el nombre de la categoría y la descripción de la categoría para cada producto que pertenece a una categoría.
SELECT 
    p.ProductName AS ProductName,
    c.CategoryName AS CategoryName,
    c.[Description] AS CategoryDescription
FROM 
    Products p
JOIN 
    Categories c ON p.CategoryID = c.CategoryID;

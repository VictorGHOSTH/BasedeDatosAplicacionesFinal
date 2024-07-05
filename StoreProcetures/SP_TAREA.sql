use northwind;

/*Primer ejercicio*/
--crear una base de datos que permita vizualizar 
--lo vendido a los clientes mostrando el nombre del cliente y en año
CREATE PROCEDURE VisualzacionVentas
    @Year INT
AS
BEGIN
    SELECT 
        c.CompanyName AS nombrecliente,
        YEAR(o.OrderDate) AS añoOrden,
        SUM(od.Quantity * od.UnitPrice) AS ventastotales
    FROM 
        Orders o
        INNER JOIN Customers c ON o.CustomerID = c.CustomerID
        INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
    WHERE 
        YEAR(o.OrderDate) = @Year
    GROUP BY 
        c.CompanyName, 
        YEAR(o.OrderDate)
    ORDER BY 
        ventastotales DESC;
END;


EXEC VisualzacionVentas @Year = 1997;



select * from Customers

select * from Suppliers


/*Segundo ejercicio*/
--crear un store procedure que permita insertar un producto en la tabla Products

CREATE PROCEDURE InsertarProducto
    @ProductName NVARCHAR(40),
    @SupplierID INT,
    @CategoryID INT,
    @QuantityPerUnit NVARCHAR(20),
    @UnitPrice DECIMAL(10, 2),
    @UnitsInStock SMALLINT,
    @UnitsOnOrder SMALLINT,
    @ReorderLevel SMALLINT,
    @Discontinued BIT
AS
BEGIN

    BEGIN TRANSACTION;

    BEGIN TRY
        INSERT INTO Products (
            ProductName, 
            SupplierID, 
            CategoryID, 
            QuantityPerUnit, 
            UnitPrice, 
            UnitsInStock, 
            UnitsOnOrder, 
            ReorderLevel, 
            Discontinued
        )
        VALUES (
            @ProductName, 
            @SupplierID, 
            @CategoryID, 
            @QuantityPerUnit, 
            @UnitPrice, 
            @UnitsInStock, 
            @UnitsOnOrder, 
            @ReorderLevel, 
            @Discontinued
        );

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        
        ROLLBACK TRANSACTION;


        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;


/*Tercer ejercicio*/
--crear un sp que inserteen los catalogos customer, employee, category, pero el sp debe recicbir 
--tambien como parametro el catalogo a insertar

CREATE PROCEDURE InsertIntoCatalog
    @Catalog NVARCHAR(50),
    @CustomerID NCHAR(5) = NULL,
    @CompanyName NVARCHAR(40) = NULL,
    @ContactName NVARCHAR(30) = NULL,
    @ContactTitle NVARCHAR(30) = NULL,
    @Address NVARCHAR(60) = NULL,
    @City NVARCHAR(15) = NULL,
    @Region NVARCHAR(15) = NULL,
    @PostalCode NVARCHAR(10) = NULL,
    @Country NVARCHAR(15) = NULL,
    @Phone NVARCHAR(24) = NULL,
    @Fax NVARCHAR(24) = NULL,
    @LastName NVARCHAR(20) = NULL,
    @FirstName NVARCHAR(10) = NULL,
    @Title NVARCHAR(30) = NULL,
    @TitleOfCourtesy NVARCHAR(25) = NULL,
    @BirthDate DATETIME = NULL,
    @HireDate DATETIME = NULL,
    @ReportsTo INT = NULL,
    @CategoryName NVARCHAR(15) = NULL,
    @Description NVARCHAR(255) = NULL
AS
BEGIN
    -- Iniciar una transacción
    BEGIN TRANSACTION;

    BEGIN TRY
        IF @Catalog = 'Customers'
        BEGIN
            INSERT INTO Customers (
                CustomerID,
                CompanyName,
                ContactName,
                ContactTitle,
                Address,
                City,
                Region,
                PostalCode,
                Country,
                Phone,
                Fax
            )
            VALUES (
                @CustomerID,
                @CompanyName,
                @ContactName,
                @ContactTitle,
                @Address,
                @City,
                @Region,
                @PostalCode,
                @Country,
                @Phone,
                @Fax
            );
        END
        ELSE IF @Catalog = 'Employees'
        BEGIN
            INSERT INTO Employees (
                LastName,
                FirstName,
                Title,
                TitleOfCourtesy,
                BirthDate,
                HireDate,
                Address,
                City,
                Region,
                PostalCode,
                Country,
                HomePhone,
                ReportsTo
            )
            VALUES (
                @LastName,
                @FirstName,
                @Title,
                @TitleOfCourtesy,
                @BirthDate,
                @HireDate,
                @Address,
                @City,
                @Region,
                @PostalCode,
                @Country,
                @Phone, -- Assuming Phone is HomePhone
                @ReportsTo
            );
        END
        ELSE IF @Catalog = 'Categories'
        BEGIN
            INSERT INTO Categories (
                CategoryName,
                Description
            )
            VALUES (
                @CategoryName,
                @Description
            );
        END
        ELSE
        BEGIN
            -- Si el catálogo no es válido, lanzar un error
            RAISERROR('Catalog not recognized', 16, 1);
        END

        -- Si la inserción es exitosa, confirmar la transacción
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- En caso de error, deshacer la transacción
        ROLLBACK TRANSACTION;

        -- Devolver el error
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;


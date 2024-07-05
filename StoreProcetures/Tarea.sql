create DATABASE Tarea2
use Tarea2;


create TABLE Customer(
    clienteID int not null UNIQUE identity (1,1),
    clienteBK  int not null UNIQUE ,
    CompanyName VARCHAR(50) UNIQUE not null,
    [Address] VARCHAR(50) not null,
    City varchar(50) not null,
    Region VARCHAR(50) not null,
    Country varchar (50) not null,
    CONSTRAINT PK_clienteID
    PRIMARY key (clienteID)
)
CREATE TABLE Supplier(
    supplierID int not null UNIQUE IDENTITY(1,1),
    supplierBK int not null UNIQUE ,
    CompanyName VARCHAR(50) UNIQUE not null,
    country VARCHAR(50) not null,
    [Address] VARCHAR(50) not null,
    city VARCHAR(50) not NULL
    CONSTRAINT Pk_Supplier
    PRIMARY key (supplierID)
)
CREATE TABLE Employee(
    employeeID INT NOT NULL UNIQUE IDENTITY(1,1),
    employeeBK int not null UNIQUE,
    First_Name VARCHAR(50) not null,
    Last_Name VARCHAR(50) not null,
    Title VARCHAR(50) not null,
    HireDate date not null,
    [Address] VARCHAR (50) not null,
    city VARCHAR(50) not null,
    Region VARCHAR(50) not null,
    Country VARCHAR(50) not null,
    CONSTRAINT Pk_Employee
    PRIMARY key (employeeID)

)
CREATE TABLE Product(
    ProductID int not null UNIQUE IDENTITY(1,1),
    ProductBK int not null UNIQUE ,
    Product_Name VARCHAR(50) UNIQUE,
    Category_Name int not null UNIQUE ,
    CONSTRAINT pk_producto
    PRIMARY KEY (ProductID)
)

Create TABLE Ventas(
    clienteID int not null UNIQUE ,
    ProductID int not null UNIQUE ,
    employeeID INT NOT NULL UNIQUE ,
    supplierID int not null UNIQUE,
    quantity int,
    unitPrice money,
    CONSTRAINT FK_Customer
    FOREIGN key (clienteID)
    REFERENCES Customer(clienteID),
    CONSTRAINT FK_Product
    FOREIGN key (ProductID)
    REFERENCES Product(ProductID),
    CONSTRAINT FK_Employee
    FOREIGN key (employeeid)
    REFERENCES Employee(employeeID),
    CONSTRAINT FK_Supplier
    FOREIGN key (supplierID)
    REFERENCES Supplier(supplierID)


)
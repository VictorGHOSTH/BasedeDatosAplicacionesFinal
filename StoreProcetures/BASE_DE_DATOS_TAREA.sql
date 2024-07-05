create DATABASE tareabd;
use tareabd;

create TABLE suppliers(
    
);
INSERT INTO suppliers (supplierid, supplierpk, companyname, country, address, city)
SELECT Supplierid, Supplierpk, CompanyName, Country, Addres, City
FROM dbo.suppliers;
go
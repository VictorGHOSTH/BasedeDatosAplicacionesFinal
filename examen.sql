--Ejercicio 1
/*nombre - name -product 
product number - product
name - product subcateorie
categorye name - product categorie*/

use AdventureWorks2019

create or alter procedure usp_GetProductInfo
@ProductID int;

as
begin
select
p.name as 'nombre del producto',
p.productnumber as 'numero del producto',
ps.name_product as ''

from Production as p
inner join subcategories as ps 




--Ejercicio 2 

create or alter procedure usp_UpdateProductPriceSimple 
@ProductID int,
@NewPrice money;

as 
begin
if exists (select 1 from Production where ProductID = @ProductID)
begin 
update Production
set 
ProductID = @ProductID,
Unitprice = @NewPrice
where ProductID = PRoductID;
end 
else
begin
insert into Auditoria(ProductID, NewPrice)
values(@ProductID, @NewPrice)
end
end;
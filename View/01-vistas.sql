create database vistaspractica

use vistaspractica

--crear una vista de la siguiente consulta
--modificacion alter or view
create view view_categorias_productos 
AS

select c.categoryname as 'nombre categoria',
p.productname as 'nombre producto',
p.uniteprice as 'precio',
p.unitsinstock as 'existencia'
FROM
Northwind.dbo.categories as C
inner join product as p 
on c.categoryid = p.categoryid


select * ,(precio*existenca) as 'precioinventario'
from view_categorias_productos
where [nombre categoria] in ('beberages', 'condiments')
order by [nombre categoria] desc;

--seleccionar la suma del precio del inentario agrupada por categoria
select SUM(uniteprice * unitinstock) as 'suma del precio del inventario'
 from view_categorias_productos
 group by categoryname
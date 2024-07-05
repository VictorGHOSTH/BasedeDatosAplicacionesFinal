/*Sintaxis del trigger 
create trigger "nombre del trigger"
on nombre_tabla
after insert, delete, update
as 
begin
-------codigo
end*/

/*
create trigger verificar_insert_tabla1
on tabla1
after insert
as
begin 
print 'se ejecuto el trigger en la tabla 1'
end*/

/*En el caso del update se mueve el campo a la tabla delete y en su lugar se coloca el nuevo campo*/

create database pruebatriggersg3
go

use pruebatriggersg3
go

create table tabla1
(
id int not null primary key,
nombre varchar(50) not null
)

--triggers 
--trigger que verifica el evento que se ejecuto
create or alter trigger tg_verificar_insercion
on tabla1
after insert
as
begin
print 'se ejecuto el evento insert en la tabla1'
end;


insert into tabla1
values (1, 'Nombre1')

--trigger que verifica el evento que se ejecuto
create or alter trigger tg_verificar_insercion
on tabla1
after delete
as
begin
print 'se ejecuto el evento delete en la tabla1'
end;

delete tabla1
where id=1

insert into tabla1
values (1, 'Nombre1')

--trigger que verifica el evento que se ejecuto
create or alter trigger tg_verificar_insercion
on tabla1
after update
as
begin
print 'se ejecuto el evento update en la tabla1'
end;

update tabla1
set nombre = 'nombre nuevo'
where id = 1;


drop trigger tg_verificar_insercion
drop trigger tg_verificar_delete
drop trigger tg_verificar_update

create or alter trigger verificar_contenido_inserted
on tabla1
after insert
as
begin 
--ver los datos de la tabla inserted
select * from inserted;
end;

insert into tabla1
values (2, 'nombre2')

select * from tabla1

insert into tabla1
values(4,'nombre4'), (5,'nombre5')

use Northwind


create or alter trigger verificar_inserted_categories
on categories
after insert
as
begin
select categoryid, categoryname, [description] from inserted;
end;

insert into categories (categoryname, [description])
values ('categorianueva', 'Prueba triggers')

create or alter trigger verificar_update_categories
on categories 
after update
as
begin 
select categoryid, categoryname, [description] from inserted;
select categoryid, categoryname, [description] from deleted;
end;

begin transaction

update categories
set categoryname = 'categoria otra',
    [description] = 'si esta bien'
where categoryid = 9

/*dentro de una transaccion se puede confirmar --> "Commit" y cancelar --> "Rollback"*/

drop trigger verificar_inserted_categories

create or alter trigger verificar_inserted_deleted
on categories
after insert, update, delete
as
begin
if exists(select 1 from inserted ) and not exists(select 1 from deleted) 
begin
print ('existen datos en la tabla inserted, se ejecuto un insert')
end;
if exists(select 1 from deleted) and not exists(select 1 from inserted)
begin
print ('existen datos en la tabla delete, se ejecuto un delete')
end;
else if exists(select 1 from deleted) and
exists(select 1 from inserted )
begin 
print 'existen datos en las dos tablas, se realizo un update'
end;

insert into categories(categoryname, [description])
values ('ctaegoria10','pinpon')

drop trigger verificar_inserted_deleted

/*creaar un trigger en la base de datos prueba triggers g 3 para la tabla empleados, 
este trigger debe evitar que se inserten o modifiquen salarios mayores a 50000*/

use pruebatriggersg3

create table empleado
(
id int not null primary key,
nombre varchar (50) not null,
salario money not null
)

create or alter trigger verificar_salario
on empleado
after insert, update
as
begin
if exists(select 1 from inserted) and not exists(select 1 from deleted)
begin
declare @salarioNuevo money
set @salarioNuevo = (select salario from inserted)
if @salarioNuevo > 50000
begin
raiserror('El salario es mayor a 50 mil y no esta permitido',16,1)
rollback transaction;
end
end
end;


/*
EXAMEN:
Crear un store procedure que permita gestionar una venta, en la cual se debe actualizar la existencia de producto vendido, 
bajo las siguientes condiciones

1)verificar si la existencia es suficiente, si la existencia no es suficiente cancelas la inserccion
2)si es suficiente, agregar la venta y disminuir el stock del producto
*/

/*
1)insertar en orders
2)insertar en orderdetails
3)verificar si el unitsinstock es  suficiente
4)si es suficiente aceptar la insercion y disminuir el unitsinstock lo vendido
*/


use Northwind

create or alter trigger gestionar_venta
on 
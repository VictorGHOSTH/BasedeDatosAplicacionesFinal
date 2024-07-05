--funciones de fecha

--seleccionar todos los años , dias mes y cuatrimestre de las ordenes 
use Northwind

select GETDATE()

--Funcion que devulve alguna parte de una fecha
select DATEPART(year, orderdate) as 'Anio', 
DATEPART(month, orderdate) as 'mes',
DATEPART(quarter, orderdate) as 'Trimestre',
DATEPART(week, orderdate) as 'Semana',
DATEPART(day, orderdate) as 'Dia',
DATEPART(weekday, orderdate) as 'Dia de la semana',
DATEPART(yy,orderdate) as 'anio 2'
from orders;

--Funcion que regresa el nombre de un mes o dia etc
select DATENAME(month, GETDATE()) as mes 

set LANGUAGE spanish

SELECT DATENAME(month, GETDATE()) as mes, DATENAME(day, GETDATE()) as dia 

--Funcion para obtener la diferencia entre anio, meses, dias, etc
select DATEDIFF(year,'1983-04-06', GETDATE()) as 'Tiempo de vejez'

--seleccionar el numero de dias trancurridos entre la fecha de pedido y la fecha de entrega
select orderid, orderdate ,DATEDIFF(day, orderdate, shippeddate) as 'Dias trancurridos' from orders;
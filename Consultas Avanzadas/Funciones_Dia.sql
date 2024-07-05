--funciones de fecha

--seleccionar todos los años , dias mes y cuatrimestre de las ordenes 
use Northwind

select GETDATE()

select DATEPART(year, '2024-06-06') as 'Anio', 
DATEPART(month, '2024-06-06') as 'mes',
DATEPART(quarter, '2024-06-06') as 'Trimestre',
DATEPART(week, '2024-06-06') as 'Semana',
DATEPART(day, '2024-06-06') as 'Dia',
DATEPART(weekday, '2024-06-06') as 'Dia de la semana'
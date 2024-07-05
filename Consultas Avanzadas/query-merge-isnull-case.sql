use AdventureWorks2019;

--codigo normal
select productnumber, [name],productline,
    case productline
      when 'R' then 'Road'
      when 'M' then 'MOuntain'
      when 'T' then 'Touring'
      when 'S' then 'Other sale items'
      else 'not for sale' 
      end as [category]
from Production.Product
where productline in ('R','M');

--creacion de la vista
create view v_reporte_productos
as
select productnumber, [name],productline,
    case productline
      when 'R' then 'Road'
      when 'M' then 'MOuntain'
      when 'T' then 'Touring'
      when 'S' then 'Other sale items'
      else 'not for sale' 
      end as [category]
from Production.Product
where productline in ('R','M');

select * from 
v_reporte_productos

select productnumber as 'numeroproducto',
[name] as 'nombre producto',
[category] = case productline
      when 'R' then 'Road'
      when 'M' then 'MOuntain'
      when 'T' then 'Touring'
      when 'S' then 'Other sale items'
      else 'not for sale'
    end, ListPrice as 'precio',
    case 
    when ListPrice = 0.0 then 'Mfg item - not for resale' 
    when ListPrice < 50.0 then 'under $50'
    when ListPrice >= 50.0 and ListPrice <250.0 then 'under $250'
    when ListPrice >= 250.0 and listPrice <1000 then 'under $1000'
    else 'over $1000'
    end as [price range]
from 
Production.Product;

--isnull (funcion)
select v.AccountNumber, v.name,
isnull (v.PurchasingWebServiceURL, 'no url')  as 'sitio web'
from 
[Purchasing].[Vendor] as v



--iif (funcion)
select iif(1 = 1, 'verdadero', 'falso') as 'resultado'

select iif(LEN('sql server')=10, 'ok', 'no ok') as 'respuesta'

select e.LoginID,e.JobTitle,e.Gender, iif(E.Gender = 'M', 'Hombre', 'Mujer') as 'Genero'
from HumanResources.Employee as e;


--funcion merge
select OBJECT_ID(N'tempdb..#StudentsC1')

IF OBJECT_ID (N'tempdb..#StudentsC1') is not NULL
begin
    drop table #StudentsC1;
end

CREATE TABLE #StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)

--sintaxis
declare @x int 
set @x = 10
if @x = 12
begin 
print('son iguales')
end 
else 
begin 
print ('no son iguales
end ')

--Segundo
IF OBJECT_ID(N'tempdb..#StudentsC2') is not NULL
begin
drop table #StudentsC2
END


CREATE TABLE #StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);


INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)

select * from #StudentsC2
select * from #StudentsC1


insert into #StudentsC2
select s1.StudentID, s1.StudentName, s1.StudentStatus
from #StudentsC1 as s1
inner join #StudentsC2 as s2
on s1.StudentID = s2.StudentID
where s2.StudentID is null

select count(*) #StudentsC2

select * from 
#StudentsC1 as s1
inner join #StudentsC2 as s2
on s1.StudentID = s2.StudentID

update s2
set 
s2.StudentName = s1.StudentName,
s2.StudentStatus = s1.StudentStatus
from
#StudentsC1 as s1
inner join #StudentsC2 as s2
on s1.StudentID = s2.StudentID;










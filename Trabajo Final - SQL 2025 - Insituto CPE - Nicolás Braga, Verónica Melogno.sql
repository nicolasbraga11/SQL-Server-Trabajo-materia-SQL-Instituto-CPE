-- Ejercicio 4)
select ProductID, Name
from Production.Product 
where ListPrice between 51 and 401
and Color in ('Blue','Black')
and Size in ('M','XL')
and Name not like '%Classic%'
order by ListPrice desc

-- Ejercicio 5)
--Contamos cuantos empleados hay 
Select count(NationalIDNumber) as "Cantidad de Empleados"
from HumanResources.Employee
--Unimos las tablas para obtener todas las columnas necesarias y poder aplicar las condiciones
select FirstName Nombre, LastName Apellido, BirthDate 'Fecha de Nacimiento', 
EmailAddress 'Casilla de Mail', DateDiff(Year, BirthDate, getdate()) 'Edad Empleado'
from Person.Person P
join Person.EmailAddress EA on P.BusinessEntityID=EA.BusinessEntityID
join HumanResources.Employee E on E.BusinessEntityID=P.BusinessEntityID
where DateDiff(Year, BirthDate, getdate()) between 48 and 52
and EmailAddress is not null
and MaritalStatus='M'
order by Apellido 

-- Ejercicio 6)
select P.Name, PC.Name
from Production.Product P 
join Production.ProductSubcategory PS on PS.ProductSubcategoryID=P.ProductSubcategoryID
join Production.ProductCategory PC on PC.ProductCategoryID=PS.ProductCategoryID
left join Sales.SalesOrderDetail as SOD on SOD.ProductID=P.ProductID
where sod.SalesOrderID is null

--Ejercicio 7
select BusinessEntityID 'ID de persona', sum(TotalDue) 'Total a pagar', count(OrderQty) as 'Cantidad de órdenes'
from Sales.SalesOrderHeader SOH
join Sales.SalesOrderDetail SOD on SOH.SalesOrderID=SOD.SalesOrderID
join Sales.Customer C on C.CustomerID= SOH.CustomerID
join Person.Person P on P.BusinessEntityID=C.PersonID
where OrderQty >= 10
and Year(OrderDate)=2004
group by BusinessEntityID
order by [Total a pagar] desc

--Ejercicio 8
select *
from( 
Select
case when JobTitle like 'Chief%' or JobTitle like '%Vice President%' then'Alta Gerencia'
when JobTitle like '%Manager%' or JobTitle like '%Supervisor%' then 'Mandos Medios' 
when JobTitle like '%Senior%' then 'Empleados Senior'
else'Empleados' end as 'Jerarquia',
COUNT(JobTitle) as 'Cantidad'
from HumanResources.Employee
GROUP BY 
case when JobTitle like 'Chief%' or JobTitle like'%Vice President%' then 'Alta Gerencia'
when JobTitle like '%Manager%' or JobTitle like'%Supervisor%' then 'Mandos Medios'
when JobTitle like '%Senior%' then 'Empleados Senior'
else 'Empleados' END) as SegunJerarquia
ORDER BY  
  Case Jerarquia when 'Alta Gerencia' then 1 
  when 'Mandos Medios' then 2 
  when 'Empleados Senior' then 3
  else 4
  END;

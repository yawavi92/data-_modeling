

-- all the employees how are person
select  hre.BusinessEntityID, hre.JobTitle, hre.BirthDate
from AdventureWorks2016.HumanResources.Employee hre  
where BusinessEntityID in (select BusinessEntityID from AdventureWorks2016.Person.Person) 


-- all BusinessEntityID,  FirstName, LastName the person how are not employees 
select BusinessEntityID,  FirstName, LastName
from  AdventureWorks2016.Person.Person pp
where BusinessEntityID not in (select hre.BusinessEntityID from AdventureWorks2016.HumanResources.Employee hre)


-- all BusinessEntityID,  FirstName, LastName the person how are employee but how are not salesperson
select BusinessEntityID,  FirstName, LastName
from  AdventureWorks2016.Person.Person pp
where BusinessEntityID in (select hre.BusinessEntityID from AdventureWorks2016.HumanResources.Employee hre) and
								BusinessEntityID not in (select sp.BusinessEntityID from [AdventureWorks2016].[Sales].[SalesPerson] sp) 


--get me businessentityID, firstname, lastname, jobtitle, birth of all the employees are person but who are  not salespersons
-- USING DERIVED TABLE
select t.businessentityID, t.firstname, t.lastname, hre.jobtitle, hre.BirthDate
from (select businessentityID, firstname, lastname from  [Person].[Person] p
			where p.businessentityID  in ( select businessentityID from [HumanResources].[Employee] hre
					where businessentityID not in ( select sp.businessentityID from [Sales].[SalesPerson]  sp))) t
			inner join [HumanResources].[Employee] hre
			on hre.businessentityID = t.businessentityID


--- get me businessentityID, firstname, lastname, jobtitle, hiredate, bonus of all the employees who are persons and who are  salesperson that has middlename
select dt.BusinessEntityID, dt.JobTitle,  pp.firstname,pp.LastName, pp.middlename, sp.bonus, dt.hiredate
from (
	select BusinessEntityID, JobTitle, hiredate
	from [AdventureWorks2016].HumanResources.Employee 
where BusinessEntityID in (select BusinessEntityID from [AdventureWorks2016].[Person].[Person]  where middlename is not null) and   
	  BusinessEntityID in (select BusinessEntityID from [AdventureWorks2016].[Sales].[SalesPerson] )) dt
		inner join [AdventureWorks2016].[Person].[Person] pp
		on dt.BusinessEntityID = pp.BusinessEntityID
		inner join [AdventureWorks2016].[Sales].[SalesPerson] sp
		on dt.BusinessEntityID = sp.BusinessEntityID


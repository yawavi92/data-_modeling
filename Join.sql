
-- get BusinessEntityID, JobTitle, firstname , lastname, birthdate in 107 style format of all employees who are persons

select e.BusinessEntityID, e.JobTitle, p.firstname , p.lastname, convert(varchar(20), e.birthdate, 107) birthdate
from [AdventureWorks2016].[HumanResources].[Employee] e
inner join [AdventureWorks2016].[Person].[Person] p
on e.[BusinessEntityID] = p.[BusinessEntityID]

-- get BusinessEntityID, firstname , MiddleName, lastname of all persons who is not in human resources, in this case we select only from person table

 select e.BusinessEntityID, e.JobTitle, e.birthdate
from [AdventureWorks2016].[HumanResources].[Employee] e
left join [AdventureWorks2016].[Person].[Person] p					
on e.[BusinessEntityID] = p.[BusinessEntityID]
where p.[BusinessEntityID] is  null

-- Get BusinessEntityID, firstname ,  lastname, ADDRES, CITY, STATE NAME, POSTAL CODE of all employees who are persons

select E.BusinessEntityID, P.firstname ,  P.lastname, CONCAT ( pa.[AddressLine1], ' ',  pa.[AddressLine2] ) as  address, pa.CITY, s.NAME, pa.POSTALCODE
from [AdventureWorks2016].HumanResources.Employee e
inner join AdventureWorks2016.person.person p
on e.BusinessEntityID = p.BusinessEntityID
inner join AdventureWorks2016.Person.BusinessEntity b
on e.BusinessEntityID = b.BusinessEntityID
inner join AdventureWorks2016.Person.BusinessEntityAddress ba
on b.BusinessEntityID = ba.BusinessEntityID
inner join AdventureWorks2016.Person.Address pa
on ba.[AddressID] = pa.[AddressID]
INNER JOIN [Person].[StateProvince] s
on s.[StateProvinceID] = pa.StateProvinceID

-- get BusinessEntityID, firstname ,  lastname, ADDRES, CITY, STATE NAME, POSTAL CODE all the persons who are not employees and who has has address

select pp.BusinessEntityID, pp.firstname ,  pp.lastname, CONCAT ( pa.[AddressLine1], ' ',  pa.[AddressLine2] ) as  address, pa.CITY, psp.NAME, pa.POSTALCODE
from [AdventureWorks2016].HumanResources.Employee hre
right outer join AdventureWorks2016.person.person pp
on hre.BusinessEntityID = pp.BusinessEntityID
inner join AdventureWorks2016.Person.BusinessEntity pbe
on pp.BusinessEntityID = pbe.BusinessEntityID
inner join AdventureWorks2016.Person.BusinessEntityAddress pbea
on pbea.BusinessEntityID = pbe.BusinessEntityID
inner join AdventureWorks2016.Person.Address pa
on pbea.[AddressID] = pa.[AddressID]
inner JOIN [Person].[StateProvince] psp
on psp.[StateProvinceID] = pa.StateProvinceID
where hre.BusinessEntityID is null

-- get all the persons who are not employees and who don't have address

 select PP.BusinessEntityID 
	from Adventureworks2016.HumanResources.Employee HRE
	  right outer join Adventureworks2016.Person.Person PP
	    on HRE.BusinessEntityID = PP.BusinessEntityID 
	  inner join Adventureworks2016.Person.BusinessEntity PBE
	    on PP.BusinessEntityID = PBE.BusinessEntityID 
	  left outer join Adventureworks2016.Person.BusinessEntityAddress PBEA
	    on PBE.BusinessEntityID = PBEA.BusinessEntityID 
	where HRE.BusinessEntityID is null and
	      PBEA.BusinessEntityID is null  


--- get all the persons who are not employees and has more than one address
select pp.BusinessEntityID,  count(pp.BusinessEntityID) as numberofaddress
from [AdventureWorks2016].HumanResources.Employee hre
right outer join AdventureWorks2016.person.person pp
on hre.BusinessEntityID = pp.BusinessEntityID
inner join AdventureWorks2016.Person.BusinessEntity pbe
on pp.BusinessEntityID = pbe.BusinessEntityID
inner join AdventureWorks2016.Person.BusinessEntityAddress pbea
on pbea.BusinessEntityID = pbe.BusinessEntityID
where hre.BusinessEntityID is null
group by pp.BusinessEntityID
having count(pp.BusinessEntityID) >1

/*Get me BusinessEntityID, FirstName, LastName, Address, City, State Name, Postal Code of all the Persons who 
		 are NOT employees and who has or who dont have address */  
			            

   select PP.BusinessEntityID, PP.FirstName,  PP.LastName, 
          iif(concat(PA.AddressLine1,' ',PA.AddressLine2) = ' ','NOT AVAILABLE', concat(PA.AddressLine1,' ',PA.AddressLine2)) Address,
		       isnull(PA.City,'NOT AVAILABLE') City,  isnull(PSP.Name,'NOT AVAILABLE') StateName, isnull(PA.PostalCode,'NOT AVAILABLE') PostalCode
		from Adventureworks2016.HumanResources.Employee HRE
		  right outer join Adventureworks2016.Person.Person PP
		     on HRE.BusinessEntityID = PP.BusinessEntityID 
		  inner join Adventureworks2016.Person.BusinessEntity PBE
		     on PP.BusinessEntityID = PBE.BusinessEntityID
		  left outer join Adventureworks2016.Person.BusinessEntityAddress PBEA
		     on PBE.BusinessEntityID = PBEA.BusinessEntityID 
		  left outer join Adventureworks2016.Person.Address PA
		     on PBEA.AddressID = PA.AddressID 
		 left outer join Adventureworks2016.Person.StateProvince PSP
		     on PA.StateProvinceID = PSP.StateProvinceID 
	where HRE.BusinessEntityID is null
	order by 1

---get me businessentityid, jobtitle, middlename, lastname, fullname of employees who are persons and are salesperson

select hre.BusinessEntityID, hre.JobTitle,pp.firstname, pp.middlename, pp.lastname, concat(pp.FirstName, ' ', pp.middlename,' ', pp.lastname) fullname
from [AdventureWorks2016].HumanResources.Employee hre
inner join [AdventureWorks2016].[Person].[Person] pp
on pp.BusinessEntityID = hre.BusinessEntityID
inner join [AdventureWorks2016].[Sales].[SalesPerson] sp
on sp.BusinessEntityID = pp.BusinessEntityID

-----get me businessentityid, jobtitle, middlename, lastname, fullname of persons  who are employees  but are not salesperson
select hre.BusinessEntityID, hre.JobTitle, pp.firstname, pp.lastname, concat(firstname,' ', pp.lastname) fullname
from [AdventureWorks2016].HumanResources.Employee hre
inner join [AdventureWorks2016].[Person].[Person] pp
on pp.BusinessEntityID = hre.BusinessEntityID
left join [AdventureWorks2016].[Sales].[SalesPerson] sp
on sp.BusinessEntityID = pp.BusinessEntityID
where sp.BusinessEntityID is null

-- get me businessentityid, jobtitle, middlename, lastname, fullname of persons  who are employees  but are not salesperson with sales.person table first
select hre.BusinessEntityID, hre.JobTitle, pp.firstname, pp.lastname, concat(firstname,' ', pp.lastname) fullname
from [AdventureWorks2016].[Sales].[SalesPerson] sp
right join [AdventureWorks2016].HumanResources.Employee hre
on sp.BusinessEntityID = hre.BusinessEntityID
inner join [AdventureWorks2016].[Person].[Person] pp
on hre.BusinessEntityID = pp.BusinessEntityID
where sp.BusinessEntityID is null


-- select where jobtitle is engineering manager  and tool designer
select BusinessEntityID, JobTitle, BirthDate 
from [HumanResources].[Employee]
where JobTitle in ('Engineering manager', 'Tool Designer')


-- select BusinessEntityID, BirthDate, JobTitle WHERE BusinessEntityID between 100 AND 200
select BusinessEntityID, BirthDate, JobTitle
from [HumanResources].[Employee]
where BusinessEntityID between 100 AND 200

-- select BusinessEntityID, BirthDate, JobTitle  between range of date of birth
select BusinessEntityID, BirthDate, JobTitle
from [HumanResources].[Employee]
where BirthDate BETWEEN '1980-01-01' AND '2010-12-31'

-- get BusinessEntityID, BirthDate, JobTitle with job title starting between c and g
select BusinessEntityID, BirthDate, JobTitle
from [HumanResources].[Employee]
where JobTitle BETWEEN 'c' AND 'g'

-- another may to do this 

select BusinessEntityID, BirthDate, JobTitle
from [HumanResources].[Employee]
where JobTitle like '[c-g]%'

--get me BusinessEntityID, BirthDate, JobTitle of all employees who jobtitle starts with E
 select BusinessEntityID, BirthDate, JobTitle 
 from [HumanResources].[Employee]
 where JobTitle like 'e%' 

--get me  BusinessEntityID, BirthDate, JobTitle  of all employees who has at least one 'e' anywhere in their jobtitle 
 select BusinessEntityID, BirthDate, JobTitle 
 from [HumanResources].[Employee]
 where JobTitle like '%e%'

 -- get me the BusinessEntityID, BirthDate, JobTitle  of all employees whos jobtitle's 3th character from the begining is 'r'
 select BusinessEntityID, BirthDate, JobTitle 
 from [HumanResources].[Employee]
 where JobTitle like '__r%'

 -- get me the BusinessEntityID, BirthDate, JobTitle  of all employees whos jobtitle's 4th character from the begining is 'k' and 5th character form last is 'a'
 select BusinessEntityID, BirthDate, JobTitle 
 from [HumanResources].[Employee]
 where JobTitle like '___k%' and JobTitle like  '%a____'


--get me  BusinessEntityID, BirthDate, JobTitle  of all employees who has no 'e' in their jobtitle 
 select BusinessEntityID, BirthDate, JobTitle 
 from [HumanResources].[Employee]
 where JobTitle not like '%e%'

 
 --get me  BusinessEntityID, BirthDate, JobTitle  of all employees who has at most  three 'a'  in their jobtitle 
 select BusinessEntityID, BirthDate, JobTitle 
 from [HumanResources].[Employee]
 where JobTitle not like '%a%a%a%a%' 

 --get get the employee who lastname do not start with a to g and end with s
 
  select  LastName
  from [Person].[Person]
  where   lastname  like '[^a-g]%s'

-- get the employee who lastname do not start with a to g and the second character from the begining must be either 'a or 'b and should end with s 
  select  LastName
  from [Person].[Person]
  where   lastname like '[^a-g][ab]%s' 

  --get me  BusinessEntityID, BirthDate, JobTitle  of all employees who has at least one '%' anywhere in their jobtitle 
 select BusinessEntityID, BirthDate, JobTitle 
 from [HumanResources].[Employee]
 where JobTitle like '%b%%' escape 'b' 

--get me all employees who has at least one '_' anywhere in their jobtitle
select  LastName
from [Person].[Person]
where   lastname like '%b_%' escape 'b'

 --get me  BusinessEntityID, BirthDate, JobTitle  of all employees who has at least 2 '%' anywhere in their jobtitle and end with underscore 
select  LastName
from [Person].[Person]
where   lastname like '%+%%+%%+_' escape '+' 

 -- another way to do this
select  LastName
from [Person].[Person]
where   lastname like '%[%]%[%]%[_]'

-- get the employee who has at leat ' anythere in their last name, apostriphe is wildcard for the server
  select  LastName
  from [Person].[Person]
  where   lastname like '%''%' 

 -- get the employee who has at leat two apostrophe anythere in their last name, apostriphe is wildcard for the server
 select  LastName
  from [Person].[Person]
  where   lastname like '%''%''%'

 -- get all the emplyees whos lastname is enclosed in apostrophe like 'lane'.
select  LastName
 from [Person].[Person]
  where   lastname like '''%'''

  
-- get the fullname using
  select  BusinessEntityID, FirstName, MiddleName, lastname,  concat(firstname, ' ',  MiddleName, ' ' , lastname) as fullname
  from [Person].[Person]

-- get the fullname using but + sign prevent extrat space if the middlename is null, 
  select  BusinessEntityID, FirstName, MiddleName, lastname,  concat(firstname, ' '+ MiddleName, ' ' , lastname) as fullname
  from [Person].[Person]

--get me the processing time of each orders to process in the facility and arrange it from worst to best
select  [SalesOrderID]  , [OrderDate]  ,[ShipDate] , DATEDIFF(day, [OrderDate], [ShipDate]) as responsetime
from AdventureWorks2016.[Sales].[SalesOrderHeader]
order by responsetime desc -- everything come after order by is called sorting predicates

-- get this formating : monday 18, 2022 (Apr 18 22)
select  [SalesOrderID], [OrderDate]  ,[ShipDate] , DATEDIFF(day, [OrderDate], [ShipDate]) as responsetime, 
			datename(dw, [OrderDate]) + ' ' + cast(day([OrderDate]) as varchar(2))  + ',' + 
			cast(year([OrderDate]) as varchar(4)) +  ' (' + left (datename(month,[OrderDate]), 3) + ' '+ cast(day([OrderDate]) as varchar(2))+ 
			' ' + right(cast(year([OrderDate]) as varchar(4)), 2)+ ')'  orderdatenew
from AdventureWorks2016.[Sales].[SalesOrderHeader]
order by responsetime desc

-- get me initial of all the person who has a middlename and arrange the dataset in the sorted order of the 3rd of their firstname */
select BusinessEntityID, FirstName, LastName, concat(left(FirstName, 1), '.', LEFT([MiddleName], 1) , '.', left(LastName, 1)) initial
from AdventureWorks2016.person.Person
where [MiddleName] is not null
order by substring(firstname, 3,1)

-- ckeck if leap year or not 
select iif(day(EOMONTH ([OrderDate])) = 28 ,'not a leap year', 'a leap year') as year
from AdventureWorks2016.[Sales].[SalesOrderHeader]

-- clean whitespace inside string
select CONCAT(left('san    Diego', charindex(' ','san    Diego', 1)-1) , ' '  ,  reverse(left(reverse('san    Diego'), charindex(' ', reverse('san    Diego'),1) -1)))
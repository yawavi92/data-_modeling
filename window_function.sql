
-- what is ranking function
/*
-a ranking function does as it name suggest, assings as numericaL rank to each row 
-every ranking function must have an over clause 
-over clause must be followed by an order by clause
-A partition by clause can be included

use 
-assign integer values where there were none
-visually allowing you to view data and see what ranks top to bottom
-rank and dense rank can be used for assinging placement in sports
-removing dulpicate values from a table or data set 

ranking function canbe used with the method
- using a derived table, we can create a temp result and delete rows
-using a view we can create a permanent virtual table and simply delete from it

types of ranking functions
-row_number() : given each row a sequential number depending on the order and partition 
-rank() : give each row a number duplicates will be given the same number and the next will be skipped 
-dense_rank() like rank but don't skipped :  give each row a number duplicates will be given the same numbers,but the next numbers won't skip
-Ntile() : will distribute rwos into group depending on number provided, we have to specified the number inside the function what 
will 

*/

-- get the fifth highest total sale
 select DT.*
 from (
  select dense_rank()over(order by TotalDue desc) DRank, *
  from Adventureworks2016.Sales.SalesOrderHeader ) DT
 where DT.DRank = 5

---  /* Get me the total figure of sales <TotalDue amount> for each month of year 2012 based on OrderDate */
   
select dt.monthname, dt.year, dt.SalesOrderID, dt.TotalDue
from(
select rank() over(partition by  month(orderdate) order by totaldue desc) rnk, 
datename(Month, [OrderDate])  monthname, year([OrderDate]) year, [SalesOrderID], [TotalDue]
from [AdventureWorks2016].[Sales].[SalesOrderHeader]
where year(OrderDate) = 2012) dt
where dt.rnk = 1

 /* Get me the SalesOrderID, TotalDue of the maximum TotalDue amount for each month of year 2006 based on OrderDate */

   select month(OrderDate) MonthNumber, datename(month,Orderdate) MonthName, year(OrderDate) Year, Sum(TotalDue) TotalSales
   from AdventureWorks2016.Sales.SalesOrderHeader  
   where year(OrderDate) = 2012
   group by datename(month,Orderdate), month(OrderDate), year(OrderDate)
   order by 1

-- get the highest total month sale in 2012

select dt.monthname, dt.year, dt.SalesOrderID, dt.TotalDue
from(
select rank() over( order by totaldue desc) rnk, 
datename(Month, [OrderDate])  monthname, year([OrderDate]) year, [SalesOrderID], [TotalDue]
from [AdventureWorks2016].[Sales].[SalesOrderHeader]
where year(OrderDate) = 2012) dt
where dt.rnk = 1


-- get the row number
select dt.monthname, dt.year, dt.SalesOrderID, dt.TotalDue
from(
select row_number() over( partition by month([OrderDate]) order by totaldue desc) rnk, 
datename(Month, [OrderDate])  monthname, year([OrderDate]) year, [SalesOrderID], [TotalDue]
from [AdventureWorks2016].[Sales].[SalesOrderHeader]) dt

-- make 10 groups of tax amount 
select ntile(10)over(order by [TaxAmt] desc) as groups , [SalesOrderID] , [TaxAmt]
from AdventureWorks2016.Sales.SalesOrderHeader
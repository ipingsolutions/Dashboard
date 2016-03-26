
Create procedure spIncomeStatementTest as 
Declare @StartDate datetime,
	@EndDate datetime,
	@BookType varchar(255),	
	@SubAssetKey varchar(255),
	@AcctTree varchar(25)


Set @StartDate='01/01/2015'
SET @EndDate='12/31/2015'


select
DateName(Month,cd.CalendarDate) as Month,cd.CalendarDate,dm.MetricName,da.AccountCode,da.AccountDescription,sum(glpb.AccountBalance) Amount
--,EOMONTH(cd.CalendarDate) as MonthEnd
from Accounting.MetricAccount ma
Join Accounting.DimMetric dm on dm.MetricKey=ma.MetricKey
JOIN Accounting.DimAccount da On da.AccountKey=ma.AccountKey
JOIN Accounting.FactGLAcctPeriodBalance glpb  on glpb.Accountkey=da.accountkey
JOIN Global.DimCalendarDay cd On cd.Daykey=glpb.Postdatekey
Where MetricName in ('Revenue','Expense')
AND CalendarDate between @StartDate AND @EndDate AND cd.Calendardate>'12-31-2014'
Group by 
cd.CalendarDate,dm.MetricName,da.AccountCode,da.AccountDescription
Order by AccountCode
--select*from 
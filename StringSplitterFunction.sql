with cte as (
select 1 as rwn, 'USA;USA;UAE;CHINA' as cntry
union all
select rwn+1, 'USA;USA;UAE;CHINA' as cntry
from cte 
where rwn+1 <= 10
),
cte2 as (
select * from 
string_split('USA;USA;UAE;CHINA',';')
)

select distinct b.value from 
cte a cross apply 
string_split('USA;USA;UAE;CHINA',';') b

use [TestLearningDb]
create function stringSplitter(@inputValue varchar(500), @seprator varchar(20))
returns @outpytTable table (itemSlitted varchar(20))
as 
begin
 if substring(@inputValue,len(@inputValue),len(@inputValue)-1) != @seprator
	 begin
			set @inputValue = @inputValue+@seprator
	 end
 while(CHARINDEX(@seprator,@inputValue)>0)
	begin
	  insert into @outpytTable
	  select SUBSTRING(@inputValue,1,CHARINDEX(@seprator,@inputValue)-1)
	  set @inputValue = SUBSTRING(@inputValue,CHARINDEX(@seprator,@inputValue)+1,len(@inputValue))
	end
	
 return
end

select itemSlitted from dbo.stringSplitter('USA;USA;UAE;CHINA',';')

select DATEFROMPARTS(year('2012-03-25'),month('2012-03-25'),'1')

SELECT CHARINDEX('OM', 'Customer') AS MatchPosition;

select case when 'customer' like '%OM%' then 'Treu'
else null
end

SELECT DATALENGTH( cast('M' as char(30)));

SELECT DIFFERENCE('Juice', 'Jucy');

SELECT PATINDEX('%s%com%', 'W3Schools.com');

SELECT PATINDEX('%[ol]%', 'W3Schools.com');

SELECT QUOTENAME('abcdef','>');

SELECT REPLACE('ABC ABC ABC', 'a', 'c');

create function Ispalindrome(@inputString varchar(20))
returns  varchar(30)
as 
begin 
declare @ispland varchar(30)
 if @inputString = REVERSE(@inputString) 
 begin  
 set @ispland = 'Planindrome'
 end
 else 
 begin 
 set @ispland =  'NOT' end
return @ispland

end


select dbo.Ispalindrome('abcba')

SELECT RIGHT('CustomerName', 5) 
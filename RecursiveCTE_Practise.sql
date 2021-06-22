with cteTbl1 as 
(
select null rwn, null as   qnt,null as antt
union all
select 1 as rwn,1 as qnt,10 as antt
union all
select rwn, qnt+1 ,antt+1
from ctetbl1 
where qnt+1 <=3)
--use [TEST_DATABASE]
select * into CrossJoinTable from
cteTbl1 
--(select rwn from cteTbl1) 
a
cross join cteTbl1
--(select qnt from cteTbl1) 
b



create function findAge(@dob date) 
returns INT
as
begin
declare @age int;
set @age = datediff(year,@dob,getDate())-
case when month(@dob) < month(getDate()) then 1 else 0 end
return @age
end


create function udfSum(@dob int,@dob2 int) 
returns INT
as
begin
declare @age int;
set @age = @dob+@dob2
return @age
end

create or alter procedure udfSumProc @dob int,@dob2 int
@age int out
as
begin
declare @age int;
set @age = @dob+@dob2
end

declare @age int;
 exec udfSumProc 1,2,@age
print @age

select dbo.udfSum(1,2)

with cteTbl1 as 
(
select null rwn, null as   qnt,null as antt
union all
select 1 as rwn,1 as qnt,10 as antt
union all
select rwn, qnt+1 ,antt+1
from ctetbl1 
where qnt+1 <=3)

select * into CrossJoinTable from
cteTbl1 

select a.qnt,b.qnt from CrossJoinTable a
full outer join CrossJoinTable b
on a.qnt = b.qnt
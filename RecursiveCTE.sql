CREATE TABLE orderTable(
    orderID varchar(255),
	dummyID int)

CREATE TABLE ordProduct(
    productID varchar(255),
	ordID varchar(255),
	Quantity int)

insert into ordProduct values('PRD1','ORD1',1)
insert into ordProduct values('PRD2','ORD2',4)
insert into ordProduct values('PRD3','ORD3',3)



select * from ordProduct

 with cteExploded as 
 (
 select productID,ordID,1 as QuantityNew,1 as DecQuantity 
 from ordProduct
 union all 
 select b.productID,b.ordID,1 as QuantityNew, a.DecQuantity+1 as DecQuantity
 from cteExploded a
 inner join ordProduct b 
 on a.productID = b.productID and a.ordID = b.ordID and a.DecQuantity+1 <= b.Quantity
 )

 select * from cteExploded
 order by 1,2


 select *,
 sum(quantity) over( partition by productid order by quantity rows between unbounded preceding and current row),
 min(quantity) over( partition by productid order by quantity rows between unbounded preceding and current row),
 max(quantity) over( partition by productid order by quantity rows between unbounded preceding and current row),
 avg(quantity) over( partition by productid order by quantity rows between unbounded preceding and current row),
 sum(quantity) over( partition by productid order by productID),
 min(quantity) over( partition by productid order by productID),
 max(quantity) over( partition by productid order by productID),
 avg(quantity) over( partition by productid order by productID)


 from ordProduct
 order by 1,2,3

 drop table if exists #tempTable
 select ordID, string_agg(Quantity,';') within group(order by quantity) as AggQuant
 into #tempTable
  from ordProduct
  group by ordID
 order by 1,2

 SELECT  STRING_SPLIT(AggQuant,';')
 from #tempTable


 
with  cteTable as (
 select 1 as ValRow, 1 as rwn from string_split('20',',')
 union all 
 select 1 as ValRow, rwn+1 as rwn from 
 cteTable a inner join 
( select cast(value as int ) as Val from string_split('20',',')) b
on a.rwn +1 <= b.val),
ctePrime as 
(select distinct a.rwn,b.rwn as Brwn from cteTable a
inner join cteTable b on
 b.rwn>a.rwn and b.rwn%a.rwn=0 and a.rwn >1)


select distinct Brwn from ctePrime
order by 1
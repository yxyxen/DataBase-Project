-- How much does each driver earn (tips + delivery fee) in 2019?

select driverID, driverName, tips2019, deliveryFee2019, (tips2019 + deliveryFee2019) as earning2019
from (select *, sum(tip) as tips2019, sum(deliveryFee) as deliveryFee2019
	  from Orders natural join Driver
	  where orderDate between '2019-01-01' and '2019-12-31'
	  group by driverID) as od

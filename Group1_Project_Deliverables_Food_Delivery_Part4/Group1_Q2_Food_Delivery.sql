-- What percentage of orders is placed in usual meal hours? Assume usual meal hours are: 7:00 am - 8:00 am, 12:00 pm - 1:00 pm, 6:00 pm - 7:00 pm.
select *, (totalOrdersInMealHours / totalOrders * 100) as percentage
from (select count(orderID) as totalOrdersInMealHours
	  from Orders
	  where orderTime between '07:00:00' and '08:00:00'
			or orderTime between '12:00:00' and '13:00:00'
		    or orderTime between '18:00:00' and '19:00:00') as mho, (select count(orderID) as totalOrders from Orders) as o

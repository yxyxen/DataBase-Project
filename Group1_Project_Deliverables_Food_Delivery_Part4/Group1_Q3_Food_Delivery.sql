-- Which food generates the most income for each restaurant?
select restaurantID, foodID, foodName, totalIncomeFromThisFood
from (select *, sum(fo1.totalPriceOnThisFood) as totalIncomeFromThisFood
	  from (select *, (f1.foodPrice * fio1.quantity) as totalPriceOnThisFood
		    from FoodInOrder fio1 natural join Food f1) as fo1
	  group by restaurantID, foodID) as fr1
where fr1.totalIncomeFromThisFood >= all (select fr2.totalIncomeFromThisFood 
									      from (select *, sum(fo2.totalPriceOnThisFood) as totalIncomeFromThisFood
											    from (select *, (f2.foodPrice * fio2.quantity) as totalPriceOnThisFood
												      from FoodInOrder fio2 natural join Food f2) as fo2
											    group by restaurantID, foodID) as fr2 
									      where fr1.restaurantID = fr2.restaurantID)
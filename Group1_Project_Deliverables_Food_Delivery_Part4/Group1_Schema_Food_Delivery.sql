USE db_xiayu;

DROP TABLE IF EXISTS Customer;
create table Customer(
customerID varchar(10) primary key,
customerPhoneNum CHAR(10) not null,
customerName VARCHAR(100) not null,
customerAddress VARCHAR(100) not null
);

Insert into Customer(customerID,customerPhoneNum,customerName,customerAddress) 
Values ('C1','3191111111','Spider Man','11 Iowa Ave');
Insert into Customer(customerID,customerPhoneNum,customerName,customerAddress) 
Values ('C2','3192222222','Iron Man','22 Iowa Ave'); 
Insert into Customer(customerID,customerPhoneNum,customerName,customerAddress) 
Values ('C3','3193333333','Wonder Woman','33 Iowa Ave');
Insert into Customer(customerID,customerPhoneNum,customerName,customerAddress) 
Values ('C4','3194444444','Super Man','44 Iowa Ave');
Insert into Customer(customerID,customerPhoneNum,customerName,customerAddress) 
Values ('C5','3195555555','Ant Man','55 Iowa Ave');
Insert into Customer(customerID,customerPhoneNum,customerName,customerAddress) 
Values ('C6','3196666666','Bat Man','66 Iowa Ave');
Insert into Customer(customerID,customerPhoneNum,customerName,customerAddress) 
Values ('C7','3197777777','Captain Marvel','77 Iowa Ave');

CREATE INDEX Customer_idx ON Customer (customerID);

DROP TABLE IF EXISTS Restaurant;
create table Restaurant(
restaurantID VARCHAR(10) primary key,
restaurantPhoneNum CHAR(10) not null,
restaurantAddress VARCHAR(100) not null,
restaurantBankAccountNumber VARCHAR(20) references BankAccount(accountNumber)
);

Insert into Restaurant(restaurantID,restaurantPhoneNum,restaurantAddress,restaurantBankAccountNumber)
Values ('R1','3190001111','1 Capitol Street','4444444444');
Insert into Restaurant(restaurantID,restaurantPhoneNum,restaurantAddress,restaurantBankAccountNumber)
Values ('R2','3190002222','2 Capitol Street','5555555555');
Insert into Restaurant(restaurantID,restaurantPhoneNum,restaurantAddress,restaurantBankAccountNumber)
Values ('R3','3190003333','3 Capitol Street','6666666666');

CREATE INDEX Restaurant_idx ON Restaurant (restaurantID);

DROP TABLE IF EXISTS Food;
create table Food(
foodID VARCHAR(10) primary key,
restaurantID VARCHAR(10) not null,
foodName VARCHAR(50) not null,
foodPrice DECIMAL(10,2) not null               
);

Insert into Food(foodID,restaurantID,foodName,foodPrice)
Values ('F1','R1','Burger','5.99');
Insert into Food(foodID,restaurantID,foodName,foodPrice)
Values ('F2','R1','Fries','3.99');
Insert into Food(foodID,restaurantID,foodName,foodPrice)
Values ('F3','R1','Pizza','8.99');
Insert into Food(foodID,restaurantID,foodName,foodPrice)
Values ('F4','R2','Mac&cheese','8.99');
Insert into Food(foodID,restaurantID,foodName,foodPrice)
Values ('F5','R2','Spagetti','8.99');
Insert into Food(foodID,restaurantID,foodName,foodPrice)
Values ('F6','R2','Fried Rice','7.99');
Insert into Food(foodID,restaurantID,foodName,foodPrice)
Values ('F7','R3','Udon','7.99');
Insert into Food(foodID,restaurantID,foodName,foodPrice)
Values ('F8','R3','Chili Soup','3.99');

CREATE INDEX Food_idx ON Food (foodID);

DROP TABLE IF EXISTS BankAccount;
create table BankAccount (
accountNumber VARCHAR(20) primary key,
accountType VARCHAR(10) not null,
bankName VARCHAR(50) not null,
routingNumber CHAR(9) not null
);
 
Insert into BankAccount(accountNumber,accountType,bankName,routingNumber)
Values ('1111111111','Checking','B1','666666111');
Insert into BankAccount(accountNumber,accountType,bankName,routingNumber)
Values ('2222222222','Saving','B2','666666222');
Insert into BankAccount(accountNumber,accountType,bankName,routingNumber)
Values ('3333333333','Checking','B3','666666333');
Insert into BankAccount(accountNumber,accountType,bankName,routingNumber)
Values ('4444444444','Checking','B1','666666111');
Insert into BankAccount(accountNumber,accountType,bankName,routingNumber)
Values ('5555555555','Saving','B2','666666222');
Insert into BankAccount(accountNumber,accountType,bankName,routingNumber)
Values ('6666666666','Saving','B3','666666333');

CREATE INDEX BankAccount_idx ON BankAccount (accountNumber);

DROP TABLE IF EXISTS Driver;
create table Driver(
driverID VARCHAR(10) primary key,
driverName VARCHAR(100) not null,
driverPhoneNum CHAR(10) not null,
driverBankAccountNumber VARCHAR(20) references BankAccount(accountNumber)
); 

Insert into Driver(driverID,driverName,driverPhoneNum,driverBankAccountNumber)
Values ('D1','Mickey Mouse','3191110000','1111111111');
Insert into Driver(driverID,driverName,driverPhoneNum,driverBankAccountNumber)
Values ('D2','Miney Mouse','3192220000','2222222222');
Insert into Driver(driverID,driverName,driverPhoneNum,driverBankAccountNumber)
Values ('D3','Frank Underwood','3193330000','3333333333');

CREATE INDEX Driver_idx ON Driver (driverID);

DROP TABLE IF EXISTS CreditCard;
create table CreditCard(
CCNumber CHAR(16) primary key,
expDate CHAR(4) not null,
nameOnCard VARCHAR(100) not null
);

Insert into CreditCard(CCNumber,expDate,nameOnCard)
Values ('1111111111111111','1220','Iron Man');
Insert into CreditCard(CCNumber,expDate,nameOnCard)
Values ('2222222222222222','1220','Bat Man');
Insert into CreditCard(CCNumber,expDate,nameOnCard)
Values ('3333333333333333','1221','Wonder Woman');

CREATE INDEX CreditCard_idx ON CreditCard (CCNumber);

DROP TABLE IF EXISTS Orders;
create table Orders( 
orderID VARCHAR(10) primary key,
customerID VARCHAR(10) references Customer(customerID),
restaurantID VARCHAR(10) references Restaurant(restaurantID),
driverID VARCHAR(10) references Driver(driverID),
orderDate DATE,
orderTime TIME,
orderAddress VARCHAR(100) not null,
orderNotes VARCHAR(100),
isPaid BOOLEAN default FALSE,
isDelivered BOOLEAN default FALSE,
deliveryFee DECIMAL(10,2),
tip DECIMAL(10,2),
coupon DECIMAL(10,2),
CCNumber CHAR(16) references CreditCard(CCNumber),
restaurantRating DECIMAL(2,1) check (restaurantRating >= 0 and restaurantRating <= 5),
restaurantComment VARCHAR(100),
driverRating DECIMAL(2,1) check (driverRating >= 0 and driverRating <= 5),
driverComment VARCHAR(100)
);

Insert into Orders(orderID,customerID,restaurantID,driverID,orderDate,orderTime,orderAddress,orderNotes,isPaid,isDelivered,deliveryFee,tip,coupon,CCNumber,restaurantRating,restaurantComment,driverRating,driverComment)
Values ('O1','C1','R1','D1','2019-01-01','06:57:12.5','11 Iowa Ave',null,TRUE,TRUE,2.99,5,null,'1111111111111111',4.5,'Good',5,null);
Insert into Orders(orderID,customerID,restaurantID,driverID,orderDate,orderTime,orderAddress,orderNotes,isPaid,isDelivered,deliveryFee,tip,coupon,CCNumber,restaurantRating,restaurantComment,driverRating,driverComment)
Values ('O2','C2','R1','D2','2019-02-02','12:39:28.11','22 Iowa Ave','No onions',TRUE,TRUE,2.99,5,null,'1111111111111111',4.5,null,5,null);
Insert into Orders(orderID,customerID,restaurantID,driverID,orderDate,orderTime,orderAddress,orderNotes,isPaid,isDelivered,deliveryFee,tip,coupon,CCNumber,restaurantRating,restaurantComment,driverRating,driverComment)
Values ('O3','C3','R1','D3','2019-03-03','18:07:42.6','33 Iowa Ave',null,TRUE,TRUE,2.99,5,null,'1111111111111111',4.5,null,3,'Okay');
Insert into Orders(orderID,customerID,restaurantID,driverID,orderDate,orderTime,orderAddress,orderNotes,isPaid,isDelivered,deliveryFee,tip,coupon,CCNumber,restaurantRating,restaurantComment,driverRating,driverComment)
Values ('O4','C4','R2','D1','2019-04-04','17:20:01.7','44 Iowa Ave','Extra spicy',TRUE,TRUE,2.99,5,null,'2222222222222222',5,null,3,null);
Insert into Orders(orderID,customerID,restaurantID,driverID,orderDate,orderTime,orderAddress,orderNotes,isPaid,isDelivered,deliveryFee,tip,coupon,CCNumber,restaurantRating,restaurantComment,driverRating,driverComment)
Values ('O5','C5','R2','D2','2019-05-05','11:42:32.3','55 Iowa Ave',null,TRUE,TRUE,3.99,5,null,'2222222222222222',5,null,3,null);
Insert into Orders(orderID,customerID,restaurantID,driverID,orderDate,orderTime,orderAddress,orderNotes,isPaid,isDelivered,deliveryFee,tip,coupon,CCNumber,restaurantRating,restaurantComment,driverRating,driverComment)
Values ('O6','C1','R2','D3','2019-06-06','19:20:31.9','66 Iowa Ave',null,TRUE,TRUE,3.99,4,null,'2222222222222222',5,null,3,null);
Insert into Orders(orderID,customerID,restaurantID,driverID,orderDate,orderTime,orderAddress,orderNotes,isPaid,isDelivered,deliveryFee,tip,coupon,CCNumber,restaurantRating,restaurantComment,driverRating,driverComment)
Values ('O7','C6','R2','D1','2019-07-07','23:11:09.00','55 Iowa Ave',null,TRUE,TRUE,3.99,4,-10,'3333333333333333',2.5,null,4,null);
Insert into Orders(orderID,customerID,restaurantID,driverID,orderDate,orderTime,orderAddress,orderNotes,isPaid,isDelivered,deliveryFee,tip,coupon,CCNumber,restaurantRating,restaurantComment,driverRating,driverComment)
Values ('O8','C2','R3','D2','2019-08-08','00:40:20.22','66 Iowa Ave',null,TRUE,TRUE,3.99,4,-10,'3333333333333333',2.5,null,4,null);
Insert into Orders(orderID,customerID,restaurantID,driverID,orderDate,orderTime,orderAddress,orderNotes,isPaid,isDelivered,deliveryFee,tip,coupon,CCNumber,restaurantRating,restaurantComment,driverRating,driverComment)
Values ('O9','C7','R3','D3','2019-09-09','17:56:09.33','77 Iowa Ave',null,FALSE,FALSE,3.99,4,-10,'3333333333333333',2.5,null,4,null);
CREATE INDEX orderid_idx1 ON Orders (orderID);
CREATE INDEX orderid_idx2 ON Orders (orderDate);

DROP TABLE IF EXISTS FoodInOrder;
create table FoodInOrder(
orderID VARCHAR(10) references Orders(OrderID),
foodID VARCHAR(10) references Food(FoodID),
quantity INT default 1,
primary key (orderID, foodID)
);

Insert into FoodInOrder(orderID,foodID,quantity)
Values ('O1','F1',1);
Insert into FoodInOrder(orderID,foodID,quantity)
Values ('O2','F1',1);
Insert into FoodInOrder(orderID,foodID,quantity)
Values ('O2','F2',1);
Insert into FoodInOrder(orderID,foodID,quantity)
Values ('O3','F2',1);
Insert into FoodInOrder(orderID,foodID,quantity)
Values ('O4','F5',1);
Insert into FoodInOrder(orderID,foodID,quantity)
Values ('O5','F1',2);
Insert into FoodInOrder(orderID,foodID,quantity)
Values ('O5','F2',2);
Insert into FoodInOrder(orderID,foodID,quantity)
Values ('O5','F3',2);
Insert into FoodInOrder(orderID,foodID,quantity)
Values ('O6','F7',2);
Insert into FoodInOrder(orderID,foodID,quantity)
Values ('O7','F7',2);
Insert into FoodInOrder(orderID,foodID,quantity)
Values ('O8','F8',3);
Insert into FoodInOrder(orderID,foodID,quantity)
Values ('O9','F8',3);
CREATE INDEX FoodInOrder_idx ON FoodInOrder (orderID, foodID);

select * from Orders;
select * from Customer;
select * from Restaurant;
select * from Driver;
select * from BankAccount;
select * from CreditCard;
select * from Food;
select * from FoodInOrder;

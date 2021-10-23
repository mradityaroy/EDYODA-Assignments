CREATE DATABASE MYSQL_A_1;

USE MYSQL_A_1;



SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


----- creating SalesPeople table------


CREATE TABLE SalesPeople(
    Snum SMALLINT,
    Sname VARCHAR(20) NOT NULL,
    City VARCHAR(20) NOT NULL,
    Comm SMALLINT,
    PRIMARY KEY(Snum))
    ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;


----- inserting data into SalesPeople table------

    
INSERT INTO SalesPeople (`Snum`, `Sname`, `City`, `Comm`) VALUES
	(1001, 'Peel', 'London', 12),
	(1002, 'Serres', 'Sanjose', 13),
	(1003, 'Axelrod', 'Newyork', 10),
	(1004, 'Motika', 'London', 11),
	(1007, 'Rifkin', 'Barcelona', 15);
    
 
 ----- creating Customers table------
 
 
CREATE TABLE Customers (
  Cnum SMALLINT NOT NULL,
  Cname varchar(60) DEFAULT NULL,
  City varchar(60) NOT NULL,
  Snum SMALLINT DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


 ----- inserting data into Customers table------


INSERT INTO Customers (`Cnum`, `Cname`, `City`, `Snum`) VALUES
(2001, 'Hoffman', 'London', 1001),
(2002, 'Giovanni', 'Rome', 1003),
(2003, 'Liu', 'Sanjose', 1002),
(2004, 'Grass', 'Berlin', 1002),
(2006, 'Clemens', 'London', 1001),
(2007, 'Pereira', 'Rome', 1004),
(2008, 'Cisneros', 'Sanjose', 1007);


 ----- creating Orders table------


CREATE TABLE Orders (
  Onum SMALLINT NOT NULL,
  Amt float DEFAULT NULL,
  Odate date DEFAULT NULL,
  Cnum SMALLINT DEFAULT NULL,
  Snum SMALLINT DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

 ----- inserting data into Orders table------

INSERT INTO Orders (`Onum`, `Amt`, `Odate`, `Cnum`, `Snum`) VALUES
(3001, 18.69, '1990-10-03', 2008, 1007),
(3002, 1900.1, '1990-10-03', 2007, 1004),
(3003, 767.19, '1990-10-03', 2001, 1001),
(3005, 5160.45, '1990-10-03', 2003, 1002),
(3006, 1098.16, '1990-10-03', 2008, 1007),
(3007, 75.75, '1990-10-04', 2004, 1002),
(3008, 4273, '1990-10-05', 2006, 1001),
(3009, 1713.23, '1990-10-04', 2002, 1003),
(3010, 1309.95, '1990-10-06', 2004, 1002),
(3011, 9891.88, '1990-10-06', 2006, 1001);


 ----- indexing Customers table------

ALTER TABLE Customers
  ADD PRIMARY KEY (`Cnum`),
  ADD KEY `Snum` (`Snum`);

 ----- indexing Orders table------

ALTER TABLE Orders
  ADD PRIMARY KEY (`Onum`),
  ADD KEY `Cnum` (`Cnum`),
  ADD KEY `Snum` (`Snum`);

 ----- indexing SalesPeople table------

ALTER TABLE SalesPeople
  ADD UNIQUE KEY `Sname` (`Sname`);

 ----- constraints for Customers table------

ALTER TABLE Customers
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`Snum`) REFERENCES `salespeople` (`Snum`);


 ----- constraints for Orders table------

ALTER TABLE Orders
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Cnum`) REFERENCES `customers` (`Cnum`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`Snum`) REFERENCES `salespeople` (`Snum`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */; 
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


 ----- 1. Count the number of Salesperson whose name begin with ‘a’/’A’ ------


SELECT 
    COUNT(*)
FROM
   SalesPeople
WHERE Sname LIKE 'a%'
OR Sname LIKE 'A%';

----- 2. Display all the Salesperson whose all orders worth is more than Rs. 2000 ------

SELECT COUNT(*) 
FROM salespeople INNER JOIN orders on salespeople.Snum = orders.Snum WHERE Amt > 2000;

----- 3. Count the number of Salesperson belonging to Newyork. ------

SELECT 
    COUNT(*)
FROM
   salespeople
WHERE city = 'NewYork';

----- 4. Display the number of Salespeople belonging to London and belonging to Paris. ------

SELECT *
FROM salespeople
WHERE City =
(SELECT Sname 
     FROM salespeople 
     WHERE city= 'London' AND 'Paris');

----- 5. Display the number of orders taken by each Salesperson and their date of orders. ------
     
SELECT salespeople.Sname, 
orders.Odate 
FROM salespeople 
INNER JOIN orders ON salespeople.Snum = orders.Snum;
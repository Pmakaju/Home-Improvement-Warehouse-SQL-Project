spool 'C:\Users\pxm65\OneDrive\Desktop\Project2_pm.txt'	
-- Include the full path.  This will start logging to the specified file.

set echo on
-- This will ensure that all input and output is logged to the file.

-- Pradeep Makaju
-- INSY 3304-001
-- Project 2


DROP TABLE ORDERDETAIL_pxm ;
DROP TABLE ORDER_pxm ;
DROP TABLE CUSTOMER_pxm ;
DROP TABLE SALESREP_pxm ;
DROP TABLE PRODUCT_pxm ;
DROP TABLE COMMISSION_pxm ;
DROP TABLE DEPARTMENT_pxm ;
DROP TABLE PRODCAT_pxm ;

-- Part IA

CREATE TABLE PRODCAT_pxm 
(
ProdCatID 		NUMBER(5),
ProdCatName  	VARCHAR(20) NOT NULL,
PRIMARY KEY 	(ProdCatID)
) ;


CREATE TABLE DEPARTMENT_pxm 
(
DeptID 			NUMBER(5),
DeptName 		VARCHAR(15) NOT NULL,
PRIMARY KEY 	(DeptID)
) ;


CREATE TABLE COMMISSION_pxm (
CommClass 		CHAR(20),
CommRate 		NUMBER(3,2) NOT NULL,
PRIMARY KEY 	(CommClass)
) ;

CREATE TABLE PRODUCT_pxm (
ProdID 			NUMBER(5),
ProdName	 	VARCHAR(25) NOT NULL,
ProdCatID 		NUMBER(5) NOT NULL,
ProdPrice 		NUMBER(5,2) NOT NULL,
PRIMARY KEY 	(ProdID),
FOREIGN KEY 	(ProdCatID) REFERENCES PRODCAT_pxm
) ;

CREATE TABLE SALESREP_pxm (
SalesRepID 		NUMBER(5),
SalesRepFName 	VARCHAR(17) NOT NULL,
SalesRepLName 	VARCHAR(17) NOT NULL,
CommClass 		CHAR(20) NOT NULL,
DeptID 			NUMBER(5) NOT NULL,
PRIMARY KEY 	(SalesRepID),
FOREIGN KEY 	(CommClass) REFERENCES COMMISSION_pxm,
FOREIGN KEY 	(DeptID) REFERENCES DEPARTMENT_pxm
) ;

CREATE TABLE CUSTOMER_pxm (
CustID 			CHAR(7) NOT NULL,
CustFName 		VARCHAR(15) NOT NULL,
CustLName 		VARCHAR(15) NOT NULL,
CustPhone 		CHAR(10),
SalesRepID 		NUMBER(5) NOT NULL, 
PRIMARY KEY 	(CustID),
FOREIGN KEY 	(SalesRepID) REFERENCES SALESREP_pxm
) ;

CREATE TABLE ORDER_pxm (
OrderID 		NUMBER(5),
OrderDate 		DATE NOT NULL,
CustID 			CHAR(7) NOT NULL,
PRIMARY KEY 	(OrderID),
FOREIGN KEY 	(CustID) REFERENCES CUSTOMER_pxm
) ;


CREATE TABLE ORDERDETAIL_pxm (
OrderID 		NUMBER(5),
ProdID 			NUMBER(5) NOT NULL,
ProdQty 		NUMBER(5) NOT NULL,
ProdPrice 		NUMBER(5,2) NOT NULL,
PRIMARY KEY 	(OrderID, 	ProdID),
FOREIGN KEY 	(OrderID) REFERENCES ORDER_pxm,
FOREIGN KEY 	(ProdID) REFERENCES PRODUCT_pxm
) ;



-- Part IB

DESCRIBE ORDERDETAIL_pxm
DESCRIBE ORDER_pxm
DESCRIBE CUSTOMER_pxm
DESCRIBE SALESREP_pxm
DESCRIBE PRODUCT_pxm
DESCRIBE COMMISSION_pxm
DESCRIBE DEPARTMENT_pxm
DESCRIBE PRODCAT_pxm



-- Part IIA

--Insert rows into PRODCAT table
INSERT INTO PRODCAT_pxm
VALUES (1, 'Hand Tools') ;

INSERT INTO PRODCAT_pxm
VALUES (2, 'Power Tools') ;

INSERT INTO PRODCAT_pxm
VALUES (3, 'Measuring Tools');

INSERT INTO PRODCAT_pxm
VALUES (4, 'Fasteners');

INSERT INTO PRODCAT_pxm
VALUES (5, 'Hardware');

INSERT INTO PRODCAT_pxm
VALUES (6, 'Misc');



--Insert rows into DEPARTMENT table
INSERT INTO DEPARTMENT_pxm
VALUES (10, 'Store Sales') ;

INSERT INTO DEPARTMENT_pxm
VALUES (14, 'Corp Sales') ;

INSERT INTO DEPARTMENT_pxm
VALUES (16, 'Web Sales') ;



--Insert rows into COMMISSION table 
INSERT INTO COMMISSION_pxm
VALUES ('A', 0.1) ;

INSERT INTO COMMISSION_pxm
VALUES ('B', 0.08) ;

INSERT INTO COMMISSION_pxm
VALUES ('Z', 0) ;

INSERT INTO COMMISSION_pxm
VALUES ('C', 0.05) ;



--Insert rows into PRODUCT table 
INSERT INTO PRODUCT_pxm
VALUES (121, 'BD Hammer', 1, 7.00) ;

INSERT INTO PRODUCT_pxm
VALUES (228, 'Makita Power Drill', 2, 65.00) ;
 
INSERT INTO PRODUCT_pxm
VALUES (480, '1# BD Nails', 4, 3.00) ;

INSERT INTO PRODUCT_pxm
VALUES (407, '1# BD Screws', 4, 4.25) ;

INSERT INTO PRODUCT_pxm
VALUES (610, '3M Duct Tabe', 6, 1.75) ;

INSERT INTO PRODUCT_pxm
VALUES (618, '3M Masking Tape', 6, 1.25) ;

INSERT INTO PRODUCT_pxm
VALUES (380, 'Acme Yard Stick', 3, 1.25) ;

INSERT INTO PRODUCT_pxm
VALUES (535, 'Schlage Door Knob', 5, 7.50) ;

INSERT INTO PRODUCT_pxm
VALUES (123, 'Acme Pry Bar', 1, 6.25) ;

INSERT INTO PRODUCT_pxm
VALUES (229, 'BD Power Drill', 2, 59.00 ) ;

INSERT INTO PRODUCT_pxm
VALUES (124, 'Acme Hammer', 1, 6.50 ) ;
 
INSERT INTO PRODUCT_pxm
VALUES (235, 'Makita Power Drill', 2, 65.00) ;



--Insert rows into SALESREP table 
INSERT INTO SALESREP_pxm
VALUES (10, 'Alice', 'Jones', 'A', 10) ;

INSERT INTO SALESREP_pxm
VALUES (12, 'Greg', 'Taylor','B',14);

INSERT INTO SALESREP_pxm
VALUES (14, 'Sara' ,'Day','Z' ,10);
 
INSERT INTO SALESREP_pxm
VALUES (8, 'Kay', 'Price', 'C', 14);

INSERT INTO SALESREP_pxm
VALUES (20, 'Bob', 'Jackson', 'B', 10);

INSERT INTO SALESREP_pxm
VALUES (22, 'Micah', 'Moore', 'Z', 16);


--Insert rows into CUSTOMER table 
INSERT INTO CUSTOMER_pxm
VALUES ('S100', 'John', 'Smith', '2145551212', 10) ;

INSERT INTO CUSTOMER_pxm
VALUES ('A120', 'Jane', 'Adams', '8175553434', 12) ;

INSERT INTO CUSTOMER_pxm
VALUES ('J090', 'Tim', 'Jones', NULL, 14) ;

INSERT INTO CUSTOMER_pxm
VALUES ('B200', 'Ann', 'Brown', '9725557979', 8);

INSERT INTO CUSTOMER_pxm
VALUES ('G070', 'Kate', 'Green', '8175551034', 20) ;

INSERT INTO CUSTOMER_pxm
VALUES ('S120', 'Nicole', 'Sims', NULL, 22);


--Insert rows into ORDER table 
INSERT INTO ORDER_pxm
VALUES (100, '24-JAN-2022', 'S100') ;

INSERT INTO ORDER_pxm
VALUES (101, '25-JAN-2022', 'A120') ;

INSERT INTO ORDER_pxm
VALUES (102, '25-JAN-2022', 'J090') ;

INSERT INTO ORDER_pxm
VALUES (103, '26-JAN-2022', 'B200') ;

INSERT INTO ORDER_pxm
VALUES (104, '26-JAN-2022', 'S100') ;

INSERT INTO ORDER_pxm
VALUES (105, '26-JAN-2022', 'B200') ;

INSERT INTO ORDER_pxm
VALUES (106, '27-JAN-2022', 'G070') ;

INSERT INTO ORDER_pxm
VALUES (107, '27-JAN-2022', 'J090') ;

INSERT INTO ORDER_pxm
VALUES (108, '27-JAN-2022', 'S120') ;


--Insert rows into ORDERDETAIL table
INSERT INTO ORDERDETAIL_pxm
VALUES (100, 121, 2, 8.00) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (100, 228, 1, 65.00) ;
 
INSERT INTO ORDERDETAIL_pxm
VALUES (100, 480, 2, 3) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (100, 407, 1, 4.25) ;
 
INSERT INTO ORDERDETAIL_pxm
VALUES (101, 610, 200, 1.75) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (101, 618, 100, 1.25) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (102, 380, 2, 1.25) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (102, 121, 1, 7.00) ;
 
INSERT INTO ORDERDETAIL_pxm
VALUES (102, 535, 4, 7.50) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (103, 121, 50, 7.00) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (103, 123, 20, 6.25) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (104, 229, 1, 50.00) ;
 
INSERT INTO ORDERDETAIL_pxm
VALUES (104, 610,200, 1.75) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (104, 380, 2, 1.25) ;
 
INSERT INTO ORDERDETAIL_pxm
VALUES (104, 535, 4, 7.50) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (105, 610, 200, 1.75) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (105, 123, 40, 5.00) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (106, 124, 1, 6.50) ;
 
INSERT INTO ORDERDETAIL_pxm
VALUES (107, 229, 1, 59.00) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (108, 235, 1, 65.00) ;

--Save all rows to disk
COMMIT;


--Part IIB

SELECT * FROM PRODCAT_pxm ;
SELECT * FROM DEPARTMENT_pxm ;
SELECT * FROM COMMISSION_pxm ;
SELECT * FROM PRODUCT_pxm ; 
SELECT * FROM SALESREP_pxm ;
SELECT * FROM CUSTOMER_pxm ;
SELECT * FROM ORDER_pxm ;
SELECT * FROM ORDERDETAIL_pxm ;


--Part III

--CUSTOMER TablE
--Changing Customer's phone number
UPDATE CUSTOMER_pxm
	SET CustPhone = '2145551234'
WHERE CustID = 'B200' ;
 
--Adding new customer
INSERT INTO CUSTOMER_pxm
VALUES ('G119', 'Amanda', 'Green', NULL, 14) ;

--ORDER Table
--Changing order date
UPDATE ORDER_pxm
	SET OrderDate = '28-JAN-2022'
WHERE  OrderID = 108 ;

--Adding new order
INSERT INTO ORDER_pxm
VALUES (109, '28-JAN-2022', 'G119') ;

--ORDERDETAIL Table
--Changing price of Product
UPDATE ORDERDETAIL_pxm
	SET ProdPrice = 62.00
WHERE ProdID = 235 AND OrderID = 108 ;

--Adding the Products 
INSERT INTO ORDERDETAIL_pxm
VALUES (108, 407, 1, 5.25) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (108, 618, 2, 2.15) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (109, 121, 1, 8.25) ;

INSERT INTO ORDERDETAIL_pxm
VALUES (109, 480, 1, 3.75) ;

--COMMIT to Save changes to disk
COMMIT;


--Part IV

SELECT * FROM PRODCAT_pxm 
 ORDER BY ProdCatID ;
SELECT * FROM DEPARTMENT_pxm
 ORDER BY DeptName ;
SELECT * FROM COMMISSION_pxm
 ORDER BY CommClass ;
SELECT * FROM PRODUCT_pxm
 ORDER BY ProdID ; 
SELECT * FROM SALESREP_pxm
 ORDER BY SalesRepID ;
SELECT * FROM CUSTOMER_pxm
 ORDER BY CustID ;
SELECT * FROM ORDER_pxm
 ORDER BY OrderID ;
SELECT * FROM ORDERDETAIL_pxm
 ORDER BY OrderID, 	ProdID ;



set echo off
-- This will turn off logging.

spool off
-- This will close the file.  

spool 'C:\Users\pxm65\OneDrive\Desktop\Project3_pxm.txt' 

set echo on

-- Pradeep Makaju
-- INSY 3304-001
-- Project 3	

--Part I1, I2, I3

SET LINESIZE 150
SET PAGESIZE 50

COLUMN CommClass FORMAT a10
COLUMN OrderDate FORMAT a10
COLUMN CustID FORMAT a15


--Part I4

--Adding new customer
INSERT INTO CUSTOMER_pxm
VALUES ('T104', 'Wes', 'Thomas', '4695551215', 22) ;

--Part I5

--Adding a new product
INSERT INTO PRODUCT_pxm
VALUES (246, 'Milwaukee Power Drill', 2, 179) ;



--Part I6

--Add a new Order.  
INSERT INTO ORDER_pxm
VALUES ((SELECT (MAX(OrderID) + 1) FROM ORDER_pxm), '28-JAN-2022', 'T104') ;

--Add OrderDetails
INSERT INTO ORDERDETAIL_pxm
VALUES ((SELECT (MAX(OrderID)) FROM ORDER_pxm), 618, 1, 
  (SELECT ProdPrice 
    FROM  PRODUCT_pxm
  WHERE ProdID = 618)) ;

INSERT INTO ORDERDETAIL_pxm
VALUES ((SELECT (MAX(OrderID)) FROM ORDER_pxm), 407, 2, 
  (SELECT ProdPrice 
    FROM  PRODUCT_pxm
  WHERE ProdID = 407)) ;

INSERT INTO ORDERDETAIL_pxm
VALUES ((SELECT (MAX(OrderID)) FROM ORDER_pxm), 124, 1, 
  (SELECT ProdPrice 
    FROM  PRODUCT_pxm
  WHERE ProdID = 124)) ;




--Part I7

--Add a new Order.
INSERT INTO ORDER_pxm
VALUES ((SELECT (MAX(OrderID) + 1) FROM ORDER_pxm), '29-JAN-2022', 'S100') ;

--Add OrderDetails
INSERT INTO ORDERDETAIL_pxm
VALUES ((SELECT (MAX(OrderID)) FROM ORDER_pxm), 535, 3, 
  (SELECT ProdPrice 
   FROM PRODUCT_pxm
  WHERE ProdID = 535)) ;

INSERT INTO ORDERDETAIL_pxm
VALUES ((SELECT (MAX(OrderID)) FROM ORDER_pxm), 246, 1, 
  (SELECT ProdPrice 
   FROM PRODUCT_pxm
  WHERE ProdID = 246)) ;

INSERT INTO ORDERDETAIL_pxm
VALUES ((SELECT (MAX(OrderID)) FROM ORDER_pxm), 610, 2, 
  (SELECT ProdPrice 
   FROM PRODUCT_pxm
  WHERE ProdID = 610)) ;



--Part I8

--Change the phone number.
UPDATE CUSTOMER_pxm
  SET CustPhone = '8175558918'
WHERE CustID = 'B200' ;



--Part I9

-- COMMIT to save changes to disk.
COMMIT; 
--------------------------------------------------------------------------------------------------------------------------------------------


--Part II1


SELECT SalesRepID as "Sales Rep ID" , (SalesRepFName || SalesRepLName) as "SalesRep Name", 
S.CommClass as "Commission Class", CommRate as "Commission Rate"
  FROM SALESREP_pxm S, COMMISSION_pxm C
WHERE S.CommClass = C.CommClass
ORDER BY SalesRepLName ; 


--Part II2 


SELECT OrderID as "Order ID", ProdID as "Product ID", ProdQty as "Qty", TO_CHAR(ProdPrice, '$999.99') as "Price"
  FROM ORDERDETAIL_pxm
ORDER BY OrderID, ProdID ;



--Part II3


SELECT CustID as "CustID", CustFName as "CustFirstName", CustLName as "CustLastName", 
('(' || SUBSTR(CustPhone,1,3) || ')' || SUBSTR(CustPhone,4,3) || '-' || SUBSTR(CustPhone,7,4)) as "CustPhone", 
C.SalesRepID as "SalesRepID", SalesRepFName as "SalesRepFirstName", SalesRepLName as "SalesRepLastName"
  FROM CUSTOMER_pxm C, SALESREP_pxm S
WHERE  C.SalesRepID = S.SalesRepID
ORDER BY CustID ;



--Part II4 


SELECT D.DeptID as "Dept_ID", DeptName as "DeptName", SalesRepID as "Sales_Rep_ID", 
        SalesRepFName as "First_Name", SalesRepLName as "Last_Name", S.CommClass as "Commission_Class", CommRate as "CommRate"
  FROM SALESREP_pxm S, DEPARTMENT_pxm D, COMMISSION_pxm C
WHERE D.DeptID = S.DeptID AND
      C.CommClass = S.CommClass AND
      (S.DeptID, CommRate) IN
    (SELECT S.DeptID, MAX(CommRate)
        FROM SALESREP_pxm S, COMMISSION_pxm C
        WHERE S.CommClass = C.CommClass
        GROUP BY S.DeptID) ;



--Part II5 


SELECT O.ProdID as "Product_ID", ProdName as "Product_Name", ProdCatName as "Category", TO_CHAR(O.ProdPrice, '$999.99') as "Price"
  FROM ORDERDETAIL_pxm O, PRODUCT_pxm P, PRODCAT_pxm PD
WHERE O.ProdID = P.ProdID AND
      P.ProdPrice = P.ProdPrice AND
      P.ProdCatID = PD.ProdCatID AND
      OrderID = 100 AND
      O.ProdPrice =     
    (SELECT MAX(O.ProdPrice)
        FROM ORDERDETAIL_pxm O
        WHERE OrderID = 100) ;




--Part II6


SELECT DeptName as "Dept_Name", COUNT(SalesRepID) as "Sales_Rep_Count"
  FROM DEPARTMENT_pxm D, SALESREP_pxm S
WHERE S.DeptID = D.DeptID
GROUP BY DeptName
ORDER BY "Sales_Rep_Count"  ; 



--Part II7


SELECT SalesRepID as "Sales_Rep_ID", SalesRepFName as "First_Name", SalesRepLName as "Last_Name", 
CONCAT(CommRate*100, '%') as "Commission_Rate"
  FROM SALESREP_pxm S, COMMISSION_pxm C
WHERE S.CommClass = C.CommClass AND
      CommRate > 0.00 AND
      CommRate <= 0.05
  ORDER BY CommRate DESC;
  


--Part II8


SELECT OrderID, TO_CHAR(OrderDate, 'mm/dd/yy') as "OrderDate", O.CustID, CustFName, CustLName,
 C.SalesRepID, SalesRepFName, SalesRepLName
  FROM ORDER_pxm O, CUSTOMER_pxm C, SALESREP_pxm S
WHERE O.CustID = C.CustID AND
      C.SalesRepID = S.SalesRepID
ORDER BY O.OrderID ;



--Part II9


SELECT OrderID as "OrderID", P.ProdID as "ProdID", ProdName as "ProdName", ProdCatID as "CatID", 
TO_CHAR(P.ProdPrice, '$999.99') as "Price", ProdQty as "Qty", TO_CHAR((P.ProdPrice)*(ProdQty), '$999.99')as "ExtPrice"
  FROM ORDERDETAIL_pxm O, PRODUCT_pxm P
WHERE O.ProdID = P.ProdID AND
      O.OrderID = 104
ORDER BY "ExtPrice" ;



--Part II10


SELECT S.DeptID as "DeptID", DeptName as "DeptName", COUNT(SalesRepID) as "SaleRepCount", 
CONCAT((AVG(CommRate)) *100, '%') as "AvgCommRate"
  FROM DEPARTMENT_pxm D, SALESREP_pxm S, COMMISSION_pxm C
WHERE S.DeptID = D.DeptID AND
      S.CommClass = C.CommClass 
GROUP BY S.DeptID, DeptName
ORDER BY "AvgCommRate" ;



--Part II11

SELECT SalesRepID, SalesRepFName, SalesRepLName, DeptName, C.CommClass, CONCAT(CommRate*100, '%') as "CommRate"
    FROM SALESREP_pxm S, DEPARTMENT_pxm D, COMMISSION_pxm C
WHERE S.DeptID = D.DeptID AND
      S.CommClass = C.CommClass AND
      CommRate > 0
ORDER BY SalesRepID ;




--Part II12

SELECT SalesRepID, (SalesRepFName || '' || SalesRepLName) as "SaleRep_Name", S.DeptID, DeptName
  FROM SALESREP_pxm S, DEPARTMENT_pxm D
WHERE S.DeptID = D.DeptID AND
        CommClass = 'A'
ORDER BY S.DeptID, SalesRepID ;



--Part II13

COLUMN "Order_Total" FORMAT a11

SELECT OrderID as "Order_ID", TO_CHAR(SUM((ProdPrice)*(ProdQty)), '$999.99') as "Order_Total"
  FROM ORDERDETAIL_pxm
WHERE OrderID = 104 
GROUP BY OrderID ;



--Part II14

COLUMN "Avg_Price" FORMAT a10

SELECT TO_CHAR(AVG(ProdPrice), '$999.99') as "Avg_Price"
  FROM ORDERDETAIL_pxm
ORDER BY ProdPrice ;



--Part II15

SELECT P.ProdId as "PoductID", ProdName as "Name", P.ProdPrice as "Price"
  FROM ORDERDETAIL_pxm O, PRODUCT_pxm P
WHERE O.ProdID = P.ProdID AND
      O.ProdPrice = P.ProdPrice 
      GROUP BY P.ProdID, ProdName, P.ProdPrice
HAVING COUNT(OrderID) =
      (SELECT MAX(COUNT(OrderID))
        FROM ORDERDETAIL_pxm
      GROUP BY ProdID) ;


--Part II16

SELECT ProdCatID as "Cat_ID", ProdID as "Prod_ID", ProdName as "Prod_Name", TO_CHAR(ProdPrice, '$999.99') as "Price"
  FROM PRODUCT_pxm
  WHERE (ProdCatID, ProdPrice) IN
        (SELECT ProdCatID, MIN(ProdPrice)
            FROM PRODUCT_pxm
            GROUP BY ProdCatID) ;


--Part II17

SELECT ProdID, ProdName, ProdCatName, ProdPrice
  FROM PRODUCT_pxm P, PRODCAT_pxm PC
WHERE P.ProdCatID = PC.ProdCatID AND
        ProdPrice >
        (SELECT SUM(ProdPrice)/ COUNT(ProdID)
          FROM PRODUCT_pxm P) ;



--Part II18


COLUMN "Order Date" FORMAT a10

SELECT OrderID as "Order ID", TO_CHAR(OrderDate, 'mm-dd-yyyy') as "Order Date", C.CustID as "CustID", 
(CustFName || ' ' || CustLName) as "Name", CustPhone as "Phone"
  FROM ORDER_pxm O, CUSTOMER_pxm C
WHERE O.CustID = C.CustID AND
      OrderDate <= '26-JAN-2022'
ORDER BY OrderDate, O.CustID ;



--Part II19


SELECT CustID as "CustID", CustFName  as "FirstName", CustLName as "LastName"
  FROM CUSTOMER_pxm
WHERE CustFName LIKE 'A%' 
  ORDER  BY CustLName ;



--Part II20

COLUMN "Customer ID" FORMAT A11


SELECT CustID as "Customer ID", (CustFName || ' ' || CustLName) as "Name", 
(SUBSTR(CustPhone,1,3) || '-' || SUBSTR(CustPhone,4,3) || '-' || SUBSTR(CustPhone,7,4)) as "Phone"
  FROM CUSTOMER_pxm
WHERE SalesRepID = 12 ;



set echo off

spool off
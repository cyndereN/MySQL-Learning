1.
SELECT SUM( quantity ) AS 'TOTAL SHOVELS ORDERED'
FROM lineitems
WHERE itemID = "S5"


2.
SELECT custID, COUNT( custID )
FROM `orders`
GROUP BY custID
LIMIT 0 , 30


3.
SELECT custID, familyname
FROM customers
WHERE custID NOT
IN (
SELECT custID
FROM orders
)
LIMIT 0 , 30



4.
SELECT *
FROM customers
WHERE custID
IN (

SELECT o.custID
FROM orders AS o
WHERE o.orderID
IN (

SELECT l.orderID
FROM lineitems AS l
WHERE itemID = "C1"
)
AND (

SELECT l.orderID
FROM lineitems AS l
WHERE itemID = "C6"
)
)
LIMIT 0 , 30



5. 
SELECT s.supplierID, s.supplierName, sum(l.quantity * i.unitcost) as "money"
from suppliers s, supplieritems si, lineitems l, items i
where l.itemID = i.itemID and
i.itemID = si.itemID and 
si.supplierID = s.supplierID
group by s.supplierID


6.
SELECT customers.familyname, customers.firstname, SUM( lineitems.quantity * items.unitcost )
FROM customers, orders, items, lineitems
WHERE customers.custID = orders.custID
AND orders.orderID = lineitems.orderID
AND lineitems.itemID = items.itemID
GROUP BY customers.custID
HAVING COUNT( DISTINCT orders.orderID ) >1
ORDER BY SUM( lineitems.quantity * items.unitcost ) DESC
LIMIT 0 , 30


7.
SELECT state, COUNT( orders.custID )
FROM orders
RIGHT JOIN customers ON orders.custID = customers.custID
GROUP BY state
ORDER BY COUNT( orders.custID ) DESC
LIMIT 0 , 30


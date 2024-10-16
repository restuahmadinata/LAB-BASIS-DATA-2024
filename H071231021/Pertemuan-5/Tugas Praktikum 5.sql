# Tugas Praktikum  4

USE classicmodels;

# NOMOR 1
SELECT DISTINCT
	c.customerName AS "namaKustomer",
	p.productName AS "namaProduk",
	pl.textDescription
FROM customers AS c
INNER JOIN orders AS o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
INNER JOIN products AS p
ON od.productCode = p.productCode
INNER JOIN productlines AS pl
ON p.productLine = pl.productLine
WHERE p.productName LIKE "%Titanic%"
ORDER BY c.customerName ASC;

# NOMOR 2
SELECT
	c.customerName,
	p.productName,
	o.status,
	o.shippedDate
FROM customers AS c
INNER JOIN orders AS o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
INNER JOIN products AS p
ON od.productCode = p.productCode
WHERE productName LIKE "%Ferrari%"
AND `status` = "Shipped"
AND shippedDate BETWEEN "2003-10-01" AND "2004-10-01"
ORDER BY shippedDate ASC;

# NOMOR 3
SELECT
	e1.firstName AS Supervisor,
	e2.firstName AS Karyawan
FROM employees AS e1
INNER JOIN employees AS e2
ON e1.employeeNumber = e2.reportsTo
WHERE e1.firstName = "Gerard"
ORDER BY e2.firstName ASC;

# NOMOR 4
-- a
SELECT
	c.customerName,
	p.paymentDate,
	e.firstName AS employeeName,
	p.amount
FROM customers AS c
INNER JOIN payments AS p
ON c.customerNumber = p.customerNumber
INNER JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE paymentDate LIKE "%11-__";

-- b
SELECT
	c.customerName,
	p.paymentDate,
	e.firstName AS employeeName,
	p.amount
FROM customers AS c
INNER JOIN payments AS p
ON c.customerNumber = p.customerNumber
INNER JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE paymentDate LIKE "%11-__"
ORDER BY amount DESC
LIMIT 1;


-- c
SELECT
	c.customerName,
	pro.productName
FROM customers AS c
INNER JOIN payments AS p
ON c.customerNumber = p.customerNumber
INNER JOIN orders AS o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
INNER JOIN products AS pro
ON od.productCode = pro.productCode
WHERE c.customerName LIKE "Corporate%"
AND paymentDate LIKE "%11-__";

-- 4c (Sub-Query)
SELECT
    c.customerName,
    pro.productName
FROM customers AS c
INNER JOIN payments AS p
ON c.customerNumber = p.customerNumber
INNER JOIN orders AS o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
INNER JOIN products AS pro
ON od.productCode = pro.productCode
WHERE c.customerName = (
    SELECT
        c2.customerName
    FROM customers AS c2
    INNER JOIN payments AS p2
    ON c2.customerNumber = p2.customerNumber
    WHERE p2.paymentDate LIKE "%11-%"
    ORDER BY p2.amount DESC
    LIMIT 1
)
AND p.paymentDate LIKE "%11-%";


-- TAMBAHAN
-- NO 2
SELECT
	c.customerName,
	o.orderNumber,
	o.orderDate,
	o.shippedDate,
	p.productName,
	od.quantityOrdered,
	od.priceEach,
	offi.city,
	e.firstName,
	e.lastName
FROM customers AS c
-- JOIN
INNER JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN offices AS offi
ON e.officeCode = offi.officeCode
INNER JOIN orders AS o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails AS od
ON o.orderNumber = od.orderNumber
INNER JOIN products AS p
ON od.productCode = p.productCode
-- PENGKONDISIAN
WHERE productName LIKE "1%r"
AND orderDate < "2004-12-25"
AND quantityOrdered > 10
AND c.city = "NYC"
AND od.priceEach BETWEEN 20 AND 100
ORDER BY c.customerName ASC, o.orderDate DESC;
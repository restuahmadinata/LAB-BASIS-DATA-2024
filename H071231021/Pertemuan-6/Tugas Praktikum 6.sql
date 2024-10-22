USE classicmodels;

#Nomor 1
SELECT
	c.customerName,
	CONCAT(e.firstName, " ", e.lastName) AS salesRep,
	c.creditLimit - SUM(p.amount) AS remainingCredit
FROM customers AS c
JOIN payments AS p ON c.customerNumber = p.customerNumber
JOIN employees AS e ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY customerName
HAVING remainingCredit > 0;

#Nomor 2
SELECT DISTINCT
	pro.productName AS "Nama Produk",
	GROUP_CONCAT(c.customerName ORDER BY c.customerName ASC) AS "Nama Customer",
	COUNT(DISTINCT c.customerNumber) AS "Jumlah Customer",
	SUM(od.quantityOrdered) AS "Total Kuantitas"
FROM products AS pro
JOIN orderdetails AS od ON od.productCode = pro.productCode
JOIN orders AS o ON o.orderNumber = od.orderNumber
JOIN customers AS c ON c.customerNumber = o.customerNumber
GROUP BY pro.productName;


#NOMOR 3
SELECT
	CONCAT(e.firstName, " ", e.lastName) AS employeeName,
	COUNT(c.salesRepEmployeeNumber) AS totalCustomer
FROM employees AS e
JOIN customers AS c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY employeeName
ORDER BY totalCustomer DESC;

#NOMOR 4 -- 181
SELECT
	CONCAT(e.firstName, " ", e.lastName) AS "Nama Karyawan",
	pro.productName AS "Nama Produk",
	SUM(od.quantityOrdered) AS "Jumlah Pesanan"
FROM products AS pro
RIGHT JOIN orderdetails AS od ON od.productCode = pro.productCode
RIGHT JOIN orders AS o ON o.orderNumber = od.orderNumber
RIGHT JOIN customers AS c ON c.customerNumber = o.customerNumber
RIGHT JOIN employees AS e ON e.employeeNumber = c.salesRepEmployeeNumber
RIGHT JOIN offices AS ofc ON ofc.officeCode = e.officeCode
WHERE ofc.country = "Australia"
GROUP BY `Nama Karyawan`, `Nama Produk`
ORDER BY SUM(quantityOrdered) DESC;


#NOMOR 5
SELECT
	c.customerName AS "Nama Pelanggan",
	GROUP_CONCAT(DISTINCT pro.productName SEPARATOR ", ") AS "Nama Produk",
	COUNT(DISTINCT pro.productCode) AS "Banyak Jenis Produk"
FROM customers AS c
JOIN orders AS o ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
JOIN products AS pro ON od.productCode = pro.productCode
WHERE o.shippedDate IS NULL
GROUP BY c.customerName;












-- Tambahan
SELECT
	CONCAT(e.firstName, " ", e.lastName) AS "Nama Karyawan",
	p.productName AS "Nama Produk",
	SUM(od.quantityOrdered) AS "Total Pesanan"
FROM employees AS e
JOIN customers AS c ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN orders AS o ON o.customerNumber = c.customerNumber
JOIN orderdetails AS od ON od.orderNumber = o.orderNumber
JOIN products AS p ON od.productCode = p.productCode
WHERE MONTH(o.orderDate) % 2 != 0
GROUP BY `Nama Produk`;

SELECT * FROM employees;
SELECT 

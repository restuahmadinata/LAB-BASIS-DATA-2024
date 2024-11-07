-- p8

USE classicmodels;

#Nomor 1
(SELECT 
	productName, 
	SUM(priceEach * quantityOrdered) AS totalRevenue, 
	'Pendapatan Tertinggi' AS Pendapatan
FROM products
JOIN orderdetails USING (productCode)
JOIN orders USING (orderNumber)
WHERE MONTH(orderDate) = 9
GROUP by productName
ORDER BY totalRevenue DESC
LIMIT 5)

UNION

(SELECT 
	productName, 
	SUM(priceEach * quantityOrdered) AS totalRevenue, 
	'Pendapatan Pendek (kayak kamu)' AS Pendapatan
FROM products
JOIN orderdetails USING (productCode)
JOIN orders USING (orderNumber)
WHERE month(orderDate) = 9
GROUP by productName
ORDER BY totalRevenue asc
LIMIT 5);

#Nomor 2
SELECT p.productName
FROM products p
EXCEPT
SELECT p.productName
FROM products p
JOIN orderdetails od 
    USING(productCode)
JOIN orders o 
    USING(orderNumber)
WHERE customerNumber IN (
    -- Pelanggan dengan >10 pesanan
    SELECT customerNumber
    FROM orders
    GROUP BY customerNumber
    HAVING COUNT(*) > 10
    INTERSECT
    -- Pelanggan yang pernah pesan produk di atas rata-rata
    SELECT DISTINCT o.customerNumber
    FROM orders o
    JOIN orderdetails od USING(orderNumber)
    JOIN products p USING(productCode)
    WHERE p.buyPrice > (
        SELECT AVG(buyPrice)
        FROM products
    )
);


#Nomor 3
SELECT customerName
FROM customers
JOIN payments USING (customerNumber)
GROUP BY customerName
HAVING SUM(amount) > 2 * (
    SELECT AVG(totalAverage)
    FROM (
        SELECT DISTINCT SUM(amount) AS totalAverage
        FROM payments
        GROUP BY customerNumber
    ) AS hasil
)

INTERSECT

SELECT customerName
FROM customers
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
WHERE productLine IN('Planes', 'Trains')
GROUP BY customerName
HAVING SUM(quantityOrdered * priceEach) > 20000;

#Nomor 4
SELECT 
   o.orderDate AS 'Tanggal',
   c.customerNumber AS 'CustomerNumber',
   'Membayar Pesanan dan Memesan Barang' AS 'riwayat'
FROM orders o
JOIN customers c USING (customerNumber)
JOIN payments p ON o.orderDate = p.paymentDate
HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003

UNION

SELECT 
    orderDate, 
    customerNumber,
    'Memesan Barang' 
FROM orders
WHERE MONTH(orderDate) = 09 AND YEAR(orderDate) = 2003
AND orderDate NOT IN (  
	SELECT o.orderDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
)

UNION

SELECT 
    paymentDate, 
    customerNumber, 
    'Membayar Pesanan'  FROM payments
WHERE MONTH(paymentDate) = 09 AND YEAR(paymentDate) = 2003
AND paymentDate NOT IN (  
	SELECT p.paymentDate AS 'Tanggal'
	FROM orders o
	JOIN customers c USING (customerNumber)
	JOIN payments p ON o.orderDate = p.paymentDate
	HAVING MONTH(Tanggal) = 09 AND YEAR(Tanggal) = 2003
)
ORDER BY Tanggal;


#Nomor 5
SELECT DISTINCT productCode FROM products
JOIN orderdetails USING(productCode)
WHERE priceEach > (
    SELECT AVG(priceEach) FROM orderdetails
    JOIN orders USING(orderNumber)
    WHERE orderDate BETWEEN '2001-01-01' AND '2004-03-31'
)
AND quantityOrdered > 48
AND LEFT(productVendor, 1) IN ('A', 'I', 'U','E','O')

EXCEPT

SELECT DISTINCT productCode FROM products
JOIN orderdetails USING(productCode)
JOIN orders USING(orderNumber)
JOIN customers USING(customerNumber)
WHERE country IN("Japan", "Germany", "Italy");



-- Tambahan
(SELECT
	CONCAT(employees.firstName, " ", employees.lastName) AS 'Nama Karyawan/Pelanggan',
	'Karyawan' AS 'status'
FROM employees
JOIN offices USING (officeCode)
WHERE employees.officeCode IN
	(SELECT officeCode
				  FROM employees
				  GROUP BY officeCode
				  HAVING COUNT(*) = (SELECT COUNT(*)
						      FROM employees
                                                  GROUP BY officeCode
                                                  ORDER BY COUNT(*) 
		                                    LIMIT 1))
ORDER BY `Nama Karyawan/Pelanggan`)

UNION

(SELECT
	customers.customerName AS 'Nama Karyawan/Pelanggan',
	'Pelanggan' AS 'status'
FROM customers
WHERE customers.salesRepEmployeeNumber IN
	(SELECT employeeNumber AS salesRepEmployeeNumber
	FROM employees
	JOIN offices USING (officeCode)
	WHERE employees.officeCode IN
	(SELECT officeCode
				  FROM employees
				  GROUP BY officeCode
				  HAVING COUNT(*) = (SELECT COUNT(*)
						      FROM employees
                                                  GROUP BY officeCode
                                                  ORDER BY COUNT(*) 
		                                    LIMIT 1)))
ORDER BY `Nama Karyawan/Pelanggan`)
ORDER BY `Nama Karyawan/Pelanggan`
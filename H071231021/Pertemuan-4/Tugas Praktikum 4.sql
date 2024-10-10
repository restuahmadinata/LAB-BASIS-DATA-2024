USE classicmodels;

# Nomor 1
SELECT
	customerNumber,
	customerName,
	country,
	creditLimit
FROM
	customers
WHERE
	(country = "USA" AND creditLimit > 50000 AND creditLimit < 100000
OR
	(country != "USA" AND creditLimit >= 100000 AND creditLimit <= 200000)
AND
	(customerName LIKE "A%")
ORDER BY
	creditLimit DESC;

# Nomor 2
SELECT
	productCode,
	productName,
	quantityInStock,
	buyPrice
FROM
	products
WHERE
	quantityInStock BETWEEN 1000 AND 2000
AND
	buyPrice < 50 OR buyPrice > 150
AND
	productLine NOT LIKE "%Vintage%";

#Nomor 3
SELECT
	productCode,
	productName,
	MSRP
FROM
	products
WHERE
	productLine LIKE "%Classic%"
AND
	buyPrice > 50;
	
#Nomor 4
SELECT
	orderNumber,
	orderDate,
	status,
	customerNumber
FROM
	orders
WHERE
	orderNumber > 10250
AND
	(status != "Shipped" AND  status != "Cancelled")
AND
	(orderDate > "2004-01-01" AND orderDate < "2005-12-30");
	
#Nomor 5
SELECT
	orderNumber,
	orderLineNumber,
	productCode,
	quantityOrdered,
	priceEach,
	(quantityOrdered * (priceEach * 0.95)) AS discountedTotalPrice
FROM
	orderdetails
WHERE
	quantityOrdered > 50
AND
	priceEach > 100
AND
	productCode NOT LIKE "S18%"
ORDER BY
	discountedTotalPrice;
	
-- Tugas Tambahan 1
SELECT
	productName,
	productScale
FROM
	products
WHERE
	productName LIKE "197%"
AND
	productScale = "1:18";
	
-- Tugas Tambahan 2
SELECT
	checkNumber,
	amount,
	paymentDate
FROM
	payments
WHERE
	amount BETWEEN 10000 AND 100000
AND
	paymentDate LIKE "%12-__"
ORDER BY
	paymentDate ASC;
	
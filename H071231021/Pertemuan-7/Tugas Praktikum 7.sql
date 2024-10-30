#Tugas Praktikum 7
USE classicmodels;

#Nomor 1
SELECT
	products.productCode,
	products.productName,
	products.buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice)
						FROM products);
						
#Nomor 2
SELECT
	orders.orderNumber,
	orders.orderDate
FROM orders
JOIN customers
ON customers.customerNumber = orders.customerNumber
WHERE customers.salesRepEmployeeNumber IN (SELECT employeeNumber
					FROM employees
					JOIN offices
					ON offices.officeCode = employees.officeCode
					WHERE offices.city = "Tokyo");

#Nomor 3 // BELUM SELESAI
SELECT
	customers.customerName,
	orders.orderNumber,
	orders.shippedDate,
	orders.requiredDate,
	GROUP_CONCAT(productName) AS 'products',
	SUM(orderdetails.quantityOrdered) AS total_quantity_ordered,
	CONCAT(employees.firstName, " ", employees.lastName) AS employeeName
FROM customers
JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN orders
ON customers.customerNumber = orders.customerNumber
JOIN orderdetails
ON orders.orderNumber = orderdetails.orderNumber
JOIN products
ON orderdetails.productCode = products.productCode
WHERE orders.shippedDate > orders.requiredDate;


#Nomor 4
SELECT
	productName,
	productLine,
	SUM(quantityOrdered) AS total_quantity_ordered
FROM products
JOIN orderdetails
ON products.productCode = orderdetails.productCode
WHERE productLine IN(SELECT
								productLine
							FROM (SELECT
										productLine,
										SUM(o2.quantityOrdered) AS totalQuantity
									FROM products p2
									JOIN orderdetails o2
									ON p2.productCode = o2.productCode
									GROUP BY p2.productLine
									ORDER BY totalQuantity DESC
									LIMIT 3) AS topProductLines)
GROUP BY productName, productLine
ORDER BY productLine ASC, total_quantity_ordered DESC;


-- Tambahan : Menampilkan kota dengan pendapatan tertinggi dan pendapatan terendah
SELECT city, pendapatan
FROM (
    SELECT offices.city, SUM(payments.amount) AS pendapatan
    FROM customers
    JOIN payments ON payments.customerNumber = customers.customerNumber
    JOIN employees ON employees.employeeNumber = customers.salesRepEmployeeNumber
    JOIN offices ON offices.officeCode = employees.officeCode
    GROUP BY offices.city
    ORDER BY pendapatan DESC
) AS sorted
WHERE pendapatan = (SELECT MAX(pendapatan) FROM (
                        SELECT SUM(payments.amount) AS pendapatan
                        FROM customers
                        JOIN payments ON payments.customerNumber = customers.customerNumber
                        JOIN employees ON employees.employeeNumber = customers.salesRepEmployeeNumber
                        JOIN offices ON offices.officeCode = employees.officeCode
                        GROUP BY offices.city
                    ) AS maxPendapatan)
   OR pendapatan = (SELECT MIN(pendapatan) FROM (
                        SELECT SUM(payments.amount) AS pendapatan
                        FROM customers
                        JOIN payments ON payments.customerNumber = customers.customerNumber
                        JOIN employees ON employees.employeeNumber = customers.salesRepEmployeeNumber
                        JOIN offices ON offices.officeCode = employees.officeCode
                        GROUP BY offices.city
                    ) AS minPendapatan);
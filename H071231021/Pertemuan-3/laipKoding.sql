USE classicmodels;


-- NOMOR 1
UPDATE orderdetails
SET orderLineNumber = 1
WHERE priceEach > 200;

SELECT
	priceEach,
	orderLineNumber,
	orderNumber
FROM orderdetails
WHERE priceEach > 200
ORDER BY orderLineNumber ASC;

SELECT * FROM orderdetails;

-- NOMOR 2
SELECT
	customerName
FROM customers
JOIN employees
ON salesrepemployeenumber = employeeNumber
WHERE employees.firstName = "Barry"

WHERE salesRepEmployeeNumber in(SELECT employeeNumber FROM employees WHERE firstName = "Barry");
	
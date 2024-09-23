USE classicmodels;

SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM employees;
SELECT * FROM customers;

# NOMOR 1
SELECT
	productCode AS "Kode Produk",
	productName AS "Nama Produk",
	quantityInStock AS "Jumlah Stok"
FROM products
WHERE quantityInStock
BETWEEN 5000 AND 6000;

# NOMOR 2
SELECT
	orderNumber AS "Nama Pesanan",
	orderDate AS "Tanggal Pesanan",
	status,
	customerNumber AS "Nomor Pelanggan"
FROM orders
WHERE status != "Shipped"
ORDER BY customerNumber ASC;

# NOMOR 3
SELECT
	employeeNumber AS "Nomor Karyawan",
	firstName,
	lastName,
	email,
	jobTitle AS "Jabatan"
FROM employees
WHERE jobTitle = "Sales Rep"
ORDER BY firstName ASC
LIMIT 10;

# NOMOR 4
SELECT
	productCode AS "Kode Produk",
	productName AS "Nama Produk",
	productLine AS "Lini Produk",
	buyPrice AS "Harga Beli"
FROM products
ORDER BY buyPrice DESC
LIMIT 5, 10;

# NOMOR 5
SELECT DISTINCT
	country,
	city
FROM customers
ORDER BY country ASC, city ASC;

# TAMBAHAN
SELECT * FROM payments;

SELECT
	paymentDate,
	customerNumber
FROM payments
ORDER BY paymentDate DESC
LIMIT 4, 6;
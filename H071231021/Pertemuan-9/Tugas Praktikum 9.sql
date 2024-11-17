-- TP9

# Nomor 1
CREATE DATABASE sepakbola; 
USE sepakbola;

CREATE TABLE klub (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_klub VARCHAR(50) NOT NULL,
	kota_asal VARCHAR(20) NOT NULL
);

CREATE TABLE pemain (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nama_pemain VARCHAR(50) NOT NULL,
	posisi VARCHAR(20) NOT NULL,
	id_klub INT,
	FOREIGN  KEY(id_klub) REFERENCES klub(id)
);

CREATE TABLE pertandingan (
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_klub_tuan_rumah INT,
	FOREIGN KEY(id_klub_tuan_rumah) REFERENCES klub(id),
	id_klub_tamu INT,
	FOREIGN KEY(id_klub_tamu) REFERENCES klub(id),
	tanggal_pertandingan DATE NOT NULL,
	skor_tuan_rumah INT DEFAULT 0,
	skor_tamu INT DEFAULT 0
);

CREATE INDEX idx_posisi_pemain ON pemain(posisi);
CREATE INDEX idx_kota_asal ON klub(kota_asal);

DESCRIBE klub;
DESCRIBE pemain;
DESCRIBE pertandingan;


#Nomor 2
USE classicmodels;

SELECT
	customerName,
	country,
	SUM(amount) AS TotalPayment,
	COUNT(orderNumber) AS orderCount,
	MAX(paymentDate) as LastPaymentDate,
	CASE
		WHEN SUM(amount) > 100000 THEN 'VIP'
		WHEN SUM(amount) BETWEEN 5000 AND 100000 THEN 'Loyal'
 		ELSE 'New'
	END AS 'Status'
FROM customers
LEFT JOIN payments USING(customerNumber)
LEFT JOIN orders USING(customerNumber)
GROUP BY customerName, country
ORDER BY customerName ASC;

#Nomor 3
SELECT
	customerNumber,
	customerName,
	SUM(quantityOrdered) AS total_quantity,
	CASE
		WHEN SUM(quantityOrdered)  > (SELECT AVG(total_quantity) FROM (SELECT
																								customerNumber,
																								SUM(quantityOrdered) AS total_quantity
																							FROM orders
																							JOIN orderdetails USING (orderNumber)
																							GROUP BY customerNumber)AS o) THEN 'di atas rata-rata'
		ELSE 'di bawah rata-rata'
	END AS kategori_pembelian
FROM customers
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
GROUP by customerNumber
ORDER BY total_quantity DESC;


-- Tambahan
SELECT
	customerName AS 'Nama Pelanggan',
	GROUP_CONCAT(productName SEPARATOR ", ") AS 'Nama Produk',
	COUNT(productName) AS 'Jumlah Produk',
	SUM(DATEDIFF(shippedDate, orderDate)) AS 'Total Durasi Pengiriman',
	CASE
		WHEN MONTH(orderDate) % 2 != 0 AND SUM(DATEDIFF(shippedDate, orderDate)) >
								(SELECT AVG(waktu) FROM
									(SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS waktu
									FROM orders
									JOIN orderdetails
									GROUP BY customerNumber) AS xy) THEN 'Target 1'
		ELSE 'Target 2'
	END AS Keterangan
FROM customers
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
WHERE productName LIKE '18%'
GROUP BY customerName

SELECT AVG(waktu) FROM (SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS waktu
								FROM orders
								JOIN orderdetails
								GROUP BY customerNumber) AS xy
								
								


-- Tambahan
SELECT
	customerName AS 'Nama Pelanggan',
	GROUP_CONCAT(productName SEPARATOR ", ") AS 'Nama Produk',
	COUNT(productName) AS 'Jumlah Produk',
	SUM(DATEDIFF(shippedDate, orderDate)) AS 'Total Durasi Pengiriman',
	CASE
		WHEN MONTH(orderDate) % 2 = 0 AND SUM(DATEDIFF(shippedDate, orderDate)) >
								(SELECT AVG(waktu) FROM
									(SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS waktu
									FROM orders
									GROUP BY customerNumber) AS xy) THEN 'Target 2'

   	WHEN MONTH(orderDate) % 2 != 0 AND SUM(DATEDIFF(shippedDate, orderDate)) >
								(SELECT AVG(waktu) FROM
									(SELECT SUM(DATEDIFF(shippedDate, orderDate)) AS waktu
									FROM orders
									GROUP BY customerNumber) AS xy) THEN 'Target 1'					
	END AS Keterangan
FROM customers
JOIN orders USING (customerNumber)
JOIN orderdetails USING (orderNumber)
JOIN products USING (productCode)
WHERE productName LIKE '18%'
GROUP BY customerName
HAVING Keterangan IS NOT NULL
ORDER BY `Total Durasi Pengiriman` DESC;
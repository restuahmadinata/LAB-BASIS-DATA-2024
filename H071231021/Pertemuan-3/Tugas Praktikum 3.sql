#NOMOR 1
-- BIKIN TABEL
INSERT INTO authors (id, name, nationality)
VALUES
	(1, "Tere Liye", "Indonesian"),
	(2, "J.K Rowling", "British"),
	(3, "Andrea Hirata", "");

INSERT INTO books (id, isbn, title, author_id, published_year, genre, copies_available)
VALUES
	(1, 7040289780375, "Ayah", 3, 2015, "Fiction", 15),
	(2, 9780375704025, "Bumi", 1, 2014, "Fantasy", 5),
	(3, 8310371703024, "Bulan", 1, 2015, "Fantasy", 3),
	(4, 9780747532699, "Harry Potter and The Philosopher's Stone", 2, 1997, "", 10),
	(5, 7210301703022, "The Running Grave", 2, 2016, "Fiction", 11);
	

INSERT INTO members (id, first_name, last_name, email, phone_number, join_date, membership_type) 
VALUES
	(1, "John", "Doe", "John.doe@example.com", NULL, "2023-04-29", ""),
	(2, "Alice", "Johnson", "alice.johnson@example.com", "1231231231", "2023-05-01", "Standar"),
	(3, "Bob", "Williams", "bob.williams@example.com", "3213214321", "2023-06-20", "Premium");

	
INSERT INTO borrowings (member_id, book_id, borrow_date, return_date)
VALUES
	(1, 4, "2023-07-10", "2023-07-25"),
	(3, 1, "2023-08-01", NULL),
	(2, 5, "2023-09-06", "2023-09-09"),
	(2, 3, "2023-09-08", NULL),
	(3, 2, "2023-09-10", NULL);
	
# NOMOR 2
-- Mengurangi stok buku yang hilang 
UPDATE books
SET copies_available = copies_available - 1
WHERE id IN (1,2,3);

# NOMOR 3
-- -------- CARA 1 : Menghapus riwayat borrowing---------


-- Menghapus Alice di tabel borrowings dan member 
DELETE FROM borrowings
WHERE member_id = 2;

DELETE FROM members
WHERE id = 2;

-- Update type ke standar lalu hapus Bob
UPDATE members
	SET membership_type = "Standar"
WHERE id = 3;

DELETE FROM borrowings
	WHERE member_id = 3;

DELETE FROM members
	WHERE id = 3;


-- >------ CARA 2 : HANYA MENGUPDATE membership_type -------<
UPDATE members
	SET membership_type = ""
	WHERE id = 2;

UPDATE members
	SET membership_type = "Standar"
	WHERE id = 3;

UPDATE members
	SET membership_type = ""
	WHERE id = 3;



########## -UTILITY
SELECT * FROM authors;
SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM borrowings;


-- HARUS BERURUTAN
DELETE FROM borrowings;
DELETE FROM members;
DELETE FROM books;
DELETE FROM authors;
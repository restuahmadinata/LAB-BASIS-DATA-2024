-- NOMOR 1 --
CREATE DATABASE library;
USE library;

CREATE TABLE authors (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL
);

CREATE TABLE books (
	id INT PRIMARY KEY AUTO_INCREMENT,             
	isbn CHAR(13),
	title VARCHAR(100) NOT NULL,
	author_id INT,
	FOREIGN KEY(author_id) REFERENCES authors(id)
);

-- NOMOR 2 --
ALTER TABLE authors
ADD nationality VARCHAR(50);

-- NOMOR 3 --
ALTER TABLE books
MODIFY isbn VARCHAR(13) UNIQUE;

-- NOMOR 4
DESCRIBE authors;
DESCRIBE books;

-- NOMOR 5
CREATE TABLE members (
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	phone_number CHAR(10),
	join_date DATE NOT NULL,
	membership_type VARCHAR(50) NOT NULL
);

CREATE TABLE borrowings (
	id INT PRIMARY KEY AUTO_INCREMENT,
	borrow_date DATE NOT NULL,
	return_date DATE,
	member_id INT NOT NULL,
	book_id INT NOT NULL,
	FOREIGN KEY(member_id) REFERENCES members(id),
	FOREIGN KEY(book_id) REFERENCES books(id)
);

ALTER TABLE books
	ADD published_year YEAR NOT NULL,
	ADD genre VARCHAR(50) NOT NULL,
	ADD copies_available INT NOT NULL,
	MODIFY title VARCHAR(150) NOT NULL,
	MODIFY isbn CHAR(13) UNIQUE NOT NULL;

ALTER TABLE books
	MODIFY author_id INT NOT NULL;

ALTER TABLE authors
	MODIFY nationality VARCHAR(50) NOT NULL;

-- MENAMPILKAN SEMUA TABLE
DESCRIBE members;
DESCRIBE borrowings;
DESCRIBE books;
DESCRIBE authors;

-- HATI-HATI
DROP DATABASE library;

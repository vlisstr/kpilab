INSERT INTO Publisher (name_and_surname, address, phone, publisher_id) VALUES
('HarperCollins', 'New York, USA', '+1-202-555-0147', 1),
('Penguin Books', 'London, UK', '+44-20-1234-5678', 2),
('Bloomsbury Publishing', 'London, UK', '+44-20-9876-5432', 3),
('Faber & Faber', 'London, UK', '+44-20-1111-2222', 4),
('Macmillan Publishers', 'Berlin, Germany', '+49-30-555-4444', 5);

INSERT INTO Author (full_name, birth_date) VALUES
('George Orwell', '1903-06-25'),
('Stephen King', '1947-09-21'),
('J. K. Rowling', '1965-07-31'),
('Agatha Christie', '1890-09-15'),
('Ray Bradbury', '1920-08-22'),
('Haruki Murakami', '1949-01-12'),
('Tara Westover', '1986-09-27'),
('Dan Brown', '1964-06-22');

INSERT INTO Book (isbn, title, year_published, genre, publisher_id) VALUES
('9780451524935', '1984', 1949, 'Dystopian', 1),
('9780307743657', 'The Shining', 1977, 'Horror', 2),
('9780439064871', 'Harry Potter and the Sorcerer''s Stone', 1997, 'Fantasy', 3),
('9780007136834', 'Murder on the Orient Express', 1934, 'Mystery', 4),
('9781451673319', 'Fahrenheit 451', 1953, 'Science Fiction', 1),
('9780307388883', 'Kafka on the Shore', 2002, 'Fantasy', 5),
('9780399590504', 'Educated', 2018, 'Biography', 5),
('9780307474272', 'The Da Vinci Code', 2003, 'Thriller', 2);

INSERT INTO BookAuthor (book_id, author_id)
SELECT b.book_id, a.author_id
FROM Book b
JOIN Author a ON
(
    (b.title = '1984' AND a.full_name = 'George Orwell') OR
    (b.title = 'The Shining' AND a.full_name = 'Stephen King') OR
    (b.title = 'Harry Potter and the Sorcerer''s Stone' AND a.full_name = 'J. K. Rowling') OR
    (b.title = 'Murder on the Orient Express' AND a.full_name = 'Agatha Christie') OR
    (b.title = 'Fahrenheit 451' AND a.full_name = 'Ray Bradbury') OR
    (b.title = 'Kafka on the Shore' AND a.full_name = 'Haruki Murakami') OR
    (b.title = 'Educated' AND a.full_name = 'Tara Westover') OR
    (b.title = 'The Da Vinci Code' AND a.full_name = 'Dan Brown')
);

INSERT INTO Member (full_name, email, phone, address, member_type) VALUES
('Alice Brown', 'alice.b@example.com', '+380-555-111', 'Kyiv', 'Student'),
('Daria Teteruk', 'daria.t@example.com', '+380-974-818-332', 'Kyiv, Akademika Yanhelia St.', 'Student'),
('Diana Oleynikova', 'diana@example.com', '+380-675-555', 'Kyiv', 'Student'),
('Mark Spencer', 'mark.s@example.com', '+380-777-444', 'Lviv', 'Teacher'),
('Ivan Petrov', 'ivan.p@example.com', '+380-666-222', 'Odesa', 'Student');

UPDATE Member
SET address = 'Kyiv, Mykhaila Braichevskoho Street 8'
WHERE full_name = 'Diana Oleynikova';

INSERT INTO Copy (book_id, condition, is_availible)
SELECT book_id, condition, is_availible
FROM (
    VALUES
        ('1984', 'Good', TRUE),
        ('1984', 'Used', TRUE),
        ('The Shining', 'Excellent', TRUE),
        ('Harry Potter and the Sorcerer''s Stone', 'Good', FALSE),
        ('Murder on the Orient Express', 'Good', TRUE),
        ('Fahrenheit 451', 'Excellent', TRUE),
        ('Kafka on the Shore', 'Good', TRUE),
        ('Educated', 'New', TRUE),
        ('The Da Vinci Code', 'Used', FALSE)
) AS v(title, condition, is_availible)
JOIN Book b ON b.title = v.title;

INSERT INTO Loan (copy_id, member_id, loan_date, due_date, return_date, fine_amount)
SELECT c.copy_id, m.member_id, l.loan_date, l.due_date, l.return_date, l.fine_amount
FROM (
    VALUES
        ('The Shining', 1, DATE '2025-01-10', DATE '2025-01-20', NULL, 0),
        ('Harry Potter and the Sorcerer''s Stone', 2, DATE '2025-01-05', DATE '2025-01-15', DATE '2025-01-17', 5.00),
        ('Educated', 3, DATE '2025-01-03', DATE '2025-01-12', NULL, 0),
        ('1984', 4, DATE '2025-01-08', DATE '2025-01-18', NULL, 0)
) AS l(title, member_number, loan_date, due_date, return_date, fine_amount)
JOIN Book b ON b.title = l.title
JOIN Copy c ON c.book_id = b.book_id
JOIN Member m ON m.member_id = l.member_number;

SELECT book_id, title, genre, year_published FROM Book;

SELECT copy_id, book_id, condition 
FROM Copy
WHERE is_availible = TRUE;

SELECT title, genre 
FROM Book
WHERE genre = 'Science Fiction';

SELECT b.title, a.full_name
FROM Book b
JOIN BookAuthor ba ON b.book_id = ba.book_id
JOIN Author a ON ba.author_id = a.author_id;

SELECT l.loan_id, m.full_name, b.title, l.loan_date, l.due_date
FROM Loan l
JOIN Copy c ON l.copy_id = c.copy_id
JOIN Book b ON c.book_id = b.book_id
JOIN Member m ON l.member_id = m.member_id
WHERE l.return_date IS NULL;

SELECT b.title, p.name_and_surname AS publisher
FROM Book b
JOIN Publisher p ON b.publisher_id = p.publisher_id;

SELECT m.full_name, b.title, l.loan_date
FROM Loan l
JOIN Member m ON l.member_id = m.member_id
JOIN Copy c ON l.copy_id = c.copy_id
JOIN Book b ON c.book_id = b.book_id;

SELECT title, year_published
FROM Book
WHERE year_published > 1950;

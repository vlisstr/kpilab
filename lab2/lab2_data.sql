INSERT INTO Publisher (name_and_surname, address, phone) VALUES
('Penguin Books', 'London, UK', '+44-20-1234-5678'),
('HarperCollins', 'New York, USA', '+1-212-555-1234');

INSERT INTO Author (full_name, birth_date) VALUES
('George Orwell', '1903-06-25'),
('Harper Lee', '1926-04-28');

INSERT INTO Book (isbn, title, year_published, genre, publisher_id) VALUES
('9780143127796', '1984', 1949, 'Dystopian', 7),
('9780061120084', 'To Kill a Mockingbird', 1960, 'Fiction', 8);

INSERT INTO BookAuthor (book_id, author_id) VALUES
(9, 7),
(10, 8);

INSERT INTO Copy (book_id, condition, is_availible) VALUES
(9, 'Good', TRUE),
(10, 'Worn', FALSE);

INSERT INTO Member (full_name, email, phone, address, member_type) VALUES
('Diana Oleynikova', 'diana@example.com', '+380-994-817-658', 'Starokostiantynivske highway', 'Student'),
('Bob Smith', 'bob@example.com', '+1-555-0002', '456 Elm St', 'Regular');

INSERT INTO Loan (copy_id, member_id, loan_date, due_date, return_date, fine_amount) VALUES
(4, 1, '2025-11-01', '2025-11-08', '2025-11-07', 0.00),
(5, 2, '2025-11-03', '2025-11-10', NULL, 2.50);



-- Counts how many books exist in the database
SELECT COUNT(*) AS total_books
FROM Book;

-- Counts all physical copies
SELECT COUNT(*) AS total_copies
FROM Copy;

-- Calculates the average fine amount
SELECT AVG(fine_amount) AS average_fine
FROM Loan;

-- Finds the most recent book publication year
SELECT MAX(year_published) AS newest_book_year
FROM Book;

-- Counts the number of copies for each book
SELECT book_id, COUNT(*) AS number_of_copies
FROM Copy
GROUP BY book_id;

-- Shows how many loans each member has made
SELECT member_id, COUNT(*) AS loans_count
FROM Loan
GROUP BY member_id;

-- Finds books that have more than one copy
SELECT book_id, COUNT(*) AS copies_count
FROM Copy
GROUP BY book_id
HAVING COUNT(*) > 1;

-- Shows members whose total fines exceed 1
SELECT member_id, SUM(fine_amount) AS total_fines
FROM Loan
GROUP BY member_id
HAVING SUM(fine_amount) > 1;

-- Displays books with their publishers
SELECT b.title, p.name_and_surname AS publisher
FROM Book b
INNER JOIN Publisher p ON b.publisher_id = p.publisher_id;

-- Lists all books and their copies (including books with no copies)
SELECT b.title, c.copy_id, c.is_availible
FROM Book b
LEFT JOIN Copy c ON b.book_id = c.book_id;

-- Lists all members and all loans, even unmatched ones
SELECT m.full_name, l.loan_id, l.loan_date
FROM Member m
FULL JOIN Loan l ON m.member_id = l.member_id;

-- Shows how many books each author has written
SELECT a.full_name, COUNT(ba.book_id) AS books_written
FROM Author a
JOIN BookAuthor ba ON a.author_id = ba.author_id
GROUP BY a.full_name;

-- Counts how many times each book has been loaned
SELECT b.title, COUNT(l.loan_id) AS loans_count
FROM Book b
JOIN Copy c ON b.book_id = c.book_id
LEFT JOIN Loan l ON c.copy_id = l.copy_id
GROUP BY b.title;

-- Calculates total fines for each member
SELECT m.full_name, SUM(l.fine_amount) AS total_fines
FROM Member m
LEFT JOIN Loan l ON m.member_id = l.member_id
GROUP BY m.full_name;

-- Subquery in SELECT: counts copies for each book
SELECT 
    title,
    (SELECT COUNT(*) FROM Copy c WHERE c.book_id = b.book_id) AS copies_count
FROM Book b;

-- Subquery in WHERE: finds copies that are currently loaned out
SELECT *
FROM Copy
WHERE copy_id IN (
    SELECT copy_id
    FROM Loan
    WHERE return_date IS NULL
);

-- Subquery in HAVING: authors who wrote more than one book
SELECT full_name
FROM Author
WHERE author_id IN (
    SELECT author_id
    FROM BookAuthor
    GROUP BY author_id
    HAVING COUNT(book_id) > 1
);
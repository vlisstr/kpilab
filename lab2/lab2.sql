--lab2 db--
CREATE TABLE Publisher(
    publisher_id SERIAL PRIMARY KEY,
    name_and_surname VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    phone VARCHAR(20)
);

CREATE TABLE Author (
    author_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE
);

CREATE TABLE Book (
    book_id SERIAL PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(150) NOT NULL,
    year_published INT,
    genre VARCHAR(50),
    publisher_id INT REFERENCES Publisher(publisher_id) ON DELETE SET NULL
);

CREATE TABLE BookAuthor (
    book_id INT REFERENCES Book(book_id) ON DELETE CASCADE,
    author_id INT REFERENCES Author(author_id) ON DELETE CASCADE,
    PRIMARY KEY (book_id, author_id)
);

CREATE TABLE Copy (
    copy_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES Book(book_id) ON DELETE CASCADE,
    condition VARCHAR(50),
    is_availible BOOLEAN DEFAULT TRUE
);

CREATE TABLE Member (
    member_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(200),
    member_type VARCHAR(20),
    join_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE Loan (
    loan_id SERIAL PRIMARY KEY,
    copy_id INT REFERENCES Copy(copy_id) ON DELETE CASCADE,
    member_id INT REFERENCES Member(member_id) ON DELETE CASCADE,
    loan_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE,
    return_date DATE,
    fine_amount NUMERIC(10,2)
);

export interface Publisher {
  publisherID: number; // PK
  name: string;
  address?: string;
  phone?: string;
}

export interface Book {
  bookID: number;      // PK
  isbn: string;        // UNIQUE
  title: string;
  yearPublished: number;
  genre: string;
  publisherID: number; // FK -> Publisher
}

export interface Author {
  authorID: number;    // PK
  fullName: string;
  birthDate?: string;  // ISO Date string
}

/** Сводная таблица для связи Многие-ко-Многим (M2M) */
export interface BookAuthor {
  bookID: number;      // PK, FK -> Book
  authorID: number;    // PK, FK -> Author
}

export interface Copy {
  copyID: number;      // PK
  bookID: number;      // FK -> Book
  condition: 'New' | 'Good' | 'Fair' | 'Poor'; // Литеральный тип для надежности
  isAvailable: boolean;
}

export interface Member {
  memberID: number;    // PK
  fullName: string;
  email: string;       // UNIQUE
  phone: string;
  address: string;
  memberType: string;  // Например: 'Student', 'Regular', 'Premium'
  joinDate: string;    // ISO Date string
}

export interface Loan {
  loanID: number;      // PK
  copyID: number;      // FK -> Copy
  memberID: number;    // FK -> Member
  loanDate: string;
  dueDate: string;
  returnDate?: string; // null, если книга еще не возвращена
  fineAmount?: number; // По умолчанию 0
}

package pl.uken.krakow.library.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pl.uken.krakow.library.model.Book;
import pl.uken.krakow.library.model.User;
import pl.uken.krakow.library.repository.BookRepository;
import pl.uken.krakow.library.repository.UserRepository;

import java.time.LocalDate;
import java.util.List;

@Service
public class BookService {

    private final BookRepository bookRepository;
    @Autowired
    public BookService(BookRepository bookRepository, UserRepository userRepository) {
        this.bookRepository = bookRepository;
    }

    public List<Book> getAllBooks() { 
        return bookRepository.findAll(); 
    }

    public void reserveBook(Long bookId, User user) {
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new IllegalArgumentException("Nie znaleziono książki o id: " + bookId));
        book.setAvailable(false);
        book.setReservedBy(user);
        book.setReservationDate(LocalDate.now());
        book.setReservationDue(LocalDate.now().plusDays(7));
        bookRepository.save(book);
    }

    public void makeBookAvailable(Long bookId) { 
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new IllegalArgumentException("Nie znaleziono książki o id: " + bookId)); 
        book.setAvailable(true); 
        book.setReservedBy(null);
        book.setReservationDate(null);
        book.setReservationDue(null);
        book.setBorrowedBy(null);
        book.setLoanDate(null);
        book.setLoanDue(null);
        book.setProlonged(false);
        bookRepository.save(book);
    }

    public Book findBookById(Long id) { 
        return bookRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Nie znaleziono książki o id: " + id)); 
    }

    public void loanBook(Long bookId, User user) {
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new IllegalArgumentException("Nie znaleziono książki o id: " + bookId));
        book.setAvailable(false);
        book.setReservationDate(null);
        book.setReservationDue(null);
        book.setReservedBy(null);
        book.setBorrowedBy(user);
        book.setLoanDate(LocalDate.now());
        book.setLoanDue(LocalDate.now().plusDays(30));
        bookRepository.save(book);
    }

    public List<Book> searchByTitle(String title) { 
        return bookRepository.findByTitleContainingIgnoreCase(title); 
    } 
    
    public List<Book> searchByAuthor(String author) { 
        return bookRepository.findByAuthorContainingIgnoreCase(author); 
    } 
    
    public List<Book> searchByGenre(String genre) { 
        return bookRepository.findByGenreContainingIgnoreCase(genre); 
    }

    public List<Book> findReservedBooksByUser(User user) { 
        return bookRepository.findByReservedBy(user); 
    } 

    public List<Book> findBorrowedBooksByUser(User user) { 
        return bookRepository.findByBorrowedBy(user); 
    }

    public void cancelReservation(Long bookId, User user) {
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new IllegalArgumentException("Nie znaleziono książki o id: " + bookId));
        if (book.getReservedBy().getId().equals(user.getId())) {
            book.setAvailable(true);
            book.setReservedBy(null);
            book.setReservationDate(null);
            book.setReservationDue(null);
            bookRepository.save(book);
        } else {
            throw new IllegalArgumentException("Nie masz uprawnień do anulowania tej rezerwacji.");
        }
    }
    
    public void prolongLoan(Long bookId, User user) {
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new IllegalArgumentException("Nie znaleziono książki o id: " + bookId));
        if (book.getBorrowedBy().getId().equals(user.getId()) && !book.isProlonged()) {
            book.setLoanDue(book.getLoanDue().plusDays(30));
            book.setProlonged(true);
            bookRepository.save(book);
        } else {
            throw new IllegalArgumentException("Nie można przedłużyć wypożyczenia.");
        }
    }

    public void addBook(Book book) { 
        bookRepository.save(book); 
    }

    public void deleteBook(int bookId) {
        bookRepository.deleteById(bookId);
    }
    
    public void updateAvailabilityBasedOnReservationDue() {
        List<Book> books = bookRepository.findAll();
        LocalDate today = LocalDate.now();
        
        for (Book book : books) {
            if (book.getReservationDue() != null && book.getReservationDue().isEqual(today)) {
                book.setAvailable(true);
                book.setReservedBy(null);
                book.setReservationDate(null);
                book.setReservationDue(null);
                bookRepository.save(book);
            }
        }
    }
}

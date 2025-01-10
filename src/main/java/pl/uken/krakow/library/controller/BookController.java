package pl.uken.krakow.library.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import pl.uken.krakow.library.model.Book;
import pl.uken.krakow.library.model.User;
import pl.uken.krakow.library.service.BookService;
import pl.uken.krakow.library.service.UserService;
import java.util.List;

@Controller
public class BookController {

    private final BookService bookService;
    private final UserService userService;

    @Autowired
    public BookController(BookService bookService, UserService userService) {
        this.bookService = bookService;
        this.userService = userService;
    }

    @GetMapping("/books")
public String showBooks(HttpSession session, Model model) {
    User loggedUser = (User) session.getAttribute("loggedUser");
    if (loggedUser == null) {
        return "redirect:/login";
    }

    model.addAttribute("username", loggedUser.getUsername());
    model.addAttribute("books", bookService.getAllBooks());
    return "books";
}

    @GetMapping("/")
    public String showBooksPage(HttpSession session, Model model) {
        User loggedUser = (User) session.getAttribute("loggedUser");
    if (loggedUser == null) {
        return "redirect:/login";
    }

    model.addAttribute("username", loggedUser.getUsername());
    model.addAttribute("books", bookService.getAllBooks());
    return "books";
    }

    @GetMapping("/userBooks") 
    public String showUserBooks(HttpSession session, Model model) { 
        User loggedUser = (User) session.getAttribute("loggedUser"); 
        if (loggedUser == null) { 
            return "redirect:/login"; 
        } List<Book> reservedBooks = bookService.findReservedBooksByUser(loggedUser); 
        List<Book> borrowedBooks = bookService.findBorrowedBooksByUser(loggedUser); 
        model.addAttribute("username", loggedUser.getUsername()); 
        model.addAttribute("reservedBooks", reservedBooks); 
        model.addAttribute("borrowedBooks", borrowedBooks); 
        return "userBooks"; 
    }

    @GetMapping("/reserveBook/{id}") 
    public String reserveBook(@PathVariable Long id, HttpSession session, Model model) { 
        User loggedUser = (User) session.getAttribute("loggedUser"); 
        if (loggedUser != null) { 
            if ("librarian".equals(loggedUser.getRole())) { 
                bookService.makeBookAvailable(id); 
                model.addAttribute("message", "Książka została ustawiona jako dostępna!"); 
            } else { 
                bookService.reserveBook(id, loggedUser); 
                model.addAttribute("message", "Zarezerwowano książkę!"); 
            } 
            return "redirect:/books"; } 
            else { 
                return "redirect:/login"; } 
            }

    @GetMapping("/findBook") 
    public String findBook(@RequestParam("bookId") Long bookId, HttpSession session, Model model) { 
        User loggedUser = (User) session.getAttribute("loggedUser"); 
        if (loggedUser != null && "librarian".equals(loggedUser.getRole())) { 
            try { 
                Book book = bookService.findBookById(bookId); 
                model.addAttribute("books", List.of(book)); 
                model.addAttribute("username", loggedUser.getUsername()); 
                return "books"; 
            } catch (IllegalArgumentException e) { 
                model.addAttribute("error", e.getMessage()); 
                model.addAttribute("books", bookService.getAllBooks()); 
                return "books"; 
            } 
        } else { 
            return "redirect:/login"; 
        } 
    }

    @GetMapping("/loanBook/{id}") 
    public String loanBookForm(@PathVariable Long id, HttpSession session, Model model) { 
        User loggedUser = (User) session.getAttribute("loggedUser"); 
        if (loggedUser != null && "librarian".equals(loggedUser.getRole())) { 
            Book book = bookService.findBookById(id); 
            model.addAttribute("book", book); 
            return "loanBook"; 
        } else { 
            return "redirect:/login"; 
        } 
    } 
    
    @PostMapping("/loanBook/{id}") 
    public String loanBook(@PathVariable Long id, @RequestParam String username, HttpSession session, Model model) { 
        User loggedUser = (User) session.getAttribute("loggedUser"); 
        if (loggedUser != null && "librarian".equals(loggedUser.getRole())) { 
            User user = userService.findByUsername(username).orElseThrow(() -> new IllegalArgumentException("Nie znaleziono użytkownika o nazwie: " + username)); 
            bookService.loanBook(id, user); 
            model.addAttribute("message", "Książka została wypożyczona!"); 
            return "redirect:/books"; 
        } else { 
            return "redirect:/login"; 
        } 
    }

    @GetMapping("/search") 
    public String searchBooks(@RequestParam("criteria") String criteria, @RequestParam("query") String query, Model model) { 
        List<Book> books; 
        if ("title".equalsIgnoreCase(criteria)) { 
            books = bookService.searchByTitle(query); 
        } else if ("author".equalsIgnoreCase(criteria)) { 
            books = bookService.searchByAuthor(query); 
        } else if ("genre".equalsIgnoreCase(criteria)) { 
            books = bookService.searchByGenre(query); 
        } else { 
            books = bookService.getAllBooks(); 
        } 
        model.addAttribute("books", books); 
        return "books"; 
    }

    @GetMapping("/cancelReservation/{id}") 
    public String cancelReservation(@PathVariable Long id, HttpSession session, Model model) { 
    User loggedUser = (User) session.getAttribute("loggedUser"); 
        if (loggedUser != null) {
            bookService.cancelReservation(id, loggedUser); 
            List<Book> reservedBooks = bookService.findReservedBooksByUser(loggedUser);
            List<Book> borrowedBooks = bookService.findBorrowedBooksByUser(loggedUser);
            model.addAttribute("username", loggedUser.getUsername());
            model.addAttribute("reservedBooks", reservedBooks);
            model.addAttribute("borrowedBooks", borrowedBooks);
            model.addAttribute("message", "Anulowano rezerwację!"); 
            return "userBooks"; 
        } else { 
            return "redirect:/login"; 
        } 
    }

    @GetMapping("/prolongLoan/{id}")
    public String prolongLoan(@PathVariable Long id, HttpSession session, Model model) {
    User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser != null) {
            try {
                bookService.prolongLoan(id, loggedUser);
                model.addAttribute("message", "Wypożyczenie zostało przedłużone o kolejne 30 dni.");
            } catch (IllegalArgumentException e) {
                model.addAttribute("error", e.getMessage());
            }
            List<Book> reservedBooks = bookService.findReservedBooksByUser(loggedUser);
            List<Book> borrowedBooks = bookService.findBorrowedBooksByUser(loggedUser);
            model.addAttribute("username", loggedUser.getUsername());
            model.addAttribute("reservedBooks", reservedBooks);
            model.addAttribute("borrowedBooks", borrowedBooks);
            return "userBooks";
        } else {
            return "redirect:/login";
        }
    }

    @GetMapping("/addBook")
    public String showAddBookForm(HttpSession session, Model model) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser != null && "librarian".equals(loggedUser.getRole())) {
            model.addAttribute("book", new Book());
            return "addBook";
        } else {
            return "redirect:/login";
        }
    }

    @PostMapping("/addBook")
    public String addBook(@ModelAttribute("book") Book book, HttpSession session, Model model) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser != null && "librarian".equals(loggedUser.getRole())) {
            bookService.addBook(book);
            model.addAttribute("message", "Książka została dodana pomyślnie.");
            return "redirect:/books";
        } else {
            return "redirect:/login";
        }
    }

    @GetMapping("/deleteBook/{id}")
    public String deleteBook(@PathVariable int id, HttpSession session, Model model) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser != null && "librarian".equals(loggedUser.getRole())) {
            bookService.deleteBook(id);
            model.addAttribute("message", "Książka została usunięta.");
            return "redirect:/books";
        } else {
            return "redirect:/login";
        }
    }

    @GetMapping("/updateAvailability/{id}")
    public String updateAvailability(@PathVariable Long id, HttpSession session, Model model) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser != null && "librarian".equals(loggedUser.getRole())) {
            bookService.makeBookAvailable(id);
            model.addAttribute("message", "Książka została ustawiona jako dostępna!");
            return "redirect:/books";
        } else {
            return "redirect:/login";
        }
    }



}
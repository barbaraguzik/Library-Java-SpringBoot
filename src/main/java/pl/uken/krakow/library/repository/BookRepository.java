package pl.uken.krakow.library.repository;

import java.util.Optional;
import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import pl.uken.krakow.library.model.Book;
import pl.uken.krakow.library.model.User;

@Repository
public interface BookRepository extends JpaRepository<Book, Integer> {
    Optional<Book> findById(Long id);
    List<Book> findByReservedBy (User user);
    List<Book> findByBorrowedBy (User user);
    List<Book> findByTitleContainingIgnoreCase(String title); 
    List<Book> findByAuthorContainingIgnoreCase(String author); 
    List<Book> findByGenreContainingIgnoreCase(String genre);
}

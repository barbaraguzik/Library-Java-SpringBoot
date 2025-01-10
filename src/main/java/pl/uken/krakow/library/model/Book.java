package pl.uken.krakow.library.model;

import java.time.LocalDate;
import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name="books", 
       indexes = {
           @Index(name = "idx_title", columnList = "title"),
           @Index(name = "idx_author", columnList = "author")
       })
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(nullable = false, length = 255)
    private String title;

    @Column(nullable = false, length = 255)
    private String author;

    @Column(nullable = false, length = 255)
    private String genre;

    @Column(nullable = false)
    private boolean available = true;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reserved_by")
    private User reservedBy;

    @Column
    private LocalDate reservationDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "borrowed_by")
    private User borrowedBy;

    @Column
    private LocalDate loanDate;

    @Column
    private LocalDate loanDue;

    @Column
    private LocalDate reservationDue;

    @Column(nullable = false)
    private boolean prolonged = false;
}

package pl.uken.krakow.library.tasks;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import pl.uken.krakow.library.service.BookService;

@Component
public class DeleteReservation {

    @Autowired
    private BookService bookService;

    @Scheduled(cron = "0 59 23 * * ?")  
    public void updateBookAvailability() {
        bookService.updateAvailabilityBasedOnReservationDue();
    }

}

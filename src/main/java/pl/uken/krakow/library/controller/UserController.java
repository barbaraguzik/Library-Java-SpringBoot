package pl.uken.krakow.library.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpSession;
import pl.uken.krakow.library.model.User;
import pl.uken.krakow.library.service.UserService;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Value("${librarian.access.key}")
    private String librarianAccessKey;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, Model model) {
        try {
            userService.registerUser(user);
            return "redirect:/login";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "register";
        }
    }

    @GetMapping("/registerLibrarian")
    public String showLibrarianRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "registerLibrarian";
    }

    @PostMapping("/registerLibrarian")
    public String registerLibrarian(@ModelAttribute User user, @RequestParam String accessKey, Model model) {
        if (!accessKey.equals(librarianAccessKey)) {
            model.addAttribute("error", "Nieprawidłowy klucz dostępu.");
            return "registerLibrarian";
        }
        try {
            userService.addLibrarian(user.getUsername(), user.getPassword(), user.getEmail());
            return "redirect:/login";
        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());
            return "registerLibrarian";
        }
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String username, @RequestParam String password, HttpSession session, Model model) {
        User user = userService.validateUser(username, password);
        if (user != null) {
            session.setAttribute("loggedUser", user);
            return "redirect:/books";
        } else {
            model.addAttribute("error", "Nieprawidłowa nazwa użytkownika lub hasło");
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/myPage")
    public String showMyPage(HttpSession session, Model model) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser != null) {
            model.addAttribute("user", loggedUser);
            return "userPage";
        } else {
            return "redirect:/login";
        }
    }

    @GetMapping("/deleteAccount")
    public String deleteAccount(HttpSession session, Model model) {
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (loggedUser != null) {
            userService.deleteAccount(loggedUser.getId());
            session.invalidate();
            model.addAttribute("message", "Twoje konto zostało usunięte.");
            return "redirect:/login";
        } else {
            return "redirect:/login";
        }
    }

    @GetMapping("/users")
    public String showUserList(Model model) {
        List<User> users = userService.getUsersByRole("user");
        model.addAttribute("users", users);
        return "userList";
    }
}

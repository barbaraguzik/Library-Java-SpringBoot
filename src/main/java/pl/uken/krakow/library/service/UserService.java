package pl.uken.krakow.library.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import pl.uken.krakow.library.model.User;
import pl.uken.krakow.library.repository.UserRepository;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {
    private final UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User validateUser(String username, String password) {
        Optional<User> userOpt = userRepository.findByUsername(username);
        if (userOpt.isPresent() && userOpt.get().getPassword().equals(password)) {
            return userOpt.get();
        }
        return null;
    }

    public void registerUser(User user) throws Exception {
        if (userRepository.existsByUsername(user.getUsername())) {
            throw new Exception("Nazwa użytkownika jest już zajęta.");
        }
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new Exception("Adres e-mail jest już używany.");
        }
        userRepository.save(user);
    }

    public void addLibrarian(String username, String password, String email) throws Exception {
        if (userRepository.existsByUsername(username)) {
            throw new Exception("Nazwa użytkownika jest już zajęta.");
        }
        if (userRepository.existsByEmail(email)) {
            throw new Exception("Adres e-mail jest już używany.");
        }
        User librarian = new User();
        librarian.setUsername(username);
        librarian.setPassword(password);
        librarian.setEmail(email);
        librarian.setRole("librarian");
        userRepository.save(librarian);
    }

    public void deleteAccount(Long id) {
        userRepository.deleteById(id);
    }

    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public boolean userExists(String username) {
        return userRepository.existsByUsername(username);
    }

    public List<User> getAllUsers() { 
        return userRepository.findAll(); 
    }

    public List<User> getUsersByRole(String role) {
        return userRepository.findByRole(role);
    }
}

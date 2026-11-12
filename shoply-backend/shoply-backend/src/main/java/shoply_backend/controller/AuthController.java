package shoply_backend.controller;

import shoply_backend.entity.UserEntity;
import shoply_backend.repository.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")
public class AuthController {

    private final UserRepository userRepository;

    public AuthController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> request) {
        String email = request.getOrDefault("email", "").trim();
        String password = request.getOrDefault("password", "");

        Optional<UserEntity> userOpt = userRepository.findByEmail(email);
        if (userOpt.isEmpty() || !userOpt.get().getPassword().equals(password)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body(Map.of("message", "Неверный email или пароль"));
        }

        UserEntity user = userOpt.get();
        return ResponseEntity.ok(Map.of(
                "id", user.getId(),
                "name", user.getName(),
                "email", user.getEmail(),
                "token", "token-user-" + user.getId()
        ));
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody Map<String, String> request) {
        String name = request.getOrDefault("name", "").trim();
        String email = request.getOrDefault("email", "").trim();
        String password = request.getOrDefault("password", "");

        if (name.isEmpty() || email.isEmpty() || password.length() < 6) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "Заполните все поля (пароль от 6 символов)"));
        }

        if (userRepository.existsByEmail(email)) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "Пользователь с таким email уже существует"));
        }

        UserEntity savedUser = userRepository.save(new UserEntity(name, email, password));
        return ResponseEntity.ok(Map.of(
                "id", savedUser.getId(),
                "name", savedUser.getName(),
                "email", savedUser.getEmail(),
                "token", "token-user-" + savedUser.getId()
        ));
    }
}
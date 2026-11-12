package shoply_backend.controller;

import shoply_backend.entity.CartItemEntity;
import shoply_backend.entity.ProductEntity;
import shoply_backend.repository.CartItemRepository;
import shoply_backend.repository.ProductRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/cart")
@CrossOrigin(origins = "*")
public class CartController {

    private final CartItemRepository cartItemRepository;
    private final ProductRepository productRepository;

    public CartController(
            CartItemRepository cartItemRepository,
            ProductRepository productRepository
    ) {
        this.cartItemRepository = cartItemRepository;
        this.productRepository = productRepository;
    }

    private Long extractUserId(String authHeader) {
        if (authHeader != null && authHeader.startsWith("Bearer token-user-")) {
            try {
                return Long.parseLong(authHeader.replace("Bearer token-user-", "").trim());
            } catch (NumberFormatException ignored) {
            }
        }
        return 1L;
    }

    @GetMapping
    public List<CartItemEntity> getCart(
            @RequestHeader(value = "Authorization", required = false) String authHeader
    ) {
        Long userId = extractUserId(authHeader);
        return cartItemRepository.findByUserId(userId);
    }

    @PostMapping("/items")
    public ResponseEntity<?> addToCart(
            @RequestHeader(value = "Authorization", required = false) String authHeader,
            @RequestBody Map<String, Object> body
    ) {
        Long userId = extractUserId(authHeader);
        Long productId = ((Number) body.get("productId")).longValue();
        int quantity = body.get("quantity") != null
                ? ((Number) body.get("quantity")).intValue()
                : 1;

        Optional<ProductEntity> productOpt = productRepository.findById(productId);
        if (productOpt.isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("message", "Товар не найден"));
        }

        Optional<CartItemEntity> existingOpt =
                cartItemRepository.findByUserIdAndProduct_Id(userId, productId);

        if (existingOpt.isPresent()) {
            CartItemEntity existing = existingOpt.get();
            existing.setQuantity(existing.getQuantity() + quantity);
            cartItemRepository.save(existing);
        } else {
            cartItemRepository.save(new CartItemEntity(userId, productOpt.get(), quantity));
        }

        return ResponseEntity.ok(cartItemRepository.findByUserId(userId));
    }

    @PutMapping("/items/{productId}")
    public ResponseEntity<?> updateQuantity(
            @RequestHeader(value = "Authorization", required = false) String authHeader,
            @PathVariable Long productId,
            @RequestBody Map<String, Object> body
    ) {
        Long userId = extractUserId(authHeader);
        int quantity = ((Number) body.get("quantity")).intValue();

        if (quantity <= 0) {
            cartItemRepository.deleteByUserIdAndProduct_Id(userId, productId);
        } else {
            cartItemRepository.findByUserIdAndProduct_Id(userId, productId)
                    .ifPresent(item -> {
                        item.setQuantity(quantity);
                        cartItemRepository.save(item);
                    });
        }

        return ResponseEntity.ok(cartItemRepository.findByUserId(userId));
    }

    @DeleteMapping("/items/{productId}")
    public ResponseEntity<?> removeFromCart(
            @RequestHeader(value = "Authorization", required = false) String authHeader,
            @PathVariable Long productId
    ) {
        Long userId = extractUserId(authHeader);
        cartItemRepository.deleteByUserIdAndProduct_Id(userId, productId);
        return ResponseEntity.ok(cartItemRepository.findByUserId(userId));
    }

    @DeleteMapping
    public ResponseEntity<?> clearCart(
            @RequestHeader(value = "Authorization", required = false) String authHeader
    ) {
        Long userId = extractUserId(authHeader);
        cartItemRepository.deleteByUserId(userId);
        return ResponseEntity.ok().build();
    }
}
package shoply_backend.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import shoply_backend.entity.OrderEntity;
import shoply_backend.entity.OrderItemEntity;
import shoply_backend.entity.ProductEntity;
import shoply_backend.repository.CartItemRepository;
import shoply_backend.repository.OrderRepository;
import shoply_backend.repository.ProductRepository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/orders")
@CrossOrigin(origins = "*")
public class OrderController {

    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final CartItemRepository cartItemRepository;

    public OrderController(
            OrderRepository orderRepository,
            ProductRepository productRepository,
            CartItemRepository cartItemRepository
    ) {
        this.orderRepository = orderRepository;
        this.productRepository = productRepository;
        this.cartItemRepository = cartItemRepository;
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
    public List<OrderEntity> getOrders(
            @RequestHeader(value = "Authorization", required = false) String authHeader
    ) {
        Long userId = extractUserId(authHeader);
        return orderRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }

    @PostMapping
    public ResponseEntity<?> createOrder(
            @RequestHeader(value = "Authorization", required = false) String authHeader,
            @RequestBody Map<String, Object> body
    ) {
        Long userId = extractUserId(authHeader);
        String shippingAddress = String.valueOf(body.getOrDefault("shippingAddress", "Не указан"));

        Object itemsObj = body.get("items");
        if (!(itemsObj instanceof List<?> rawItems) || rawItems.isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("message", "Корзина пуста"));
        }

        List<OrderItemEntity> orderItems = new ArrayList<>();
        double totalAmount = 0.0;

        for (Object itemObj : rawItems) {
            if (itemObj instanceof Map<?, ?> rawItem) {
                Object productIdObj = rawItem.get("productId");
                Object quantityObj = rawItem.get("quantity");
                if (productIdObj instanceof Number prodNum && quantityObj instanceof Number qtyNum) {
                    Long productId = prodNum.longValue();
                    int quantity = qtyNum.intValue();

                    ProductEntity product = productRepository.findById(productId).orElse(null);
                    if (product != null) {
                        orderItems.add(new OrderItemEntity(product, quantity));
                        totalAmount += product.getPrice() * quantity;
                    }
                }
            }
        }

        OrderEntity order = new OrderEntity(
                userId,
                orderItems,
                totalAmount,
                "Оформлен",
                shippingAddress,
                LocalDateTime.now()
        );

        OrderEntity savedOrder = orderRepository.save(order);
        cartItemRepository.deleteByUserId(userId);

        return ResponseEntity.ok(savedOrder);
    }
}
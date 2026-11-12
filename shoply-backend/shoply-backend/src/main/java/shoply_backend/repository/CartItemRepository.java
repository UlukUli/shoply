package shoply_backend.repository;

import shoply_backend.entity.CartItemEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

public interface CartItemRepository extends JpaRepository<CartItemEntity, Long> {
    List<CartItemEntity> findByUserId(Long userId);
    Optional<CartItemEntity> findByUserIdAndProduct_Id(Long userId, Long productId);

    @Transactional
    void deleteByUserIdAndProduct_Id(Long userId, Long productId);

    @Transactional
    void deleteByUserId(Long userId);
}
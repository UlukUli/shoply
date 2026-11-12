package shoply_backend.repository;

import shoply_backend.entity.ProductEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ProductRepository extends JpaRepository<ProductEntity, Long> {
    List<ProductEntity> findByCategory_Id(Long categoryId);
    List<ProductEntity> findByTitleContainingIgnoreCase(String title);
    List<ProductEntity> findByCategory_IdAndTitleContainingIgnoreCase(Long categoryId, String title);
}
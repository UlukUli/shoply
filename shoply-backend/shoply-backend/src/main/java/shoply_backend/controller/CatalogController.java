package shoply_backend.controller;

import shoply_backend.entity.CategoryEntity;
import shoply_backend.entity.ProductEntity;
import shoply_backend.repository.CategoryRepository;
import shoply_backend.repository.ProductRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class CatalogController {

    private final CategoryRepository categoryRepository;
    private final ProductRepository productRepository;

    public CatalogController(
            CategoryRepository categoryRepository,
            ProductRepository productRepository
    ) {
        this.categoryRepository = categoryRepository;
        this.productRepository = productRepository;
    }

    @GetMapping("/categories")
    public List<CategoryEntity> getCategories() {
        return categoryRepository.findAll();
    }

    @GetMapping("/products")
    public List<ProductEntity> getProducts(
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) String search
    ) {
        boolean hasSearch = search != null && !search.trim().isEmpty();

        if (categoryId != null && hasSearch) {
            return productRepository.findByCategory_IdAndTitleContainingIgnoreCase(
                    categoryId,
                    search.trim()
            );
        }
        if (categoryId != null) {
            return productRepository.findByCategory_Id(categoryId);
        }
        if (hasSearch) {
            return productRepository.findByTitleContainingIgnoreCase(search.trim());
        }
        return productRepository.findAll();
    }

    @GetMapping("/products/{id}")
    public ResponseEntity<ProductEntity> getProductById(@PathVariable Long id) {
        return productRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
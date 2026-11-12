package shoply_backend.config;

import shoply_backend.entity.CategoryEntity;
import shoply_backend.entity.ProductEntity;
import shoply_backend.entity.UserEntity;
import shoply_backend.repository.CategoryRepository;
import shoply_backend.repository.ProductRepository;
import shoply_backend.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class DataInitializer implements CommandLineRunner {

    private final CategoryRepository categoryRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    public DataInitializer(
            CategoryRepository categoryRepository,
            ProductRepository productRepository,
            UserRepository userRepository
    ) {
        this.categoryRepository = categoryRepository;
        this.productRepository = productRepository;
        this.userRepository = userRepository;
    }

    @Override
    public void run(String... args) {
        if (userRepository.count() == 0) {
            userRepository.save(new UserEntity("Алишер Покупатель", "user@shoply.app", "123456"));
        }

        if (categoryRepository.count() == 0) {
            CategoryEntity electronics = categoryRepository.save(new CategoryEntity("Электроника", "devices"));
            CategoryEntity clothes = categoryRepository.save(new CategoryEntity("Одежда", "checkroom"));
            CategoryEntity shoes = categoryRepository.save(new CategoryEntity("Обувь", "directions_run"));
            CategoryEntity accessories = categoryRepository.save(new CategoryEntity("Аксессуары", "backpack"));
            CategoryEntity home = categoryRepository.save(new CategoryEntity("Для дома", "light"));

            productRepository.saveAll(List.of(
                    new ProductEntity(
                            "Беспроводные наушники Pro",
                            "Полноразмерные наушники с активным шумоподавлением, глубоким басом и автономностью до 30 часов.",
                            8990.0,
                            "demo://headphones",
                            electronics,
                            15,
                            4.9
                    ),
                    new ProductEntity(
                            "Смарт-часы FitPulse S2",
                            "Водонепроницаемые умные часы с AMOLED-экраном, пульсометром, GPS и уведомлениями со смартфона.",
                            6490.0,
                            "demo://smartwatch",
                            electronics,
                            8,
                            4.7
                    ),
                    new ProductEntity(
                            "Худи Oversize Basic",
                            "Плотный хлопковый футер с мягким начёсом. Свободный крой и удобный капюшон.",
                            3200.0,
                            "demo://hoodie",
                            clothes,
                            20,
                            4.8
                    ),
                    new ProductEntity(
                            "Кроссовки Urban Run",
                            "Лёгкие повседневные кроссовки с дышащей сеткой и амортизирующей подошвой.",
                            5400.0,
                            "demo://sneakers",
                            shoes,
                            12,
                            4.6
                    ),
                    new ProductEntity(
                            "Городской рюкзак Minimal",
                            "Влагозащищённый рюкзак объёмом 20 л с отдельным отсеком для ноутбука до 15.6 дюймов.",
                            2850.0,
                            "demo://backpack",
                            accessories,
                            14,
                            4.9
                    ),
                    new ProductEntity(
                            "Настольная лампа LED Desk",
                            "Минималистичная светодиодная лампа с регулировкой яркости и температуры света.",
                            1950.0,
                            "demo://lamp",
                            home,
                            25,
                            4.7
                    )
            ));
        }
    }
}
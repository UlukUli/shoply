# Shoply — Online Shopping Mobile Application

Полноценное клиент-серверное мобильное приложение интернет-магазина, разработанное на **Flutter** (клиент) и **Java Spring Boot** (сервер).

## Стек технологий

### Mobile Client (`shoply_app`)
- **Flutter & Dart**
- **Архитектура:** Feature-First + Clean Architecture (`Domain`, `Data`, `Presentation`)
- **State Management:** `flutter_bloc` (BLoC)
- **Сетевой слой:** `Dio` (REST API + Interceptor для токена авторизации)
- **Навигация:** `GoRouter`
- **Dependency Injection:** `GetIt`

### Backend Server (`shoply-backend`)
- **Java 17 & Spring Boot 3**
- **База данных:** Spring Data JPA + H2 Database (с сохранением на диск)
- **API:** REST Controllers (`/api/auth`, `/api/categories`, `/api/products`, `/api/cart`, `/api/orders`)

## Реализованный функционал
1. Регистрация и авторизация пользователей (`Authentication`)
2. Каталог товаров и фильтрация по категориям (`Home`, `Products`, `Categories`)
3. Поиск товаров по названию (`Search`)
4. Детальная карточка товара (`Product Details`)
5. Корзина покупок с изменением количества (`Cart`)
6. Оформление заказа с указанием адреса доставки (`Checkout`)
7. История оформленных заказов (`My Orders`)
8. Профиль пользователя (`Profile`)

## Инструкция по запуску

### 1. Запуск сервера (Spring Boot)
```bash
cd shoply-backend/shoply-backend
./mvnw spring-boot:run
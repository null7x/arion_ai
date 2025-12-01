# 🚀 Arion AI Mobile App - v1.0.0

Профессиональное мобильное приложение для Android, работающее как WebView клиент для **Arion AI** с современным Material 3 дизайном, поддержкой темы и неоновой палитрой **Aurora Borealis**.

## 👤 Автор

**Azizov Aminjon** — разработка, архитектура, оптимизация сборки, подготовка к публикации (Google Play), интеграция WebView, кэш/ошибки, автоматизация CI/CD.

Telegram / Email: (добавьте свои контакты при необходимости)

## 📷 Скриншоты

| Home (WebView) | Ошибка/Retry | Навигация |
| -------------- | ------------ | --------- |
| ![Home](assets/1.png) | ![Error](assets/2.png) | ![Nav](assets/3.png) |

> Скриншоты расположены в папке `assets/` и включены в репозиторий для наглядности состояния приложения (WebView, обработка ошибок, нижняя навигация).

## 📋 Оглавление

1. [Статус проекта](#статус-проекта)
2. [Быстрый старт](#быстрый-старт)
3. [Особенности](#особенности)
4. [Архитектура](#архитектура)
5. [Установка](#установка)
6. [Структура папок](#структура-папок)
7. [Технологический стек](#технологический-стек)
8. [Публикация в Play Store](#публикация-в-play-store)

---

## 🏗️ Архитектура проекта

Приложение следует **Clean Architecture** с разделением на слои:

```
lib/
├── core/                    # Бизнес-логика и сервисы
│   ├── constants/          # Константы (цвета, размеры, URLs)
│   ├── providers/          # State Management (Provider)
│   ├── services/           # API, WebView сервисы
│   ├── theme/              # Темы приложения
│   └── utils/              # Утилиты и расширения
│
├── data/                    # Слой данных
│   ├── models/             # Data models, DTOs
│   └── repositories/       # Абстракция для источников данных
│
├── presentation/           # UI слой
│   ├── screens/            # Полные экраны (StatefulWidget)
│   ├── widgets/            # Переиспользуемые виджеты
│   └── layouts/            # Layouts для структурирования
│
└── main.dart               # Entry point приложения
```

### Диаграмма потока данных:

```
UI (Screens)
    ↓
Providers (State Management)
    ↓
Services & Repositories (Business Logic)
    ↓
External APIs / Local Storage
```

---

## ✅ Требования

- **Flutter**: ≥ 3.9.2
- **Dart**: ≥ 3.9.2
- **Android SDK**: API 21+ (Android 5.0+)
- **RAM**: ≥ 4 GB для разработки
- **Интернет**: Для работы WebView

### Установка Flutter

```bash
# macOS / Linux
curl https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.9.2-stable.tar.xz -O
tar -xvf flutter_linux_3.9.2-stable.tar.xz

# Windows PowerShell
Invoke-WebRequest -Uri "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.9.2-stable.zip" -OutFile flutter.zip
Expand-Archive flutter.zip

# Добавить в PATH
export PATH="$PATH:$(pwd)/flutter/bin"
```

---

## 🚀 Установка

### 1. Клонирование проекта

```bash
cd "Desktop/arion app"
cd orion_app
```

### 2. Установка зависимостей

```bash
# Обновить Flutter
flutter upgrade

# Получить зависимости
flutter pub get

# Проверить окружение
flutter doctor
```

### 3. Запуск приложения

```bash
# Для отладки на эмуляторе
flutter run

# Для отладки на физическом устройстве
flutter run -d <device_id>

# Release версия
flutter run --release

# Список доступных устройств
flutter devices
```

---

## 🎨 Особенности

### 1. **Минималистичный дизайн**
- Чистые линии и простота
- Максимум белого пространства
- Минимум диалоговых окон

### 2. **Неоновая палитра Aurora**
```
Основные цвета:
- Cyan (#00D9FF)       - Основной цвет
- Purple (#9D4EDD)     - Вторичный
- Pink (#FF006E)       - Акцент
- Blue (#3A86FF)       - Дополнительный
- Green (#00F77D)      - Успех
```

### 3. **Dark Theme поддержка**
- Автоматический переход на system theme
- Ручной выбор темы в Settings
- Сохранение предпочтения

### 4. **Bottom Navigation Bar**
```
Home    → WebView с сайтом
Chat    → /chat endpoint
Profile → /profile endpoint
Settings → Настройки приложения
```

### 5. **WebView Integration**
- JavaScript bridge для связи Flutter ↔ JS
- Кэширование данных
- Поддержка cookies
- Offline detection

### 6. **Loading Indicator**
- Неоновый прогресс бар с градиентом
- Плавная анимация

### 7. **No Internet Screen**
- Красивый экран при отсутствии подключения
- Кнопка для повторной попытки

### 8. **Splash Screen**
- Анимация при загрузке
- Logo с градиентом
- Автоматический переход на Home

---

## 🔌 API Integration

### Диагностика вашего Render сервера

**Текущий статус:**
```
GET https://arion-ai.onrender.com
Status: 200 OK ✅

GET /chat
Status: 404 Not Found ❌

GET /api/chat
Status: 404 Not Found ❌
```

### Почему 404?

1. **Маршруты не определены** на сервере Render
2. **Отсутствует CORS конфигурация**
3. **Неправильный формат запроса**

### ✅ Правильный формат POST запроса

```http
POST /chat HTTP/1.1
Host: arion-ai.onrender.com
Content-Type: application/json
Accept: application/json

{
  "message": "Hello Orion",
  "conversation_id": "optional_id",
  "language": "en",
  "timestamp": "2024-11-30T10:30:00Z"
}
```

### 🔑 CORS должна быть включена

```javascript
// На сервере Render
response.headers['Access-Control-Allow-Origin'] = '*';
response.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS';
response.headers['Access-Control-Allow-Headers'] = 'Content-Type, Accept';
```

### 📞 JavaScript → Flutter Bridge

```javascript
// В WebView:
window.OrionAI.sendChat("Hello").then(response => {
  console.log('Response:', response);
});
```

### 📄 Полная API документация: [API_DOCUMENTATION.md](./API_DOCUMENTATION.md)

---

## 📁 Структура папок

### `lib/core/constants/app_constants.dart`
```dart
// Все константы приложения
- URLs
- API endpoints
- Цвета (AppColors)
- Размеры (AppSizes)
- Typography
```

### `lib/core/theme/app_theme.dart`
```dart
// Определение светлой и темной темы
// Material 3 design system
```

### `lib/core/providers/`
```
theme_provider.dart       → Управление темой
connectivity_provider.dart → Проверка интернета
webview_provider.dart     → WebView состояние
```

### `lib/core/services/api_service.dart`
```dart
// API client с retry логикой
// JavaScript bridge для WebView
```

### `lib/presentation/screens/`
```
splash_screen.dart        → Заставка с логотипом
home_screen.dart          → Основной WebView
chat_screen.dart          → /chat endpoint
profile_screen.dart       → /profile endpoint
settings_screen.dart      → Настройки
no_internet_screen.dart   → Offline экран
```

### `lib/presentation/widgets/`
```
bottom_navigation_widget.dart     → Bottom nav bar
webview_loading_indicator.dart    → Progress bar
```

---

## 🛠️ Технологический стек

### Flutter & Dart
```yaml
flutter: ^3.9.2
dart: ^3.9.2
```

### Основные пакеты

| Пакет | Версия | Назначение |
|-------|--------|-----------|
| webview_flutter | 4.8.0 | WebView компонент |
| provider | 6.4.1 | State management |
| go_router | 14.0.0 | Routing & navigation |
| connectivity_plus | 6.0.0 | Network detection |
| shared_preferences | 2.2.2 | Local storage |
| http | 1.2.0 | HTTP client |
| google_fonts | 6.2.1 | Custom fonts |

### Вспомогательные пакеты

```yaml
flutter_animate: ^4.5.0     # Animations
flutter_svg: ^2.0.10        # SVG support
```

---

## 🎯 Best Practices

### 1. **State Management**

```dart
// ✅ Правильно - использовать Provider
class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Text(themeProvider.isDarkMode ? 'Dark' : 'Light');
      },
    );
  }
}

// ❌ Неправильно - setState в StatelessWidget
// (невозможно)
```

### 2. **WebView Security**

```dart
// ✅ Включить JavaScript только если необходимо
webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);

// ❌ Никогда не вставлять пользовательский контент напрямую в JS
// webViewController.runJavaScript(userInput); // ОПАСНО
```

### 3. **Performance**

```dart
// ✅ Использовать const конструкторы
const SizedBox(height: 16);

// ❌ Избегать rebuild'ов
// Widget shouldRebuild(oldWidget) => true; // Плохо
```

### 4. **Navigation**

```dart
// ✅ Использовать go_router
context.push('/chat');
context.go('/home');

// ❌ Избегать Navigator.push старого стиля
// Navigator.of(context).push(MaterialPageRoute(...));
```

### 5. **Кэширование**

```dart
// ✅ Кэшировать API ответы
final cached = cacheService.get('key');
if (cached != null) return cached;

// ❌ Не вызывать API каждый раз
// for (int i = 0; i < 100; i++) apiCall(); // Плохо
```

### 6. **Обработка ошибок**

```dart
// ✅ Всегда обрабатывать исключения
try {
  await apiService.postChat(message: msg);
} catch (e) {
  showErrorDialog(context, e.toString());
}

// ❌ Игнорировать ошибки
// apiService.postChat(message: msg); // Опасно
```

### 7. **UI/UX**

```dart
// ✅ Показывать loading indicator при загрузке
if (provider.isLoading) {
  return LoadingWidget();
}

// ✅ Graceful error handling
if (provider.error != null) {
  return ErrorWidget(error: provider.error);
}

// ✅ Используйте const TextStyle везде где возможно
TextStyle(
  fontSize: AppTypography.body,
  color: AppColors.lightText,
)
```

---

## 📊 Производительность

### Целевые метрики

| Метрика | Целевое значение |
|---------|-----------------|
| Размер APK | < 50 MB |
| Стартовое время | < 2 сек |
| FPS | ≥ 60 |
| Потребление ОЗУ | < 100 MB |

### Оптимизация

```bash
# Анализ размера APK
flutter build apk --analyze-size

# Profile mode для анализа производительности
flutter run --profile

# Release версия (самая оптимальная)
flutter run --release
```

---

## 🔐 Безопасность

### Checklist

- [x] HTTPS для всех API запросов
- [x] Никогда не хранить пароли в коде
- [x] Использовать secure storage для sensitive данных
- [x] Валидировать все user inputs
- [x] Обновлять зависимости регулярно

### Уязвимости WebView

```dart
// ❌ ОПАСНО - не делать так:
webViewController.runJavaScript(userInput);

// ✅ ПРАВИЛЬНО - использовать JavaScript channels:
webViewController.addJavaScriptChannel(
  'OrionAI',
  onMessageReceived: (JavaScriptMessage message) {
    // Безопасно обработать сообщение
  },
);
```

---

## 📱 Тестирование

### Unit Tests

```bash
# Запустить все тесты
flutter test

# Тесты с покрытием
flutter test --coverage
```

### Integration Tests

```bash
# Интеграционные тесты на устройстве
flutter test integration_test/

# На эмуляторе
flutter test integration_test/ --device-id emulator-5554
```

### Manual Testing Checklist

- [ ] Проверить WebView загрузку
- [ ] Проверить navigation между экранами
- [ ] Проверить dark/light theme переключение
- [ ] Проверить offline mode
- [ ] Проверить кэширование
- [ ] Проверить на старых Android версиях (API 21)
- [ ] Проверить на новых Android версиях (API 34)
- [ ] Проверить на разных размерах экрана

---

## 📚 Дополнительные ресурсы

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design 3](https://m3.material.io/)
- [WebView Flutter](https://pub.dev/packages/webview_flutter)
- [Provider Pattern](https://pub.dev/packages/provider)

---

## 🤝 Контрибьютинг

1. Fork проект
2. Создать feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit изменения (`git commit -m 'Add some AmazingFeature'`)
4. Push в branch (`git push origin feature/AmazingFeature`)
5. Открыть Pull Request

---

## 📞 Поддержка

Для вопросов и проблем:
1. Проверьте [API_DOCUMENTATION.md](./API_DOCUMENTATION.md)
2. Проверьте [PUBLICATION_GUIDE.md](./PUBLICATION_GUIDE.md)
3. Запустите `flutter doctor` для диагностики

---

## 📄 Лицензия

MIT License - смотрите LICENSE файл

---

**Версия:** 1.0.0  
**Дата:** November 30, 2024  
**Статус:** Production Ready ✅

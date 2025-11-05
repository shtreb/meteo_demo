# Инструкция по настройке проекта

## Шаги для запуска проекта

1. **Установите зависимости:**
```bash
flutter pub get
```

2. **Запустите генерацию кода:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Это сгенерирует необходимые файлы для:
- `json_serializable` - для WeatherResponse
- `retrofit_generator` - для WeatherClient
- `freezed` - для WeatherEvent и WeatherState
- `injectable_generator` - для DI конфигурации

3. **Запустите приложение:**
```bash
flutter run
```

## Структура проекта

Проект следует Clean Architecture принципам с разделением на:
- **core/** - общие утилиты, сетевой слой, ошибки, локальное хранилище
- **di/** - dependency injection модули
- **features/** - функциональность погоды:
    - **domain/** - бизнес-логика и модели
    - **data/** - репозиторий и источники данных
    - **presentation/** - UI и BLoC

## Используемые технологии

- **Retrofit + Dio** - HTTP клиент
- **json_serializable** - парсинг JSON
- **shared_preferences** - локальное хранилище
- **geolocator** - геолокация
- **permission_handler** - управление разрешениями
- **Bloc + freezed** - управление состоянием
- **getIt + injectable** - dependency injection
- **shimmer** - скелетная анимация загрузки

## Логика работы

1. При запуске приложения показывается экран загрузки с shimmer эффектом
2. Проверяются сохраненные координаты в shared_preferences
3. Если координат нет, проверяются разрешения на геолокацию
4. Проверяется включен ли сервис геолокации
5. Получается текущее местоположение и сохраняется
6. Делается запрос к Open-Meteo API
7. Отображаются данные о погоде
8. Если данные не обновлялись более 2 часов, показывается предупреждение


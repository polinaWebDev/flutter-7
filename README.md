# Posts API

Простое приложение: загружает список постов с публичного API
[JSONPlaceholder](https://jsonplaceholder.typicode.com/posts) через Dio
и показывает их на главном экране. Есть состояния загрузки и ошибки,
а также pull-to-refresh.

## Стек

- Flutter (Material 3)
- dio - HTTP-запросы
- elementary / elementary_helper - архитектура MVVM (Widget - WidgetModel - Model)

## Архитектура

- `models/` - модель `Post` с ручным парсингом JSON
- `data/` - `ApiClient` (Dio) и `PostsRepository`
- `screens/posts/` - экран на Elementary: View (`PostsScreen`),
  `PostsWidgetModel`, `PostsModel`

## Запуск

1. Установить Flutter (stable).
2. `flutter pub get`
3. `flutter run`

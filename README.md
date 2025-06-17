# TicketBookingApp with Clean Architecture Pattern

A new Flutter project. `flutter new my_app`

```bash
lib/
├── core/   
|   |-- errors/                # Common utilities, themes, errors, constants
|   |   |-- fealures.dart
|   |   |-- exceptions.dart
|   |-- network/
|   |   |-- network_info.dart
|   |-- usecases/
|   |   |-- usecase.dart
|   |-- utis/
|       |-- constants.dart
├── features/
│   └── tasks/
│       ├── data/
│       │   ├── datasources/
|       |   |   |-- tasks_local_data_source.dart
│       │   │   └── tasks_remote_data_source.dart
│       │   ├── models/
│       │   │   └── tasks_model.dart
│       │   └── repositories/
│       │       └── task_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── tasks.dart
│       │   ├── repositories/
│       │   │   └── tasks_repository.dart
│       │   └── usecases/
|       |       |-- get_task.dart
|       |       |-- add_task.dart
|       |       |-- delete_task.dart
│       │       └── update_task.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── task_bloc.dart
|           |   |-- task_event.dart
│           │   └── task_state.dart
│           └── pages/
|               |-- task_list_page.dart 
│               └── task_form_page.dart
|-- injection_container.dart
├── main.dart
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Run App

```bash
flutter run
```

## Pkg

```bash
flutter pub get
```

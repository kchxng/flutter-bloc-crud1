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

- Step to coding using **clean architecture** as:

```bash
# step:0 core [group-1]
-> core/error/failure.dart
-> core/error/exception.dart
-> core/network/network_info.dart
-> core/usecases/usecase.dart

# step: 1 [group-2]
-> feature/domain/entity/template.dart
# step: 2
-> feature/domain/repository/template_repository.dart
# step: 3
-> feature/domain/usecase/request_template.dart, # get, post, put, delete, ...
# step: 4
-> feature/data/models/template_model.dart
# step: 5
-> feature/data/dataresource/template_remote_datasource.dart
-> feature/data/dataresource/template_local_datasource.dart
# step: 6
-> feature/data/repository/template_repository_impl.dart
# step: 7
-> feature/presentation/bloc/template_event.dart
-> feature/presentation/bloc/template_state.dart
-> feature/presentation/bloc/template_bloc.dart

# step: 8: to show data on pages [group-3]
-> feature/presentation/pages/template_list_page.dart, form_page.dart,...
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

- Use shortCut key:

```bash
# Generate Stateless Widgets [type stl then enter]
stl
# Generate Statefull Widgets [type stf then enter]
stf
```

### To deploy your Flutter application as an APK for Android and an IPA for iOS

```bash
# Android
flutter build apk --release
# iOS
flutter build ipa --release
```

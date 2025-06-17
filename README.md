# TicketBookingApp with Clean Architecture Pattern

A new Flutter project. `flutter new my_app`

```bash
lib/
├── core/                   # Common utilities, themes, errors, constants
|-- |-- fealures.dart
|-- |-- exceptions.dart
|-- |-- network/
|-- |-- |-- network_info.dart
|-- |-- usecases/
|-- |-- |-- usecase.dart
|-- |-- utis/
|-- |-- |-- constants.dart
├── features/
│   └── ride_booking/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── ride_remote_data_source.dart
│       │   ├── models/
│       │   │   └── ride_model.dart
│       │   └── repositories/
│       │       └── ride_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── ride.dart
│       │   ├── repositories/
│       │   │   └── ride_repository.dart
│       │   └── usecases/
│       │       └── request_ride.dart
│       └── presentation/
│           ├── cubit/
│           │   ├── ride_cubit.dart
│           │   └── ride_state.dart
│           └── pages/
│               └── ride_booking_page.dart
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

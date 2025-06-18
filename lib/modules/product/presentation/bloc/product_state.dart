import 'package:equatable/equatable.dart';
import 'package:ticketbooking_app/modules/product/domain/entity/product.dart';

// ---------- Product State -------------//
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

// ---------- Initial state -------------//
class ProductInitial extends ProductState {}

// ---------- Loading state -------------//
class ProductLoading extends ProductState {}

// ---------- Loaded state -------------//
class ProductLoaded extends ProductState {
  final List<Product> products;

  // Constructor
  const ProductLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

// ---------- Success state -------------//
class ProductSuccess extends ProductState {
  final String message;
  const ProductSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

// ---------- Error state -------------//
class ProductError extends ProductState {
  final String message;
  const ProductError({required this.message});

  @override
  List<Object> get props => [message];
}

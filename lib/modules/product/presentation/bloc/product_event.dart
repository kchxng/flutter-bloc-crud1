import 'package:equatable/equatable.dart';
import 'package:ticketbooking_app/modules/product/domain/entity/product.dart';

// ---------- Event -------------//
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

// ---------- Get All event -------------//
class GetProductsRequest extends ProductEvent {}

// ---------- Add request event -------------//
class AddProductRequest extends ProductEvent {
  final Product product;

  const AddProductRequest({required this.product});

  @override
  List<Object> get props => [product];
}

// ---------- Update request event -------------//
class UpdateProductRequest extends ProductEvent {
  final Product product;

  const UpdateProductRequest({required this.product});

  @override
  List<Object> get props => [product];
}

// ---------- Delete request event -------------//
class DeleteProductRequest extends ProductEvent {
  final String id;

  const DeleteProductRequest({required this.id});

  @override
  List<Object> get props => [id];
}

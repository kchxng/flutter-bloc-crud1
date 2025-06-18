import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/core/usecase/usecase.dart';
import 'package:ticketbooking_app/modules/product/domain/entity/product.dart';
import 'package:ticketbooking_app/modules/product/domain/repository/product_repository.dart';

class AddProduct implements Usecase<Product, AddProductParams> {
  final ProductRepository repo;
  AddProduct(this.repo);
  @override
  Future<Either<Failure, Product>> call(AddProductParams params) async {
    return await repo.addProduct(params.product);
  }
}

// Params to get body
class AddProductParams extends Equatable {
  final Product product;

  const AddProductParams({required this.product});

  @override
  List<Object> get props => [product];
}

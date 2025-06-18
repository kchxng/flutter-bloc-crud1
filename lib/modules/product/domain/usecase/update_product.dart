import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/core/usecase/usecase.dart';
import 'package:ticketbooking_app/modules/product/domain/entity/product.dart';
import 'package:ticketbooking_app/modules/product/domain/repository/product_repository.dart';

class UpdateProduct implements Usecase<Product, UpdateProductParams> {
  final ProductRepository repo;
  UpdateProduct(this.repo);
  @override
  Future<Either<Failure, Product>> call(UpdateProductParams params) async {
    return await repo.updateProduct(params.product);
  }
}

class UpdateProductParams extends Equatable {
  final Product product;
  const UpdateProductParams({required this.product});

  @override
  List<Object> get props => [product];
}

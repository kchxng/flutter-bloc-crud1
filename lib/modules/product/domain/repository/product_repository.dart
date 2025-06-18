import 'package:dartz/dartz.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/modules/product/domain/entity/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> addProduct(Product product);
  Future<Either<Failure, Product>> updateProduct(Product product);
  Future<Either<Failure, void>> deleteProduct(String id);
}

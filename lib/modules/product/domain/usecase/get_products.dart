import 'package:dartz/dartz.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/core/usecase/usecase.dart';
import 'package:ticketbooking_app/modules/product/domain/entity/product.dart';
import 'package:ticketbooking_app/modules/product/domain/repository/product_repository.dart';

class GetProducts implements Usecase<List<Product>, NoParams> {
  final ProductRepository repo;

  GetProducts(this.repo);

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repo.getProducts();
  }
}

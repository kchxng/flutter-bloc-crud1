import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/core/usecase/usecase.dart';
import 'package:ticketbooking_app/modules/product/domain/repository/product_repository.dart';

class DeleteProduct implements Usecase<void, DeleteProductParams> {
  final ProductRepository repo;
  DeleteProduct(this.repo);
  @override
  Future<Either<Failure, void>> call(DeleteProductParams params) async {
    return await repo.deleteProduct(params.id);
  }
}

class DeleteProductParams extends Equatable {
  final String id;
  const DeleteProductParams({required this.id});
  @override
  List<Object?> get props => [id];
}

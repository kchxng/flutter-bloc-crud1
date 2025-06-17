import 'package:dartz/dartz.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/core/usecase/usecase.dart';
import 'package:ticketbooking_app/modules/auth/domain/repository/auth_repository.dart';

class LogoutUser implements Usecase<void, NoParams> {
  final AuthRepository repo;

  LogoutUser(this.repo);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repo.logout();
  }
}

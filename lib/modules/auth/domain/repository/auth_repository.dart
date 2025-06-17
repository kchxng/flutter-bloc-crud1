import 'package:dartz/dartz.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/modules/auth/domain/entity/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String username, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> getCachedUser();
}

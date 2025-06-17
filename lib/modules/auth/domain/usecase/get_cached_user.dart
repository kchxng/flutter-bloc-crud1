import 'package:dartz/dartz.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/core/usecase/usecase.dart';
import 'package:ticketbooking_app/modules/auth/domain/entity/user.dart';
import 'package:ticketbooking_app/modules/auth/domain/repository/auth_repository.dart';

class GetCachedUser implements Usecase<User,NoParams>{
  final AuthRepository repo;
  
  GetCachedUser(this.repo);

  @override
  Future<Either<Failure, User>> call(NoParams params) async{
   return await repo.getCachedUser();
  }
}
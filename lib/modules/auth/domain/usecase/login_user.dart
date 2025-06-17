import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/core/usecase/usecase.dart';
import 'package:ticketbooking_app/modules/auth/domain/entity/user.dart';
import 'package:ticketbooking_app/modules/auth/domain/repository/auth_repository.dart';

class LoginUser implements Usecase<User, LoginPrams> {
  final AuthRepository repo;
  
  LoginUser(this.repo);

  Future<Either<Failure, User>> call(LoginPrams params) async {
    return await repo.login(params.username, params.password);
  }
}

class LoginPrams extends Equatable {
  final String username;
  final String password;

  //constructor
  const LoginPrams({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

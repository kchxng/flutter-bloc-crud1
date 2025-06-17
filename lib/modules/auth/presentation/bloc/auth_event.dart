import 'package:equatable/equatable.dart';

//  Define Event step: 1
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequest extends AuthEvent {
  final String username;
  final String password;

  const LoginRequest({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class LogoutRequest extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

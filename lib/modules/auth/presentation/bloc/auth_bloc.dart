import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketbooking_app/core/usecase/usecase.dart';
import 'package:ticketbooking_app/modules/auth/domain/usecase/get_cached_user.dart';
import 'package:ticketbooking_app/modules/auth/domain/usecase/login_user.dart';
import 'package:ticketbooking_app/modules/auth/domain/usecase/logout_user.dart';
import 'package:ticketbooking_app/modules/auth/presentation/bloc/auth_event.dart';
import 'package:ticketbooking_app/modules/auth/presentation/bloc/auth_state.dart';

//  Define Event step: 3
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final GetCachedUser getCachedUser;

  AuthBloc({
    required this.loginUser,
    required this.logoutUser,
    required this.getCachedUser,
  }) : super(AuthInitial()) {
    // call func
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginRequest>(_onLoginRequest);
    on<LogoutRequest>(_onLogoutRequest);
  }

  void _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    // Call Auth Loading
    emit(AuthLoading());

    final result = await getCachedUser(NoParams());
    result.fold(
      (failure) => emit(AuthUnauthenticated()),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  // Login
  void _onLoginRequest(LoginRequest event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUser(
      LoginPrams(username: event.username, password: event.password),
    );

    result.fold(
      (failure) => emit(const AuthError(message: 'Login failed')), //IfLeft
      (user) => emit(AuthAuthenticated(user: user)), // IfRight
    );
  }

  // Logout
  void _onLogoutRequest(LogoutRequest event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await logoutUser(NoParams());
    result.fold(
      (failure) => emit(const AuthError(message: 'Logout failed')),
      (_) => emit(AuthUnauthenticated()),
    );
  }
}

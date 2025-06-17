import 'package:dartz/dartz.dart';
import 'package:ticketbooking_app/core/error/exceptions.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/core/network/network_info.dart';
import 'package:ticketbooking_app/modules/auth/data/datasource/auth_local_datasource.dart';
import 'package:ticketbooking_app/modules/auth/data/datasource/auth_remote_datasource.dart';
import 'package:ticketbooking_app/modules/auth/domain/entity/user.dart';
import 'package:ticketbooking_app/modules/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDatasource localDataSource;
  final NetworkInfo networkInfo;

  // Constructor
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.login(username, password);
        localDataSource.cacheUser(user);
        return right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearCache();
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getCachedUser() async {
    try {
      final user = await localDataSource.getCachedUser();
      return Right(user);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}

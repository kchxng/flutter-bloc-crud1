import 'package:dartz/dartz.dart';
import 'package:ticketbooking_app/core/error/exceptions.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/core/network/network_info.dart';
import 'package:ticketbooking_app/modules/tasks/data/datasource/task_local_datasource.dart';
import 'package:ticketbooking_app/modules/tasks/data/datasource/task_remote_datasource.dart';
import 'package:ticketbooking_app/modules/tasks/domain/entity/tasks.dart';
import 'package:ticketbooking_app/modules/tasks/domain/repository/task_repository.dart';
import 'package:ticketbooking_app/modules/tasks/data/models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDatasource remoteDataSource;
  final TaskLocalDatasource localDataSource;
  final NetworkInfo networkInfo;

  TaskRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Tasks>>> getTasks() async {
    if (await networkInfo.isConnected) {
      try {
        final tasks = await remoteDataSource.getTasks();
        localDataSource.cacheTasks(tasks);
        return Right(tasks);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final tasks = await localDataSource.getCachedTask();
        return Right(tasks);
      } on ServerException {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Tasks>> addTask(Tasks task) async {
    if (await networkInfo.isConnected) {
      try {
        final taskModel = TasksModel(
          id: task.id,
          title: task.title,
          description: task.description,
          isCompleted: task.isCompleted,
        );
        final result = await remoteDataSource.addTask(taskModel);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Tasks>> updateTask(Tasks task) async {
    if (await networkInfo.isConnected) {
      try {
        final taskModel = TasksModel(
          id: task.id,
          title: task.title,
          description: task.description,
          isCompleted: task.isCompleted,
        );
        final result = await remoteDataSource.updateTask(taskModel);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteTask(id);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}

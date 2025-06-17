import 'package:dartz/dartz.dart';
import 'package:ticketbooking_app/modules/tasks/domain/entity/tasks.dart';
import '../../../../core/error/failures.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<Tasks>>> getTasks();
  Future<Either<Failure, Tasks>> addTask(Tasks task);
  Future<Either<Failure, Tasks>> updateTask(Tasks task);
  Future<Either<Failure, void>> deleteTask(String id);
}

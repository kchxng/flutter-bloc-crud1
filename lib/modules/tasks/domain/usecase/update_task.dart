import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/core/usecase/usecase.dart';
import 'package:ticketbooking_app/modules/tasks/domain/entity/tasks.dart';
import 'package:ticketbooking_app/modules/tasks/domain/repository/task_repository.dart';

class UpdateTask implements Usecase<Tasks, UpdateTaskParams> {
  final TaskRepository repo;

  UpdateTask(this.repo);

  @override
  Future<Either<Failure, Tasks>> call(UpdateTaskParams params) async {
    return await repo.updateTask(params.task);
  }
}

class UpdateTaskParams extends Equatable {
  final Tasks task;

  const UpdateTaskParams({required this.task});

  @override
  List<Object> get props => [task];
}

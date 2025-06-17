import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/core/usecase/usecase.dart';
import 'package:ticketbooking_app/modules/tasks/domain/entity/tasks.dart';
import 'package:ticketbooking_app/modules/tasks/domain/repository/task_repository.dart';

class AddTask extends Usecase<Tasks, AddTaskParams> {
  final TaskRepository repo;
  AddTask(this.repo);

  @override
  Future<Either<Failure, Tasks>> call(AddTaskParams params) async {
    return await repo.addTask(params.task);
  }
}

class AddTaskParams extends Equatable {
  final Tasks task;

  const AddTaskParams({required this.task});

  @override
  List<Object> get props => [task];
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/core/usecase/usecase.dart';
import 'package:ticketbooking_app/modules/tasks/domain/repository/task_repository.dart';

class DeleteTask implements Usecase<void, DeleteTaskParams> {
  final TaskRepository repo;
  DeleteTask(this.repo);

  @override
  Future<Either<Failure, void>> call(DeleteTaskParams params) async {
    return await repo.deleteTask(params.id);
  }
}

class DeleteTaskParams extends Equatable {
  final String id;

  const DeleteTaskParams({required this.id});

  @override
  List<Object?> get props => [id];
}

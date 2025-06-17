import 'package:dartz/dartz.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/core/usecase/usecase.dart';
import 'package:ticketbooking_app/modules/tasks/domain/entity/tasks.dart';
import 'package:ticketbooking_app/modules/tasks/domain/repository/task_repository.dart';

class GetTasks implements Usecase<List<Tasks>, NoParams> {
  final TaskRepository repo;
  
  GetTasks(this.repo);

  @override
  Future<Either<Failure, List<Tasks>>> call(NoParams params) async {
    return await repo.getTasks();
  }
}

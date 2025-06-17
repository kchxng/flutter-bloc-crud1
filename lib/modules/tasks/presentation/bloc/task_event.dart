import 'package:equatable/equatable.dart';
import 'package:ticketbooking_app/modules/tasks/domain/entity/tasks.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetTasksRequested extends TaskEvent {}

class AddTaskRequested extends TaskEvent {
  final Tasks task;

  const AddTaskRequested({required this.task});

  @override
  List<Object> get props => [task];
}

class UpdateTaskRequested extends TaskEvent {
  final Tasks task;

  const UpdateTaskRequested({required this.task});

  @override
  List<Object> get props => [task];
}

class DeleteTaskRequested extends TaskEvent {
  final String taskId;

  const DeleteTaskRequested({required this.taskId});

  @override
  List<Object> get props => [taskId];
}

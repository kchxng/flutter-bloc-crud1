import 'package:equatable/equatable.dart';
import 'package:ticketbooking_app/modules/tasks/domain/entity/tasks.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TasksLoaded extends TaskState {
  final List<Tasks> tasks;

  const TasksLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TaskOperationSuccess extends TaskState {
  final String message;

  const TaskOperationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class TaskError extends TaskState {
  final String message;

  const TaskError({required this.message});

  @override
  List<Object> get props => [message];
}
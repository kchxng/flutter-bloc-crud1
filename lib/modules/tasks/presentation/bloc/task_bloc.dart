import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketbooking_app/core/usecase/usecase.dart';
import 'package:ticketbooking_app/modules/tasks/domain/usecase/add_task.dart';
import 'package:ticketbooking_app/modules/tasks/domain/usecase/delete_task.dart';
import 'package:ticketbooking_app/modules/tasks/domain/usecase/get_tasks.dart';
import 'package:ticketbooking_app/modules/tasks/domain/usecase/update_task.dart';
import 'package:ticketbooking_app/modules/tasks/presentation/bloc/task_event.dart';
import 'package:ticketbooking_app/modules/tasks/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TaskInitial()) {
    
    on<GetTasksRequested>(_onGetTasksRequested);
    on<AddTaskRequested>(_onAddTaskRequested);
    on<UpdateTaskRequested>(_onUpdateTaskRequested);
    on<DeleteTaskRequested>(_onDeleteTaskRequested);
  }

  void _onGetTasksRequested(GetTasksRequested event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final result = await getTasks(NoParams());
    result.fold(
      (failure) => emit(const TaskError(message: 'Failed to load tasks')),
      (tasks) => emit(TasksLoaded(tasks: tasks)),
    );
  }

  void _onAddTaskRequested(AddTaskRequested event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final result = await addTask(AddTaskParams(task: event.task));
    result.fold(
      (failure) => emit(const TaskError(message: 'Failed to add task')),
      (_) {
        emit(const TaskOperationSuccess(message: 'Task added successfully'));
        add(GetTasksRequested());
      },
    );
  }

  void _onUpdateTaskRequested(UpdateTaskRequested event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final result = await updateTask(UpdateTaskParams(task: event.task));
    result.fold(
      (failure) => emit(const TaskError(message: 'Failed to update task')),
      (_) {
        emit(const TaskOperationSuccess(message: 'Task updated successfully'));
        add(GetTasksRequested());
      },
    );
  }

  void _onDeleteTaskRequested(DeleteTaskRequested event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final result = await deleteTask(DeleteTaskParams(id: event.taskId));
    result.fold(
      (failure) => emit(const TaskError(message: 'Failed to delete task')),
      (_) {
        emit(const TaskOperationSuccess(message: 'Task deleted successfully'));
        add(GetTasksRequested());
      },
    );
  }
}
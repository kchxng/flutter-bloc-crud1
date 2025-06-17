import 'package:ticketbooking_app/modules/tasks/domain/entity/tasks.dart';

class TasksModel extends Tasks {
  const TasksModel({
    required super.id,
    required super.title,
    required super.description,
    required super.isCompleted,
  });

  // Parase from Json to object
  factory TasksModel.fromJson(Map<String, dynamic> json) {
    return TasksModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['body'] ?? '',
      isCompleted: json['completed'] ?? false,
    );
  }

  // Convert obect to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': description,
      'completed': isCompleted,
    };
  }

  TasksModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TasksModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

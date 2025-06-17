import 'dart:convert';
import 'package:ticketbooking_app/core/error/exceptions.dart';
import 'package:ticketbooking_app/core/utils/constants.dart';
import 'package:ticketbooking_app/modules/tasks/data/models/task_model.dart';
import 'package:http/http.dart' as http;

abstract class TaskRemoteDatasource {
  Future<List<TasksModel>> getTasks();
  Future<TasksModel> addTask(TasksModel task);
  Future<TasksModel> updateTask(TasksModel task);
  Future<void> deleteTask(String id);
}

class TaskRemoteDatasourceImpl implements TaskRemoteDatasource {
  final http.Client client;
  TaskRemoteDatasourceImpl({required this.client});

  @override
  Future<List<TasksModel>> getTasks() async {
    final res = await client.get(
      Uri.parse('${Constants.baseUrl}/posts'),
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(res.body);
      return jsonList.map((json) => TasksModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TasksModel> addTask(TasksModel task) async {
    final res = await client.post(
      Uri.parse('${Constants.baseUrl}/posts'),
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode == 201) {
      return TasksModel.fromJson(json.decode(res.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TasksModel> updateTask(TasksModel task) async {
    final res = await client.put(
      Uri.parse('${Constants.baseUrl}/posts/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (res.statusCode == 200) {
      return TasksModel.fromJson(json.decode(res.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    final res = await client.delete(
      Uri.parse('${Constants.baseUrl}/posts/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode != 200) {
      throw ServerException();
    }
  }
}

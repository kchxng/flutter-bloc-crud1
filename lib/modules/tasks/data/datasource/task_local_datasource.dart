import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketbooking_app/core/error/exceptions.dart';
import 'package:ticketbooking_app/core/utils/constants.dart';
import 'package:ticketbooking_app/modules/tasks/data/models/task_model.dart';

abstract class TaskLocalDatasource {
  Future<List<TasksModel>> getCachedTask();
  Future<void> cacheTasks(List<TasksModel> tasks);
}

class TaskLocalDatasourceImpl implements TaskLocalDatasource {
  final SharedPreferences sharedPreferences;
  TaskLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<List<TasksModel>> getCachedTask() {
    final jsonString = sharedPreferences.getString(Constants.cachedTask);

    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return Future.value(
        jsonList.map((json) => TasksModel.fromJson(json)).toList(),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheTasks(List<TasksModel> tasks) {
    final taskJson = tasks.map((task) => task.toJson()).toList();

    return sharedPreferences.setString(
      Constants.cachedTask,
      json.encode(taskJson),
    );
  }
}

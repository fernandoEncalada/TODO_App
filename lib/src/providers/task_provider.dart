import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_app/src/models/task_response.dart';

import 'package:http/http.dart' as http;

class TaskProvider extends ChangeNotifier {
  final String _baseUrl = 'flutter-7a10f-default-rtdb.firebaseio.com';

  final List<TasksResponse> tasks = [];
  bool isLoading = true;
  bool isSaving = true;

  late TasksResponse selectedTask;

  TaskProvider() {
    getTasks();
  }

  Future<List<TasksResponse>> getTasks() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'tasks.json');
    final resp = await http.get(url);

    final Map<String, dynamic> tasksMap = json.decode(resp.body);

    tasksMap.forEach((key, value) {
      final tempTask = TasksResponse.fromMap(value);
      tempTask.id = key;
      tasks.add(tempTask);
    });

    isLoading = false;
    notifyListeners();

    print(tasks);

    return tasks;
  }
}

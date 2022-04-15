import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_app/src/models/task_response.dart';

import 'package:http/http.dart' as http;

class TaskProvider extends ChangeNotifier {
  final String _baseUrl = 'flutter-7a10f-default-rtdb.firebaseio.com';

  List<TasksResponse> tasks = [];
  bool isLoading = true;
  bool isSaving = false;

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

  Future createOrUpdateTask(TasksResponse task) async {
    isSaving = true;
    notifyListeners();

    if (task.id == null) {
      await createTask(task);
    } else {
      await updateTask(task);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> createTask(TasksResponse task) async {
    final url = Uri.https(_baseUrl, 'tasks.json');

    final resp = await http.post(url, body: task.toJson());
    final decodedData = json.decode(resp.body);

    task.id = decodedData['name'];

    tasks.add(task);

    return task.id!;
  }

  Future<String> updateTask(TasksResponse task) async {
    final url = Uri.https(_baseUrl, 'tasks/${task.id}.json');

    final resp = await http.put(url, body: task.toJson());
    final decodedData = json.decode(resp.body);

    final index = tasks.indexWhere((element) => element.id == task.id);

    tasks[index] = task;

    return task.id!;
  }

  Future<String> deleteTask(TasksResponse task) async {
    final url = Uri.https(_baseUrl, 'tasks/${task.id}.json');

    final resp = await http.delete(url, body: task.toJson());
    final decodedData = json.decode(resp.body);

    print(decodedData);
    final index = tasks.indexWhere((element) => element.id == task.id);

    tasks = [];
    getTasks();
    notifyListeners();

    return 'Eliminado';
  }
}

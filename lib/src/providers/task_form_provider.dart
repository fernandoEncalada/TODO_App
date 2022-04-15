import 'package:flutter/material.dart';
import 'package:todo_app/src/models/task_response.dart';

class TaskFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TasksResponse task;
  TaskFormProvider(this.task);

  updateCompleted(bool value) {
    task.completed = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}

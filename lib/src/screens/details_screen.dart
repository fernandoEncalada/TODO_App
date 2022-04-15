import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/providers/task_provider.dart';

import '../providers/task_form_provider.dart';
import '../ui/input_decorations.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Task'),
      ),
      body: _TaskForm(),
    );
  }
}

class _TaskForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskForm = Provider.of<TaskFormProvider>(context);
    final task = taskForm.task;

    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: _buildBoxDecoration(),
          child: Form(
              key: taskForm.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  TextFormField(
                    initialValue: task.title,
                    onChanged: (value) => task.title = value,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'The name is required';
                    },
                    decoration: InputDecorations.authInputDecoration(
                        hintText: 'Task Title', labelText: 'Title'),
                  ),
                  TextFormField(
                    initialValue: task.description,
                    onChanged: (value) => task.description = value,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'The description is required';
                    },
                    decoration: InputDecorations.authInputDecoration(
                        hintText: 'Task Descriptions',
                        labelText: 'Description'),
                  ),
                  SwitchListTile.adaptive(
                      value: task.completed,
                      activeColor: Colors.indigo,
                      onChanged: taskForm.updateCompleted)
                ],
              )),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
}
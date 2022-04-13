import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/models/task_response.dart';
import 'package:todo_app/src/providers/task_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('TODO APP'),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                tasksProvider.selectedTask = TasksResponse(
                    completed: false, description: 'huevos', title: 'jeje');
                Navigator.pushNamed(context, 'task');
              }, 
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: tasksProvider.tasks.length,
            itemBuilder: (_, int index) {
              return _TasksList(tasksProvider.tasks[index]);
            }));
  }
}

class _TasksList extends StatelessWidget {
  TasksResponse task;

  _TasksList(this.task);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
        child: Card(
            color: (task.completed) ? Colors.green : Colors.red,
            child: GestureDetector(
              onTap: () {
                
                Navigator.pushNamed(context, 'details');
              },
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(task.title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(task.description),
                  SizedBox(height: 10),
                ],
              ),
            )));
  }
}

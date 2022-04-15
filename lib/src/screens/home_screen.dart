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
          title: const Text('TODO APP'),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                tasksProvider.selectedTask =
                    TasksResponse(completed: false, description: '', title: '');
                Navigator.pushNamed(context, 'task');
              },
              icon: const Icon(Icons.add),
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
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
        child: Card(
            color: (task.completed) ? Colors.green.shade300 : Colors.red.shade300,
            child: GestureDetector(
              onTap: () {
                taskProvider.selectedTask = task.copy();
                Navigator.pushNamed(context, 'task');
              },
              child: Column(
                children: [
                  ListTile(
                    title: Text(task.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(task.description,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis)),
                    trailing: IconButton(
                        onPressed: () {
                          taskProvider.deleteTask(task);
                        },
                        icon: const Icon(Icons.delete),
                    ),
                  ),
                ],
              ),
            )));
  }
}

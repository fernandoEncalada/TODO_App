// To parse this JSON data, do
//
//     final tasksResponse = tasksResponseFromMap(jsonString);

import 'dart:convert';

class TasksResponse {
  TasksResponse({
    this.id,
    required this.completed,
    required this.description,
    required this.title,
  });

  String? id;
  bool completed;
  String description;
  String title;

  factory TasksResponse.fromJson(String str) =>
      TasksResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TasksResponse.fromMap(Map<String, dynamic> json) => TasksResponse(
        completed: json["completed"],
        description: json["description"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "completed": completed,
        "description": description,
        "title": title,
      };

  TasksResponse copy() => TasksResponse(
      completed: completed, description: description, title: title, id: id);
}

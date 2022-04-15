import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/src/providers/task_provider.dart';
import 'package:todo_app/src/screens/details_screen.dart';
import 'package:todo_app/src/screens/home_screen.dart';
import 'package:todo_app/src/screens/task_screen.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'task': (_) => TaskScreen(),
        'details': (_) => const DetailsScreen(),
      },
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: Colors.indigo),
      ),
    );
  }
}

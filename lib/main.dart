import 'package:flutter/material.dart';
import 'package:todooey_flutter/screens/tasks_screen.dart';
//--

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todooey',
      theme: ThemeData.dark(),
      home: TasksScreen(),
    );
  }
}

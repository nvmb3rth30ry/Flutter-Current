import 'package:flutter/material.dart';
//--

class TasksScreen extends StatelessWidget {
  final String title = 'Todoeey sez: \'Hello.\'';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'SourceSansPro',
            fontWeight: FontWeight.normal,
            fontSize: 22.0,
          ),
        ),
      ),
    );
  }
}

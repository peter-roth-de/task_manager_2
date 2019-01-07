import 'package:flutter/material.dart';
import 'package:task_manager_2/bloc/TaskProvider.dart';


// task manager pages
import 'package:task_manager_2/pages/homePage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
   // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return TaskProvider(
        child: new MaterialApp(
        title: 'Task Manager Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
          routes: {'/': (BuildContext context) => new HomePage(),
            // '/task_detail': (BuildContext context) => new TaskDetailPage()
            //home: new MyHomePage(title: 'Task Manager'),
          }
        ),
    );

  }
}

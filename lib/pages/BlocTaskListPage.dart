import 'package:flutter/material.dart';
import 'package:task_manager_2/models/task.dart';
import 'package:task_manager_2/bloc/TaskProvider.dart';
import 'package:task_manager_2/widgets/taskTile.dart';

class BlocTaskListPage extends StatelessWidget {
  BlocTaskListPage();

  static const routeName = "/taskList";

  @override
  Widget build(BuildContext context) {
    final taskProvider = TaskProvider.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Task List"),
        ),
        body: StreamBuilder<List<Task>>(
            stream: taskProvider.items,
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data.isEmpty) {
                return Center(
                    child: Text('Empty',
                        style: Theme.of(context).textTheme.display1));
              }

              return ListView(
                  children: snapshot.data
                      .map((item) => TaskTile(item))
                      .toList());
            }));
  }
}
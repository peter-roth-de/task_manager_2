import 'dart:async';

import 'package:task_manager_2/models/taskList.dart';
import 'package:task_manager_2/models/task.dart';
import 'package:rxdart/subjects.dart';

class TaskListBloc {
  final TaskList _taskList = TaskList();

  final BehaviorSubject<List<Task>> _tasks =
  BehaviorSubject<List<Task>>(seedValue: []);

  final StreamController<Task> _taskListAdditionController =
  StreamController<Task>();

  TaskListBloc() {
    _taskListAdditionController.stream.listen((task) {
      _taskList.add(task);
      _tasks.add(_taskList.tasks);
    });
  }

  Sink<Task> get taskAddition => _taskListAdditionController.sink;

  Stream<List<Task>> get items => _tasks.stream;

  void dispose() {
    _tasks.close();
    _taskListAdditionController.close();
  }
}
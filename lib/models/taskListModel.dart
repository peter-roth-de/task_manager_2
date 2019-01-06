import 'dart:collection';
import 'package:scoped_model/scoped_model.dart';

import 'package:task_manager_2/models/task.dart';
import 'package:task_manager_2/models/taskList.dart';


class TaskListModel extends Model {
  final _taskList = TaskList();

  UnmodifiableListView<Task> get tasks => List.unmodifiable(_taskList.tasks);

  int get count => _taskList.count;

  void add(Task task) {
    _taskList.add(task);
    notifyListeners();
  }
}
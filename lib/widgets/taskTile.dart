import 'package:flutter/material.dart';

// task manager
import 'package:task_manager_2/models/task.dart';
import 'package:task_manager_2/models/taskList.dart';
import 'package:task_manager_2/util/utils.dart';

class TaskTile extends ListTile {
  Task _task;
  TaskTile(Task task) : super(
      title: new Text(task.getSubject()),
      subtitle: new Text(task.description!=null ? task.description.substring(1,30) : ""),
      leading: new Icon(
        Icons.check_circle,
        color: Colors.blue[500],
      ),
  ) {
    _task = task;
  }
}

class TaskTileList {
  static List<TaskTile> getTaskListTiles(TaskList taskList) {
    List<TaskTile> taskTiles = [];
    taskList.tasks.forEach((t) => _processTask(taskTiles, t));
    //tasks.forEach((k,v) => _processTask(taskTiles, k, v));
    return taskTiles;
  }

  static void _processTask(List<TaskTile> taskTiles, t) {
    Utils.logC('${t}');
    TaskTile tt = new TaskTile(t);
    taskTiles.add(tt);
  }
}


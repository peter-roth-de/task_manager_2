/***
 * inspired by
 * https://github.com/filiph/state_experiments/blob/master/shared/lib/src/bloc/cart_provider.dart
 */
import 'package:flutter/widgets.dart';
import 'package:task_manager_2/bloc/taskListBloc.dart';

/// This is an InheritedWidget that wraps around [TaskListBloc]. Think about this
/// as Scoped Model for that specific class.
///
/// This merely solves the "passing reference down the tree" problem for us.
/// You can solve this in other ways, like through dependency injection.
///
/// Also note that this does not call [TaskListBloc.dispose]. If your app
/// ever doesn't need to access the taskList, you should make sure it's
/// disposed of properly.
class TaskProvider extends InheritedWidget {
  final TaskListBloc taskListBloc;

  TaskProvider({
    Key key,
    TaskListBloc taskListBloc,
    Widget child,
  })  : taskListBloc = taskListBloc ?? TaskListBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TaskListBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(TaskProvider) as TaskProvider)
          .taskListBloc;
}
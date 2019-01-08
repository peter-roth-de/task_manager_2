import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';

import 'package:task_manager_2/auth/sapCopinAccount.dart';
import 'package:task_manager_2/data/copinTaskController.dart';
import 'package:task_manager_2/widgets/taskTile.dart';
import 'package:task_manager_2/widgets/taskDetail.dart';
import 'package:task_manager_2/models/taskList.dart';
import 'package:task_manager_2/util/utils.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  TaskList _taskList = null;
  List<Widget> taskTiles = <Widget>[];
  bool hasLoaded = false;

  final PublishSubject account = PublishSubject<SAPCopinAccount>();
  //final PublishSubject account2 = PublishSubject<String>();
  //final PublishSubject subject = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    account.listen(_readTasks);
    //subject.stream.debounce(Duration(milliseconds: 400)).listen(readTest1);
        //.debounce(Duration(milliseconds: 400)).listen(searchMovies);

    // Initialize and login to COPIN
    final future = SAPCopinAccount().init(this.context);
    future.then((_) {
      //account.add("login successful");
      //subject.add("abc");
      account.add(SAPCopinAccount());
    });


/***
    // Initialize and login to COPIN
    final future = SAPCopinAccount().init(this.context);

    // Read tasks from COPIN, once Copin login was successfully executed
    future.then((_) {
      CopinTaskController taskCtrl = new CopinTaskController();

      // read COPIN tasks
      Future<TaskList> f_taskList = taskCtrl.getTaskList(SAPCopinAccount().getToken());

      // once the tasks are read process them.
      f_taskList.then((taskList) {
        _taskList = taskList;
        Utils.logC("Task Count: " + _taskList.count.toString());
        _taskTiles = TaskTileList.getTaskListTiles(_taskList);
      },
          onError: (e) => Utils.logEx(e, "CopinTaskController.getTask() failed "));
    },
    onError: (e) => Utils.logEx(e, "SAPCopinAccount().init() failed "));
    ***/
  }

  void readTest1(s){
    Utils.logC("readTest1 called");
  }

  _readTasks(account) {
  //_readTasks(String s) {
    CopinTaskController taskCtrl = new CopinTaskController();
    setState(() => hasLoaded = false);
    // read COPIN tasks
    Future<TaskList> f_taskList = taskCtrl.getTaskList(SAPCopinAccount().getToken());

    // once the tasks are read process them.
    f_taskList
        .then((taskList) {
          _taskList = taskList;
          Utils.logC("Task Count: " + _taskList.count.toString());
          taskTiles = TaskTileList.getTaskListTiles(_taskList);
          setState(() => hasLoaded = true);
        },
        onError: (e) {
          Utils.logEx(e, "CopinTaskController.getTask() failed ");
          setState(() => hasLoaded = true);
        }
    );
  }

  @override
  void dispose() {
    account.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    Utils.logC("Widget build ...");
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("Task Manager 2"),
      ),

      /*body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            hasLoaded ? Container() : CircularProgressIndicator(),
            Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: taskTiles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return taskTiles[index];//new MovieView(movies[index], db);
                  },
                ))
          ],
        ),
      ),*/

      body: Center(
        child: hasLoaded ? ListView.builder(
          itemCount: _taskList.count,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_taskList.tasks[index].subject),
              subtitle: new Text(_taskList.tasks[index].description!=null ? _taskList.tasks[index].description.substring(1,30) : ""),
              leading: new Icon(
                Icons.check_circle,
                color: Colors.blue[500],
              ),
              // When a user taps on the ListTile, navigate to the DetailScreen.
              // Notice that we're not only creating a DetailScreen, we're
              // also passing the current todo through to it!
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskDetail(task: _taskList.tasks[index]),
                  ),
                );
              },
            );
          },
        ) : CircularProgressIndicator(),
      ),
/*
      body: Center(
          child: hasLoaded ? ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: taskTiles,

          ) : CircularProgressIndicator(),
      ),
      */
//      floatingActionButton: new FloatingActionButton(
//        //onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: new Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


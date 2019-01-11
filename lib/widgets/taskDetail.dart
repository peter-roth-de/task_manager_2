import 'package:flutter/material.dart';
import 'package:task_manager_2/models/task.dart';

class TaskDetail extends StatelessWidget {

  TaskDetail({Key key, @required this.task}) : super(key: key);
  // TaskDetail(this._task);
  //TaskDetail(this._task, {@required this.onClick});
  String _url="https://www.google.de/imgres?imgurl=http%3A%2F%2Fwww.taskeuproject.com%2Fwp-content%2Fuploads%2F2017%2F12%2FTASKlogodeftrasp.png&imgrefurl=http%3A%2F%2Fwww.taskeuproject.com%2Fabout-2%2F&docid=F8N6p7RzjglWHM&tbnid=fH3Qtd-QTWk_MM%3A&vet=10ahUKEwiIsYnNw97fAhXGPFAKHQb8BDEQMwg_KAYwBg..i&w=1574&h=622&bih=1058&biw=1920&q=task&ved=0ahUKEwiIsYnNw97fAhXGPFAKHQb8BDEQMwg_KAYwBg&iact=mrc&uact=8";
  final Task task;

  final VoidCallback onClick=null;


  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      //onTap : onClick,
      child: new Container(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  //new Hero(child: new Image.network(_url, height: 150.0, width: 100.0,), tag: task.getTaskId()),
                  new Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(top : 8.0, left: 24.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(task.getSubject(), style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0), overflow: TextOverflow.ellipsis, maxLines: 2,),
                          new SizedBox(height: 4.0,),
                          new Text(task.description!=null ? task.description : ""),
                          //   new SizedBox(height: 8.0,),
                          //    new Text(_short(book.subtitle, 30)),
                        ],
                      ),
                    ),
                  ),
                  new SizedBox(width: 16.0,)
                ],
              ),
              new Divider(color: Colors.black38, indent: 128.0,),
            ],
          ),
        ),
      ),
    );

  }

}
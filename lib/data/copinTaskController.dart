/**
 * CRUD task from/through COPIN services
 */

import 'package:http/http.dart' as http;
import 'dart:io'; // http const
import 'dart:convert';
import 'package:intl/intl.dart';

// task_manager_2
import 'package:task_manager_2/models/task.dart';
import 'package:task_manager_2/models/taskList.dart';
import 'package:task_manager_2/auth/authToken.dart';
import 'package:task_manager_2/config/sapCopinConfig.dart';
import 'package:task_manager_2/globals.dart';
import 'package:task_manager_2/util/utils.dart';



class CopinTaskController {

  //@todo implement task cache

  //dummy until dynamic is implemented
  String _projectUuid = "1ad693c2-78e6-46f8-a59f-2948bd41aa68";

  static const String TASK_LIST_STD_FILTER = "\$skip=0&\$top=20&\$orderby=DueDate%20asc&\$inlinecount=allpages";

  String getProjectFilterUriParam(String projectUuid) {
    return "&\$filter=ProjectUuid%20eq%20%27$projectUuid%27";
  }

  String getTaskUrl(String projectUuid, String format) {
    String url =  SapCopinStaging.TASK_SRV
         + SapCopinStaging.TASK_SRV_POSTFIX
         + "?" + TASK_LIST_STD_FILTER
         + "&" + getProjectFilterUriParam(projectUuid);
    format!=null ? url=url+"&\$format=$format" : url;
    Utils.logC("URL: " + url);
    return url;
  }

  String getTaskMetadataUrl(String format) {
    return SapCopinStaging.TASK_SRV
        + SapCopinStaging.TASK_SRV_POSTFIX
        + ODATA.PARAM_METADATA;
  }

  String getCreateTaskUrl() {
    return SapCopinStaging.TASK_SRV
        + SapCopinStaging.TASK_SRV_POSTFIX;
  }

  //Future<List<Task>> getTasks(AuthToken token) async {
  Map old_getTasks(AuthToken token) {
    Map<String, Task> tasks = {};
    //@todo call COPIN API
    //'Authorization': 'Bearer ' + accessToken
    // final response = await http.get(
    final Future<http.Response> f_response = http.get(
      getTaskUrl(_projectUuid, FORMAT.JSON),
      headers: {
        HttpHeaders.authorizationHeader: token.token_type + " " + token.access_token,
        HttpHeaders.contentTypeHeader: "application/json"
      },
    );
    print("--- readTasks() response: " );
      f_response.then((response) {
        if (response.statusCode == 200) {
          print("--- success full call readTasks()");
          print("Body: " + response.body);
          // print("BodyBytes: " + response.bodyBytes.toString());

          List<dynamic> list = json.decode(response.body)['d']["results"];
          // var s2 =  response.body["results"]["Category"],

          // create task map
          for(dynamic jsonTask in list) {
            Task task = _parseTask(jsonTask);
            tasks[task.id] = task;
          }

        } else {
          print("--- readTasks() failed " + response.statusCode.toString());
        }
      },
      onError: (e){
        Utils.logC("getTask() " + e.toString());
        throw e;
      });
    return tasks;
  }

  Future<Map> getTasksMap(AuthToken token) async {
    Map<String, Task> tasks = {};
    //@todo call COPIN API
    //'Authorization': 'Bearer ' + accessToken
    // final response = await http.get(
    final http.Response response = await http.get(
      getTaskUrl(_projectUuid, FORMAT.JSON),
      headers: {
        HttpHeaders.authorizationHeader: token.token_type + " " + token.access_token,
        HttpHeaders.contentTypeHeader: "application/json"
      },
    );
    print("--- readTasks() response: " + response.toString());
    if (response.statusCode == 200) {
      print("--- success full call readTasks()");
      print("Body: " + response.body);
      // print("BodyBytes: " + response.bodyBytes.toString());

      List<dynamic> list = json.decode(response.body)['d']["results"];
      // var s2 =  response.body["results"]["Category"],

      // create task map
      for(dynamic jsonTask in list) {
        Task task = _parseTask(jsonTask);
        tasks[task.id] = task;
      }

    } else {
      print("--- readTasks() failed " + response.statusCode.toString());
    }
    return tasks;
  }

  Future<TaskList> getTaskList(AuthToken token) async {
    TaskList taskList = new TaskList();
    //@todo call COPIN API
    //'Authorization': 'Bearer ' + accessToken
    // final response = await http.get(
    final http.Response response = await http.get(
      getTaskUrl(_projectUuid, FORMAT.JSON),
      headers: {
        HttpHeaders.authorizationHeader: token.token_type + " " + token.access_token,
        HttpHeaders.contentTypeHeader: "application/json"
      },
    );
    Utils.logC("readTaskList() response: " + response.toString());
    if (response.statusCode == 200) {
      Utils.logC("success full call readTasks()");
      Utils.logC("Body: " + response.body);
      // print("BodyBytes: " + response.bodyBytes.toString());

      List<dynamic> list = json.decode(response.body)['d']["results"];
      // var s2 =  response.body["results"]["Category"],

      // create task map
      for(dynamic jsonTask in list) {
        Task task = _parseTask(jsonTask);
        taskList.add(task);
      }

    } else {
      Utils.logC("readTasks() failed " + response.statusCode.toString());
    }
    return taskList;
  }

  Future<void> createTask(AuthToken token) async {

    var url = getCreateTaskUrl();
    var body;

    DateFormat df = new DateFormat("de_DE");
    String addDate = df.add_yMd().add_jm().format(new DateTime.now());

    body = json.encode({"ProjectUuid": "1ad693c2-78e6-46f8-a59f-2948bd41aa68","Subject": "subject: created through task app at $addDate"});
    Map<String, String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader : token.token_type + " " + token.access_token,
    };

    final response = await http.post(url, body: body, headers: headers);
    final responseJson = json.decode(response.body);
    Utils.logC(responseJson.toString());
//    return response;
//
//    final http.Response response = await http.post(
//      getCreateTaskUrl()(),
//      headers: {
//        HttpHeaders.authorizationHeader: token.token_type + " " + token.access_token,
//        HttpHeaders.contentTypeHeader: "application/json"
//      },
//    );
  }

  Task _parseTask(jsonTask) {
    return new Task(
        id: jsonTask["Id"],
        uuid: jsonTask["Uuid"],
        subject: jsonTask["Subject"],
        description: jsonTask["Description"]
    );

  }
}
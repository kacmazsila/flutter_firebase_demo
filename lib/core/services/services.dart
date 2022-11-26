import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

import '../model/task.dart';

class FireBaseService {
  static const String firebaseUrl = 'https://TodoAppDB.firebaseio.com/';

  Future<List<Task>> getTasks() async {
    List<Task> tasklist = <Task>[];

    final response = await http.get(Uri.parse(firebaseUrl + 'tasks.json'));
    switch (response.statusCode) {
      case 200:
        final jsonModel = json.decode(response.body) as Map;
        jsonModel.forEach((key, value) {
          Task task = Task.fromJson(value);
          task.key = key;
          tasklist.add(task);
        });

        return tasklist;

      default:
        return Future.error(response.statusCode);
    }
  }

  Future<bool> deleteTasks(String key) async {
    final response =
        await http.delete(Uri.parse(firebaseUrl + 'tasks/$key.json'));

    switch (response.statusCode) {
      case 200:
        return true;
      default:
        return false;
    }
  }

  Future<bool> undoDeletedTask(Task deletedTask) async {
    final response = await http.post(Uri.parse(firebaseUrl + 'tasks.json'),
        body: json.encode(deletedTask));

    switch (response.statusCode) {
      case 200:
        return true;
      default:
        return false;
    }
  }

  Future<bool> updateTask(Task updateTask) async {
    updateTask.done = true;

    final response = await http.put(
        Uri.parse(firebaseUrl + 'tasks/${updateTask.key}.json'),
        body: json.encode(updateTask.toJson()));
    switch (response.statusCode) {
      case 200:
        return true;
      default:
        return false;
    }
  }
}

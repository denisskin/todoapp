import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/api/api.dart';
import 'package:todoapp/providers/models/task.dart';
import 'package:todoapp/utils/utils.dart';

abstract class DB {
  static final tasks = TasksDB();
}

class TasksDB {
  List<Task?> rows = [];

  final api = ApiClient();
  final deviceId = uniqueId();
  final List<Function> subscriptions = [];

  TasksDB() {
    _initData();
  }

  _initData() async {
    _setData(await _tasksFromDisk());
    final apiData = await api.getTasks();
    if (api.revision > await _fsRevision()) {
      _setData(apiData);
      _flush();
    }
  }

  _setData(List<Task?> data) {
    rows = data;
    for (var fn in subscriptions) {
      fn();
    }
  }

  List<Task?> listAll() {
    return rows;
  }

  List<Task?> listCurrent() {
    // select uncompleted tasks only
    final arr = <Task?>[];
    for (var task in rows) {
      if (!task!.done) arr.add(task);
    }
    return arr;
  }

  int countCompleted() {
    int n = 0;
    for (var task in rows) {
      if (task!.done) n++;
    }
    return n;
  }

  Task get(String id) {
    final i = _idx(id);
    if (i >= 0) return rows[i]!.copy();
    return Task();
  }

  update(Task task) async {
    task.refreshUpdateTime();
    if (task.isNew()) {
      task.id = uniqueId(); // set id
      task.lastUpdatedBy = deviceId;
      rows.add(task);
    } else {
      rows[_idx(task.id)] = task;
    }
    _flush();
  }

  remove(String id) async {
    rows.removeAt(_idx(id));
    _flush();
  }

  int _idx(String id) {
    for (int i = 0; i < rows.length; i++) {
      if (rows[i]!.id == id) return i;
    }
    return -1;
  }

  subscribe(Function callback) {
    subscriptions.add(callback);
  }

  _flush() async {
    await _saveToDisk('tasks', rows);
    _setData(await api.updateTasks(rows));
    await _saveToDisk('tasks.rev', api.revision);
  }

  static Future<int> _fsRevision() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('tasks.rev') ?? 0;
  }

  static Future<List<Task?>> _tasksFromDisk() async {
    final prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('tasks');
    if (value == null) return [];
    return Task.listFromJson(jsonDecode(value) as List<dynamic>);
  }

  static Future<void> _saveToDisk(String key, Object obj) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(obj));
  }
}

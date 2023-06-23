import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/api.dart';
import 'package:todoapp/task.dart';
import 'package:todoapp/utils.dart';

abstract class DB {
  static final tasks = TasksDB();
}

class TasksDB {
  int rev = 0;
  List<Task?> rows = [];
  final api = ApiClient();
  final deviceId = uniqueId();

  TasksDB() {
    _initData();
  }

  _initData() async {
    rows = await _tasksFromDisk();
    rev++;
    final apiRows = await api.getTasks();
    if (api.revision > (await _fsRevision())) {
      rows = apiRows;
      _flush();
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

  onUpdate(void callback()) async {
    int r = rev;
    const duration = Duration(milliseconds: 300);
    Timer.periodic(duration, (_) {
      if (r != rev) {
        r = rev;
        callback();
      }
    });
  }

  _flush() async {
    await _saveToDisk('tasks', rows);
    rows = await api.updateTasks(rows);
    rev++;
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

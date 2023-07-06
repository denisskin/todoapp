import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/providers/models/task.dart';

abstract class DB {
  static final tasks = TasksDB();
}

class TasksDB {
  List<Task> _rows = [];

  // subscriptions on data update
  final List<Function> _subscriptions = [];

  TasksDB() {
    _initData();
  }

  _initData() async {
    setData(await _loadFromDisk());
  }

  List<Task> listAll() {
    return _rows;
  }

  List<Task> listCurrent() {
    // select uncompleted tasks only
    final arr = <Task>[];
    for (var task in _rows) {
      if (!task.done) arr.add(task);
    }
    return arr;
  }

  int countCompleted() {
    int n = 0;
    for (var task in _rows) {
      if (task.done) n++;
    }
    return n;
  }

  Task get(String id) {
    final i = _idx(id);
    if (i >= 0) return _rows[i].copy();
    return Task();
  }

  setData(List<Task> rows) {
    _rows = rows;
    _flush();
  }

  update(Task task) async {
    await task.refreshTime();
    final i = _idx(task.id);
    if (i == -1) {
      _rows.add(task);
    } else {
      _rows[i] = task;
    }
    _flush();
  }

  remove(String id) async {
    _rows.removeAt(_idx(id));
    _flush();
  }

  onUpdate(Function callback) {
    _subscriptions.add(callback);
  }

  int _idx(String id) {
    for (int i = 0; i < _rows.length; i++) {
      if (_rows[i].id == id) return i;
    }
    return -1;
  }

  static const _dbKey = 'tasks';

  _flush() async {
    try {
      // save data to disk
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_dbKey, jsonEncode(_rows));
    } catch (e) {
      //Log.l.d('db> _flush-error: ${e.toString()}');
    }

    for (var fn in _subscriptions) {
      fn();
    }
  }

  Future<List<Task>> _loadFromDisk() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? value = prefs.getString(_dbKey);
      if (value == null) return [];
      return Task.listFromJson(jsonDecode(value) as List<dynamic>);
    } catch (e) {
      //Log.l.d('db> _loadFromDisk-error: ${e.toString()}');
      return [];
    }
  }
}

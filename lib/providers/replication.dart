import 'dart:async';

import 'package:todoapp/api/api.dart';
import 'package:todoapp/providers/db.dart';
import 'package:todoapp/providers/models/task.dart';
import 'package:todoapp/utils/logger.dart';

abstract class Replication {
  static final client = ApiClient();

  static start() async {
    DB.tasks.onUpdate(_sync);
    _sync();
  }

  static _sync() async {
    try {
      Log.l.i('replication> sync...');
      final srvData = await client.getTasks();
      final locData = DB.tasks.listAll();
      final locVer = Task.dataVersion(locData);
      final srvVer = Task.dataVersion(srvData);
      Log.l.i('replication> local-data-ver:$locVer, server-data-ver:$srvVer');
      if (locVer == srvVer) return;
      if (locVer > srvVer) {
        final mergedData = await client.updateTasks(locData);
        DB.tasks.setData(mergedData);
      } else {
        DB.tasks.setData(srvData);
      }
    } catch (e) {
      Log.l.e('replication> error: ${e.toString()}');
      // on connection error try syncing data later
      Timer(const Duration(seconds: 30), _sync);
    }
  }
}

import 'dart:async';

import 'package:todoapp/api/api.dart';
import 'package:todoapp/app/di.dart';
import 'package:todoapp/app/logger.dart';
import 'package:todoapp/models/task.dart';

abstract class Replication {
  static final client = ApiClient();

  static start() async {
    Locator.tasks.onUpdate(_sync);
    _sync();
  }

  static _sync() async {
    try {
      logger.i('replication> sync...');
      final srvData = await client.getTasks();
      final locData = Locator.tasks.listAll();
      final locVer = Task.dataVersion(locData);
      final srvVer = Task.dataVersion(srvData);
      logger.i('replication> local-data-ver:$locVer, server-data-ver:$srvVer');
      if (locVer == srvVer) return;
      if (locVer > srvVer) {
        final mergedData = await client.updateTasks(locData);
        Locator.tasks.setData(mergedData);
      } else {
        Locator.tasks.setData(srvData);
      }
    } catch (e) {
      logger.e('replication> error: ${e.toString()}');
      // on connection error try syncing data later
      Timer(const Duration(seconds: 30), _sync);
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:todoapp/pages/home_page.dart';
import 'package:todoapp/pages/task_page.dart';

abstract class AppRoutes {
  static const home = '/';
  static const task = '/task';

  static final routes = <String, WidgetBuilder>{
    home: (_) => const HomePage(),
    task: (context) => TaskPage(id: _routeArg(context)),
  };

  static goHome(BuildContext context) async {
    await Navigator.of(context).pushNamed(home);
  }

  static openNewTask(BuildContext context) async {
    await openTask(context);
  }

  static openTask(BuildContext context, {String id = ''}) async {
    await Navigator.of(context).pushNamed(task, arguments: id);
  }

  static String _routeArg(BuildContext context) {
    return (ModalRoute.of(context)?.settings.arguments ?? '') as String;
  }
}

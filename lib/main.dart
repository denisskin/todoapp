import 'package:flutter/material.dart';
import 'package:todoapp/homepage.dart';
import 'package:todoapp/taskpage.dart';
import 'package:todoapp/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ya To Do App',
      theme: MyTheme.appTheme,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/task': (ctx) => TaskPage(id: routeArg(ctx)),
      },
    );
  }
}

int routeArg(BuildContext context) {
  return (ModalRoute.of(context)?.settings.arguments ?? 0) as int;
}

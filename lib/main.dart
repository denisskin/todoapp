import 'package:flutter/material.dart';
import 'package:todoapp/homepage.dart';
import 'package:todoapp/taskpage.dart';
import 'package:todoapp/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ya To Do App',

      theme: MyTheme.lightAppTheme,
      // darkTheme: MyTheme.darkAppTheme,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/task': (context) => TaskPage(id: routeArg(context)),
      },
    );
  }
}

int routeArg(BuildContext context) {
  return (ModalRoute.of(context)?.settings.arguments ?? 0) as int;
}

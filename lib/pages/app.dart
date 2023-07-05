import 'package:flutter/material.dart';
import 'package:todoapp/pages/home_page.dart';
import 'package:todoapp/pages/task_page.dart';
import 'package:todoapp/themes/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ya To Do App',

      theme: AppTheme.lightAppTheme,
      // darkTheme: MyTheme.darkAppTheme,
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/task': (context) => TaskPage(id: routeArg(context)),
      },
    );
  }
}

String routeArg(BuildContext context) {
  return (ModalRoute.of(context)?.settings.arguments ?? '') as String;
}
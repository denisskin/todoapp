import 'package:flutter/material.dart';
import 'package:todoapp/app/route.dart';
import 'package:todoapp/themes/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ya ToDo List Application',
      routes: AppRouter.routes,
      initialRoute: AppRouter.home,
      theme: AppTheme.lightAppTheme,
    );
  }
}

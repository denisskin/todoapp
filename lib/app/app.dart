import 'package:flutter/material.dart';
import 'package:todoapp/app/routes.dart';
import 'package:todoapp/themes/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ya To Do App',

      theme: AppTheme.lightAppTheme,
      // darkTheme: MyTheme.darkAppTheme,
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.home,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todoapp/homepage.dart';
import 'package:todoapp/taskpage.dart';
import 'package:todoapp/testpage.dart';

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
      theme: appTheme(context),
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
        '/task': (ctx) => TaskPage(id: routeArg(ctx)),
        '/test': (_) => TestPage(),
      },
    );
  }
}

ThemeData appTheme(BuildContext context) {
  final brightness = MediaQuery.of(context).platformBrightness;
  if (brightness == Brightness.dark) {
    // theme = brightness == Brightness.dark ? ThemeData.dark() : ThemeData.light()
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
    );
  }
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    //useMaterial3: true,
  );
}

int routeArg(BuildContext context) {
  return (ModalRoute.of(context)?.settings.arguments ?? 0) as int;
}

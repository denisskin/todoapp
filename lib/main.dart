import 'package:flutter/material.dart';
import 'package:todoapp/homepage.dart';
import 'package:todoapp/storage.dart';
import 'package:todoapp/taskpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final db = Storage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO Application',
      theme: appTheme(context),
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(store: db),
        '/task': (ctx) => TaskPage(store: db, id: routeArg(ctx)),
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

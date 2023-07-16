import 'package:flutter/material.dart';
import 'package:todoapp/app/app.dart';
import 'package:todoapp/app/di.dart';

void main() async {
  await Locator.init();
  runApp(const App());
}

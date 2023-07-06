import 'package:flutter/material.dart';
import 'package:todoapp/pages/app.dart';
import 'package:todoapp/providers/replication.dart';

void main() {
  Replication.start();
  runApp(const MyApp());
}

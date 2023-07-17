import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:todoapp/data/config_repository.dart';
import 'package:todoapp/data/replication.dart';
import 'package:todoapp/data/tasks_local.dart';
import 'package:todoapp/data/tasks_repository.dart';

import '../firebase_options.dart';
import 'logger.dart';

abstract class Locator {
  static final _locator = GetIt.instance;

  static FirebaseAnalytics get analytics => FirebaseAnalytics.instance;
  static TasksRepository get tasksRepository => _locator<TasksRepository>();
  static ConfigRepository get configRepository => _locator<ConfigRepository>();
  static TasksDB get tasks => _locator<TasksDB>();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    Replication.start();

    await _initFirebase();
    _initCrashlytics();

    final localTasks = TasksDB();
    _locator.registerSingleton<TasksDB>(localTasks);

    _locator.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance);
    _locator.registerLazySingleton<FirebaseRemoteConfig>(
        () => FirebaseRemoteConfig.instance);
    final configRepo = ConfigRepository(_locator<FirebaseRemoteConfig>());
    await configRepo.init();
    _locator.registerSingleton<ConfigRepository>(configRepo);
  }

  static Future<void> _initFirebase() async {
    logger.d('Firebase initialization started');

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    logger.d('Firebase initialized');
  }

  static void _initCrashlytics() {
    FlutterError.onError = (errorDetails) {
      logger.d('Caught error in FlutterError.onError');
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      logger.d('Caught error in PlatformDispatcher.onError');
      FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: true,
      );
      return true;
    };
    logger.d('Crashlytics initialized');
  }

  static Future<void> dispose() async {}
}

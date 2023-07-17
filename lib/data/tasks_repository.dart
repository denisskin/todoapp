import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/app/logger.dart';
import 'package:todoapp/models/task.dart';

class TasksRepository {
  final FirebaseFirestore _firestore;

  TasksRepository(this._firestore);

  late final _tasksCollectionRef = _firestore.collection('tasks').withConverter(
        fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
        toFirestore: (lesson, _) => lesson.toJson(),
      );

  Stream<List<Task>> get tasksStream => _tasksCollectionRef
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  // ---------- FOR TESTING PURPOSE -------------------------------
  Future<void> putTasks(List<Task> tasks) async {
    // for (final task in tasks) {
    //   await _tasksCollectionRef.add(task);
    // }
    await _firestore.runTransaction((tx) async {
      for (final task in tasks) {
        tx.set(_tasksCollectionRef.doc(), task);
      }
    });

    logger.d('TasksRepository> putTasks');
  }

  Future<void> clearDatabase() async {
    final tasks = await _tasksCollectionRef.get();
    await _firestore.runTransaction((transaction) async {
      for (final doc in tasks.docs) {
        transaction.delete(doc.reference);
      }
    });
    logger.d('TasksRepository> Cleared Database');
  }
}

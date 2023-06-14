import 'package:flutter/material.dart';
import 'package:todoapp/storage.dart';

class HomePage extends StatefulWidget {
  final Storage store;

  const HomePage({
    super.key,
    required this.store,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final store = widget.store;
    final tasks = store.listTasks();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Мои дела'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index]!;
          return ListTile(
            title: Text(task.title),
            leading: Checkbox(
              value: task.completed,
              onChanged: (v) => setState(() {
                task.completed = v as bool;
                store.setTask(task);
              }),
            ),
            onTap: () => openTask(context, task.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add task',
        child: const Icon(Icons.add),
        onPressed: () => addTask(context),
      ),
    );
  }

  openTask(BuildContext context, int id) async {
    await Navigator.of(context).pushNamed('/task', arguments: id);
    setState(() {});
  }

  addTask(BuildContext context) async {
    final id = widget.store.addTask();
    openTask(context, id);
  }

  // Widget taskTile(BuildContext context, Task task ){
  //   return
  // }
}

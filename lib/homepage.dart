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
  bool fViewAll = false;

  @override
  Widget build(BuildContext context) {
    final store = widget.store;
    final tasks = fViewAll ? store.allTasks() : store.currentTasks();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Мои дела (${store.countCompletedTasks()})'),
        centerTitle: false,
        actions: [
          IconButton(
            icon:
                Icon(fViewAll ? Icons.visibility_sharp : Icons.visibility_off),
            onPressed: () => setState(() {
              fViewAll = !fViewAll;
            }),
          ),
        ],
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
                task.completed = v!;
                store.updateTask(task);
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
}

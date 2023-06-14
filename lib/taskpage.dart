import 'package:flutter/material.dart';
import 'package:todoapp/storage.dart';

class TaskPage extends StatefulWidget {
  final Storage store;
  final int id;

  const TaskPage({
    super.key,
    required this.store,
    required this.id,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Task task = Task();

  _TaskPageState();

  @override
  void initState() {
    super.initState();

    task = widget.store.getTaskByID(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: close,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              initialValue: task.title,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Что надо сделать...',
                filled: true,
                fillColor: Colors.white,
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10.0),
                // ),
              ),
              validator: (v) => v!.isEmpty ? 'Пожалуйста, введите текст' : null,
              onChanged: (v) => setState(() {
                task.title = v;
              }),
            ),
            // CheckboxListTile(
            //   title: const Text('Done'),
            //   value: task.completed,
            //   onChanged: (v) => setState(() {
            //     task.completed = v!;
            //   }),
            // ),
            ListTile(
              title: const Text('Сделать до'),
              subtitle:
                  Text(task.to != null ? task.to.toString() : 'Выберите дату'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            const Text('Важность'),
            DropdownButtonFormField<String>(
              value: task.priority,
              onChanged: (v) => setState(() {
                task.priority = v!;
              }),
              hint: const Text('Важность'),
              items: const [
                DropdownMenuItem(
                  value: '',
                  child: Text('Нет'),
                ),
                DropdownMenuItem(
                  value: 'low',
                  child: Text('Низкий'),
                ),
                DropdownMenuItem(
                  value: 'high',
                  child: Text('!! Высокий'),
                  //, style: TextStyle(color: Colors.red)
                ),
              ],
            ),
            TextButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text('Удалить'),
              onPressed: delete,
            ),
          ],
        ),
      ),
    );
  }

  delete() {
    close();
  }

  close() {
    Navigator.of(context).pop();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: task.to ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    setState(() {
      task.to = picked;
    });
  }
}

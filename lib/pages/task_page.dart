import 'package:flutter/material.dart';
import 'package:todoapp/providers/models/task.dart';
import 'package:todoapp/providers/db.dart';
import 'package:todoapp/themes/theme.dart';

class TaskPage extends StatefulWidget {
  final String id;

  const TaskPage({
    super.key,
    required this.id,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Task task = Task();

  @override
  void initState() {
    super.initState();
    task = DB.tasks.get(widget.id);
  }

  bool get saveEnabled => task.text.isNotEmpty;
  bool get removeEnabled => !task.isNew();

  @override
  Widget build(BuildContext context) {
    final importance =
        task.importance != '' ? task.importance : Task.importanceBasic;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: close,
        ),
        actions: [
          TextButton(
            onPressed: saveEnabled ? save : null,
            child: Text(
              'СОХРАНИТЬ',
              style: AppTheme.appBarPrimaryButton,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //------ text field -------
                  Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(8),
                    child: TextFormField(
                      initialValue: task.text,
                      onChanged: (v) => setState(() {
                        task.text = v;
                      }),
                      autofocus: true,
                      style: AppTheme.regularBodyText,
                      minLines: 4,
                      maxLines: 50,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: AppTheme.backSecondary,
                        filled: true,
                        hintText: 'Что надо сделать…',
                        hintStyle: AppTheme.regularHintText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  //------ priority --------
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Важность', style: AppTheme.regularBodyText),
                      DropdownButtonFormField<String>(
                        style: AppTheme.smallBodyText,
                        value: importance,
                        onChanged: (v) => setState(() {
                          task.importance = v!;
                        }),
                        hint: const Text('Важность'),
                        decoration: const InputDecoration(
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: Task.importanceBasic,
                            child: Text('Нет'),
                          ),
                          DropdownMenuItem(
                            value: Task.importanceLow,
                            child: Text('Низкий'),
                          ),
                          DropdownMenuItem(
                            value: Task.importanceImportant,
                            child: Text('!! Высокий',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    ],
                  ),

                  _separator,
                ],
              ),
            ),

            //------ data picker ---------
            ListTile(
              title: const Text('Сделать до'),
              onTap: () => _selectDate(context),
              subtitle: task.isDeadlineSelected()
                  ? Text(task.deadlineString(),
                      style: const TextStyle(color: AppTheme.colorBlue))
                  : const Text('Выберите дату'),
              trailing: Switch(
                activeColor: AppTheme.colorBlue,
                value: task.isDeadlineSelected(),
                onChanged: (v) => v ? _selectDate(context) : clearDate(),
              ),
            ),

            //--- separator ---
            const SizedBox(height: 12),
            _separator,
            const SizedBox(height: 12),

            //--- delete button ---
            TextButton(
              onPressed: removeEnabled ? delete : null,
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.colorRed,
              ),
              child: const Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 16),
                  Text('Удалить'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _separator = ColoredBox(
    color: AppTheme.supportSeparator,
    child: SizedBox(height: 1, width: double.infinity),
  );

  save() {
    DB.tasks.update(task);
    close();
  }

  delete() {
    DB.tasks.remove(task.id);
    close();
  }

  close() {
    Navigator.of(context).pop();
  }

  clearDate() {
    setState(() {
      task.deadline = null;
    });
  }

  _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: task.deadline ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    setState(() {
      task.deadline = picked;
    });
  }
}

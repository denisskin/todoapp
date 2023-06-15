import 'package:flutter/material.dart';
import 'package:todoapp/db.dart';
import 'package:todoapp/theme.dart';

class TaskPage extends StatefulWidget {
  final int id;

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

  bool get saveEnabled => task.title.isNotEmpty;
  bool get removeEnabled => task.id != 0;

  @override
  Widget build(BuildContext context) {
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
              style: AppTheme.textAppbarPrimaryButton,
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
                      initialValue: task.title,
                      onChanged: (v) => setState(() {
                        task.title = v;
                      }),
                      autofocus: true,
                      style: AppTextStyles.regularBodyText,
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
                        hintStyle: AppTextStyles.regularHintText,
                      ),
                    ),
                  ),
                  SizedBox(height: 28),

                  //------ priority --------
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Важность', style: AppTextStyles.regularBodyText),
                      DropdownButtonFormField<String>(
                        style: AppTextStyles.smallBodyText,
                        value: task.priority,
                        onChanged: (v) => setState(() {
                          task.priority = v!;
                        }),
                        hint: const Text('Важность'),
                        decoration: const InputDecoration(
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                        ),
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
              subtitle: task.isDateSelected()
                  ? Text(task.to.toString(),
                      style: const TextStyle(color: AppTheme.colorBlue))
                  : Text('Выберите дату'),
              trailing: Switch(
                activeColor: AppTheme.colorBlue,
                value: task.isDateSelected(),
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
      task.to = null;
    });
  }

  _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
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

Widget _padding(double v, h, Widget child) {
  return Padding(
    padding: EdgeInsets.fromLTRB(v, h, v, h),
    child: child,
  );
}

Widget _margin(double v, h, Widget child) {
  return Container(
    // padding: EdgeInsets.fromLTRB(v, h, v, h),
    margin: EdgeInsets.fromLTRB(v, h, v, h),
    child: child,
  );
}

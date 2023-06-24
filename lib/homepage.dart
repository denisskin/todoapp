import 'package:flutter/material.dart';
import 'package:todoapp/db.dart';
import 'package:todoapp/task.dart';
import 'package:todoapp/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool fViewAll = false;

  _HomePageState() {
    DB.tasks.subscribe(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final tasks = fViewAll ? DB.tasks.listAll() : DB.tasks.listCurrent();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            backgroundColor: AppTheme.backPrimary,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Мои дела', style: AppTheme.appBarHeader),
              centerTitle: false,
            ),
            actions: [
              IconButton(
                icon: fViewAll ? AppTheme.iconViewAll : AppTheme.iconView,
                onPressed: () => setState(() {
                  fViewAll = !fViewAll;
                }),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(74, 0, 0, 0),
                    child: Text('Выполнено – ${DB.tasks.countCompleted()}',
                        style: AppTheme.textDone)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 20, 8, 40),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.colorWhite,
                      border: Border.all(color: AppTheme.colorWhite),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: tasks.length,
                          itemBuilder: (ctx, i) => _itemTile(ctx, tasks[i]!),
                        ),
                        _newTaskListButton(context),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Добавить',
        child: const Icon(Icons.add),
        onPressed: () => openTask(context),
      ),
    );
  }

  Widget _itemTile(BuildContext context, Task task) {
    return Dismissible(
      key: Key('${task.id}'),
      background: Container(
        color: AppTheme.colorGreen,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              Icon(Icons.check, color: Colors.white),
            ],
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.delete, color: Colors.white),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          setTaskComplete(task, true);
        } else {
          removeTask(task.id);
        }
        return false;
      },
      child: InkWell(
        onTap: () => openTask(context, id: task.id),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Checkbox(
                  value: task.done,
                  onChanged: (v) => setTaskComplete(task, v!),
                  activeColor: AppTheme.colorGreen,
                  side: task.isHighPriority() ? AppTheme.cbxHighBorder : null,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      task.text,
                      style: task.done
                          ? AppTheme.itemCompletedTextStyle
                          : AppTheme.itemRegularTextStyle,
                    ),
                    if (task.isDeadlineSelected())
                      Text(task.deadlineString(),
                          style: AppTheme.smallSecondaryText),
                  ],
                ),
              ),
              const SizedBox(
                width: 30,
                height: 30,
                child: Icon(
                  Icons.info_outline,
                  color: AppTheme.labelTertiary,
                  size: 27,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _newTaskListButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 20, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => openTask(context),
              child: Text(
                'Новое',
                style: AppTheme.buttonNewTask,
              ),
            ),
          ),
        ],
      ),
    );
  }

  openTask(BuildContext context, {String id = ''}) async {
    await Navigator.of(context).pushNamed('/task', arguments: id);
    setState(() {});
  }

  setTaskComplete(Task task, bool f) {
    setState(() {
      task.done = f;
      DB.tasks.update(task);
    });
  }

  removeTask(String id) {
    setState(() {
      DB.tasks.remove(id);
    });
  }
}

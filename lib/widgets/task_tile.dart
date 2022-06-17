import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:getwidget/getwidget.dart';

import '../blocs/bloc_exports.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          decoration: task.isDone! ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: GFCheckbox(
        activeBgColor: Colors.grey,
        activeIcon: Icon(Icons.done_all),
        size: GFSize.LARGE,
        type: GFCheckboxType.circle,
        onChanged: task.isDeleted == false
            ? (value) {
          context.read<TasksBloc>().add(UpdateTask(task: task));
        }
            : null,
        value: task.isDone??false,
        inactiveIcon: Icon(Icons.remove_done,color: Colors.grey,),
      ),
      leading: GFCheckbox(
              activeBgColor: Colors.grey,
              activeIcon: Icon(Icons.favorite),
              size: GFSize.SMALL,
              type: GFCheckboxType.circle,
              onChanged: task.isDeleted == false
                  ? (value) {
                context.read<TasksBloc>().add(FavoredTask(task: task));
              }
                  : null,
              value: task.isFavored??false,
              inactiveIcon: Icon(Icons.favorite_border,color: Colors.grey),
            ),
      onLongPress: () => _removeOrDeleteTask(context, task),
    );
  }
}


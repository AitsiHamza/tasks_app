import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/task.dart';

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
      trailing: Checkbox(
        value: task.isDone,
        onChanged: task.isDeleted == false
            ? (value) {
                context.read<TasksBloc>().add(UpdateTask(task: task));
              }
            : null,
      ),
      leading: Checkbox(
        value: task.isFavored,
        onChanged: task.isDeleted == false
            ? (value) {
                context.read<TasksBloc>().add(FavoredTask(task: task));
              }
            : null,
      ),
      onLongPress: () => _removeOrDeleteTask(context, task),
    );
  }
}
/*
Checkbox(
        value: task.isFavored,
        onChanged: task.isDone == false
            ? (value) {
                context.read<TasksBloc>().add(FavoredTask(task: task));
              }
            : null,
      ),
 */
/*
IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: task.isFavored == false
              ? () {
            context.read<TasksBloc>().add(UpdateTask(task: task));
          }
              : null,
      )
 */

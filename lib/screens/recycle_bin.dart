import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/widgets/tasks_list.dart';

import 'my_drawer.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({Key? key}) : super(key: key);

  static const id='recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<TasksBloc,TasksState>(
          builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle bin'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              )
            ],
          ),
          drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    '${state.removedTasks.length}Tasks:',
                  ),
                ),
              ),
              TasksList(tasksList: state.removedTasks)
            ],
          ),
        );
      }
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_bloc_aj/blocs/bloc_exports.dart';

import '../models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          var task = taskList[index];

          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.id),
            trailing: Checkbox(
              value: task.isDone,
              onChanged: (value) {
                print('checkbox ${task.id}');
                context.read<TasksBloc>().add(UpdateTaskEvent(task: task));
              },
            ),
            onLongPress: (() => context.read<TasksBloc>().add(
                  DeleteTaskEvent(task: task),
                )),
          );
        },
        itemCount: taskList.length,
      ),
    );
  }
}

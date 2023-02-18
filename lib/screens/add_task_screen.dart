import 'package:flutter/material.dart';
import 'package:todo_bloc_aj/blocs/bloc_exports.dart';
import 'package:todo_bloc_aj/services/guid_generator.dart';

import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        const Text(
          'Add Task',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          autofocus: true,
          autocorrect: true,
          controller: titleController,
          decoration: const InputDecoration(
              label: Text('Title'), border: OutlineInputBorder()),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('cancel'),
            ),
            ElevatedButton(
                onPressed: () {
                  var task = Task(
                    title: titleController.text.trim(),
                    id: GUIDGen.generate(),
                  );
                  context.read<TasksBloc>().add(AddTaskEvent(task: task));
                  Navigator.pop(context);
                },
                child: const Text('Add')),
          ],
        )
      ]),
    );
  }
}

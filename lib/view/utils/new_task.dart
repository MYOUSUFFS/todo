import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/provider.dart';
import 'package:todo/model/task.dart';

import '../widget/task_widget.dart';

newTaskTitle(BuildContext context) {
  final TextEditingController heading = TextEditingController();
  final provider = Provider.of<MainProvider>(context, listen: false);
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("New Heading"),
          content: TextFormField(
            autofocus: true,
            controller: heading,
            decoration: InputDecoration(
              hintText: "Heading",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (heading.text.isNotEmpty) {
                  provider.addTaskTitle(heading.text);
                  Navigator.pop(context);
                } else {
                  toast("Please fill all details!");
                }
              },
              child: const Text("Submit"),
            )
          ],
        );
      });
}

newTaskAdded(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Create your new task"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const TaskInput(),
        ),
      );
    },
  );
}

editTask(BuildContext context, TaskList task) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Edit Task"),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TaskEdit(
          task: task,
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/provider.dart';
import 'package:todo/model/task.dart';

import '../widget/task_widget.dart';

final TextEditingController heading = TextEditingController();
newTaskTitle(BuildContext context) {
  final provider = Provider.of<MainProvider>(context, listen: false);
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("New Heading"),
          content: TextFormField(
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
                provider.addTaskTitle(heading.text);
                Navigator.pop(context);
              },
              child: Text("Submit"),
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
        title: Text("Create your new task"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TaskInput(),
        ),
      );
    },
  );
}

editTask(BuildContext context,TaskList task) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Edit Task"),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TaskEdit(task: task,),
      ),
    ),
  );
}

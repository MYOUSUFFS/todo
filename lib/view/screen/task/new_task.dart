import 'package:flutter/material.dart';

newTaskAdded(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create your new task"),
          content: SizedBox(
              width: MediaQuery.of(context).size.width, child: TaskInput()),
        );
      });
}

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class TaskInput extends StatelessWidget {
  const TaskInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        decoration: InputDecoration(
          hintText: "Title",
          border: InputBorder.none,
        ),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              isCollapsed: true,
              hintText: "Details",
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.grey, fontSize: 12),
            minLines: 1,
            maxLines: 4,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Icon(Icons.calendar_today),
                  Text(" Date/Time"),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

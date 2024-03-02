import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UncompletedTask extends StatelessWidget {
  const UncompletedTask({super.key});

  Color identifyPriority(DateTime taskDate) {
    DateTime now = DateTime.now();
    // DateFormat().parse(date);

    if (taskDate.isBefore(now))
      return Colors.red; // If the task is overdue, show it in red color
    else if ((taskDate.day - now.day) <= 1 &&
        (taskDate.month == now.month || taskDate.year == now.year))
      return Colors.orange;
    else //(taskDate.day - now.day) > 1 && (taskDate.month == now.month || taskDate.year == now.year)
      return Colors.green;
    // else ((taskDate.day - now.day) <= 1 && (taskDate.month == now.month || taskDate.month == now.month + 1));
    // return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        DateTime _date = DateTime.now()
            .add(Duration(days: 10))
            .subtract(Duration(days: index));
        return ListTile(
          leading: Icon(Icons.circle_outlined),
          title: Text(
            'Uncompleted Task $index',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Task $index",
                style: TextStyle(
                    color: Colors.grey, overflow: TextOverflow.ellipsis),
                maxLines: 2,
              ),
              Text(
                DateFormat("EEE, dd MMM").format(_date),
                style: TextStyle(
                  color: identifyPriority(_date),
                ),
              ),
            ],
          ),
        );
      },
      //  Text("data $index"),
      itemCount: 100,
    );
  }
}

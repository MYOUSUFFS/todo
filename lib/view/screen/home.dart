import 'package:flutter/material.dart';
import 'package:todo/view/screen/task/task.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});
  final String taskList = "MyTask";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
            title: Text(
              "Tasks".toUpperCase(),
              style: TextStyle(
                letterSpacing: 2,
                // fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            subtitle: InkWell(
              onTap: () {},
              // borderRadius: BorderRadius.circular(20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$taskList",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down_sharp)
                ],
              ),
            )),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            MyTask(),
            Visibility(
              visible: false,
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                    top: Radius.circular(5),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 5),
                      blurRadius: 6,
                      spreadRadius: 4,
                      color: Color(0xFF000000).withOpacity(.20),
                    ),
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      title: Text("$taskList"),
                      leading: Icon(Icons.done_rounded),
                    ),
                    Divider(thickness: 1, color: Colors.grey.shade300),
                    ListTile(
                      title: Text("Create new list"),
                      leading: Icon(Icons.post_add),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

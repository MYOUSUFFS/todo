import 'package:flutter/material.dart';
import 'package:todo/view/screen/task/task.dart';

import '../widget/box_shadow.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});
  final String taskList = "MyTask";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              child: MyBoxShadow(
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
            Visibility(
              visible: false,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, right: 10),
                  child: MyBoxShadow(
                    top: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Text(
                            "Sort by",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            title: Text("New First"),
                            leading: Icon(Icons.done_rounded),
                          ),
                          ListTile(
                            title: Text("Old First"),
                            leading: Icon(null),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey.shade300,
                          ),
                          ListTile(
                            title: Text("Rename"),
                          ),
                          ListTile(
                            title: Text("Delete list"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

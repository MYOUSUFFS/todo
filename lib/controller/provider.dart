import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/task.dart';

class MainProvider with ChangeNotifier {
  final List<Task> _task = [];
  List<Task> get task => _task;

  // -------- Current Task begin -----------

  int currentTaskIs = 0;

  changeCurrentTask(int index) {
    currentTaskIs = index;
    notifyListeners();
  }

  //  -------- Current Task end   ----------

  // --------- Other options contole begin --------

  bool _mainTaskOption = false;
  bool get mainTaskOption => _mainTaskOption;

  doMainTaskOptions() {
    _mainTaskOption = !_mainTaskOption;
    _subTaskOption = false;
    notifyListeners();
  }

  bool _subTaskOption = false;
  bool get subTaskOption => _subTaskOption;

  doSubTaskOptions() {
    _subTaskOption = !_subTaskOption;
    _mainTaskOption = false;
    notifyListeners();
  }

  closeAllOption() {
    _mainTaskOption = false;
    _subTaskOption = false;
    notifyListeners();
  }

  //  --------- Other options control end -------

  // --------- New Task Title  -----------
  addTaskTitle(String title) {
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        FirebaseFirestore.instance
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .doc(title)
            .set(Task(taskTitle: title, taskList: []).toJson());
      } catch (e) {
        print(e);
      }
    }
    _task.add(
      Task(
        taskTitle: title,
        taskList: [],
      ),
    );
    currentTaskIs = _task.length - 1;
    notifyListeners();
  }

  fetchTaskTitle() async {
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        final get = await FirebaseFirestore.instance
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .get();
        get.docs.map((e) {
          e.data();
          print(e);
        });
      } catch (e) {
        print(e);
      }
    }
  }

  deleteTaskTitleWithThatList(int taskIndex) {
    _task.removeAt(taskIndex);
    notifyListeners();
  }
  // --- End of New Task Title ----

  // ------- Adding a new Task to the list --------
  addNewTaskToList(TaskList task) {
    _task[currentTaskIs].taskList!.add(task);
    notifyListeners();
  }

  editTaskToList(
    String taskId, {
    String? name,
    String? description,
    String? date_time,
  }) {
    int subTaskIndex =
        _task[currentTaskIs].taskList!.indexWhere((e) => e.taskId == taskId);
    _task[currentTaskIs].taskList![subTaskIndex].taskName = "${name}";
    _task[currentTaskIs].taskList![subTaskIndex].taskDescription = description;
    _task[currentTaskIs].taskList![subTaskIndex].taskEndDate = date_time;
    notifyListeners();
  }

  removeTaskFromList(String taskId) {
    final _taskList = _task[currentTaskIs].taskList;
    if (_taskList != null) {
      _taskList.removeAt(
        _taskList.indexWhere((element) => element.taskId == taskId),
      );
    }
    notifyListeners();
  }
  //  ----- End of Adding a new Task to the list ------
}

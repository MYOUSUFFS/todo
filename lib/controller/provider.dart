import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:todo/model/task.dart';

class MainProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  doLoading(bool nowIs) {
    _isLoading = nowIs;
    notifyListeners();
  }

  List<Task> _task = [];
  List<Task> get task => _task;

  // -------- Current Task begin -----------

  int _currentTaskIs = 0;
  int get currentTaskIs => _currentTaskIs;

  changeCurrentTask(int index) {
    _currentTaskIs = index;
    closeAllOption();
    notifyListeners();
  }

  //  -------- Current Task end   ----------

  // --------- New Task Title  -----------
  addTaskTitle(String title) {
    final itsAvaiable = _task.where((e) => e.taskTitle == title);
    if (FirebaseAuth.instance.currentUser != null && itsAvaiable.length <= 0) {
      try {
        FirebaseFirestore.instance
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .doc(title)
            .set(Task(taskTitle: title, taskList: []).toJson());
      } catch (e) {
        print(e);
      }

      _task.add(
        Task(
          taskTitle: title,
          taskList: [],
        ),
      );
      _currentTaskIs = _task.length - 1;
      notifyListeners();
    } else {
      toast("Please choose another name.");
    }
  }

  fetchTaskTitle() async {
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        final get = await FirebaseFirestore.instance
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .get();
        for (int i = 0; i < get.docs.length; i++) {
          _task.add(Task.fromJson(get.docs[i].data()));
        }
        print("object fire get");
      } catch (e) {
        print(e);
      }
    }
    notifyListeners();
  }

  deleteTaskTitleWithThatList(int taskIndex) {
    _task.removeAt(taskIndex);
    notifyListeners();
  }
  // --- End of New Task Title ----

  // ------- Adding a new Task to the list --------
  addNewTaskToList(TaskList tasktolist) {
    try {
      FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(_task[_currentTaskIs].taskTitle)
          .update({
        "task-list": FieldValue.arrayUnion([tasktolist.toJson()])
      });
      // print("addNewTaskToList");
      notifyListeners();
    } catch (e) {
      print(e);
    }
    _task[_currentTaskIs].taskList!.add(tasktolist);
    notifyListeners();
  }

  editTaskToList(
    String taskId, {
    String? name,
    String? description,
    String? date_time,
  }) {
    int subTaskIndex =
        _task[_currentTaskIs].taskList!.indexWhere((e) => e.taskId == taskId);
    _task[_currentTaskIs].taskList![subTaskIndex].taskName = "${name}";
    _task[_currentTaskIs].taskList![subTaskIndex].taskDescription = description;
    _task[_currentTaskIs].taskList![subTaskIndex].taskEndDate = date_time;
    notifyListeners();
  }

  taskCompleted(String taskId) {
    int subTaskIndex =
        _task[_currentTaskIs].taskList!.indexWhere((e) => e.taskId == taskId);
    _task[_currentTaskIs].taskList![subTaskIndex].taskStatus =
        !_task[_currentTaskIs].taskList![subTaskIndex].taskStatus;
    notifyListeners();
  }

  removeTaskFromList(String taskId) async {
    try {
      if (_task[_currentTaskIs].taskList != null) {
        final _taskIndex = _task[_currentTaskIs]
            .taskList!
            .indexWhere((element) => element.taskId == taskId);

        if (_taskIndex >= 0) {
          // Update Firestore document
          await FirebaseFirestore.instance
              .collection(FirebaseAuth.instance.currentUser!.uid)
              .doc(_task[_currentTaskIs].taskTitle)
              .update({
            "task-list": FieldValue.arrayRemove(
                [_task[_currentTaskIs].taskList![_taskIndex].toJson()]),
          });
          // Remove task from list locally
          _task[_currentTaskIs].taskList!.removeAt(_taskIndex);

          // print('Task removed successfully');
          notifyListeners(); // Notify listeners to update the UI
        } else {
          print('Task not found in the list');
        }
      }
    } catch (e) {
      print('Error removing task: $e');
    }
  }

  //  ----- End of Adding a new Task to the list ------

  // --------- Other options contole begin --------

  bool _completedTaskShow = false;
  bool get completedTaskShow => _completedTaskShow;

  openCompletedTask() {
    _completedTaskShow = !_completedTaskShow;
    notifyListeners();
  }

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
}

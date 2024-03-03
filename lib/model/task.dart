class Task {
  String? taskTitle;
  List<TaskList>? taskList;

  Task({
    required this.taskTitle,
    required this.taskList,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        taskTitle: json["task-title"],
        taskList: json["task-list"] == null
            ? []
            : List<TaskList>.from(
                json["task-list"]!.map((x) => TaskList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "task-title": taskTitle,
        "task-list": taskList == null
            ? []
            : List<dynamic>.from(taskList!.map((x) => x.toJson())),
      };
}

class TaskList {
  String taskId;
  String taskName;
  String? taskDescription;
  String? taskEndDate;
  bool taskStatus;
  String taskCreate;

  TaskList({
    required this.taskId,
    required this.taskName,
    this.taskDescription,
    this.taskEndDate,
    required this.taskStatus,
    required this.taskCreate,
  });

  factory TaskList.fromJson(Map<String, dynamic> json) => TaskList(
        taskId: json["task-id"],
        taskName: json["task-name"],
        taskDescription: json["task-description"],
        taskEndDate: json["task-end-date"],
        taskStatus: json["task-status"],
        taskCreate: json["task-create"],
      );

  Map<String, dynamic> toJson() => {
        "task-id": taskId,
        "task-name": taskName,
        "task-description": taskDescription,
        "task-end-date": taskEndDate,
        "task-status": taskStatus,
        "task-create": taskCreate,
      };
}

import 'dart:convert';

class TaskResponseModel {
  String? createdAt;
  String? name;
  String? avatar;
  String? id;
  String? taskName;
  String? taskTitle;
  String? taskDescription;
  bool? completeStatus;

  TaskResponseModel({
    this.createdAt,
    this.name,
    this.avatar,
    this.id,
    this.taskName,
    this.taskTitle,
    this.taskDescription,
    this.completeStatus,
  });

  factory TaskResponseModel.fromRawJson(String str) => TaskResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) => TaskResponseModel(
    createdAt: json["createdAt"],
    name: json["name"],
    avatar: json["avatar"],
    id: json["id"],
    taskName: json["task_name"],
    taskTitle: json["task_title"],
    taskDescription: json["task_description"],
    completeStatus: json["complete_status"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt,
    "name": name,
    "avatar": avatar,
    "id": id,
    "task_name": taskName,
    "task_title": taskTitle,
    "task_description": taskDescription,
    "complete_status": completeStatus,
  };
}

import 'package:flutter/cupertino.dart';
import '../models/task_response_model.dart';
import '../repositories/task_repository.dart';

class TaskViewModel extends ChangeNotifier{

  final TaskRepository taskRepository = TaskRepository();
  final List<TaskResponseModel> taskList = [];
  bool isLoading = false;

  getTaskList() async {
    isLoading = true;
    var response = await taskRepository.getTaskList();

    response.fold((l) => null, (r) {
      taskList.addAll(r);
    });
    isLoading = false;
    notifyListeners();
  }

}
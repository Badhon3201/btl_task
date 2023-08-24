import 'package:flutter/cupertino.dart';
import '../../../main.dart';
import '../models/task_response_model.dart';
import '../repositories/task_repository.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository taskRepository = TaskRepository();
  final List<TaskResponseModel> taskList = [];
  TaskResponseModel addTaskResponse = TaskResponseModel();
  bool isLoading = false;
  var taskNameController = TextEditingController();
  var taskTitleController = TextEditingController();
  var taskDescriptionController = TextEditingController();
  bool completeStatus = true;
  bool isSearch = false;
  double screenHeight = 0;
  double screenWidth = 0;
  var isChecked = false;
  var formKey = GlobalKey<FormState>();

  bool startAnimation = false;
  bool startAnimationSearch = false;

  bool isExpanded = false;

  void toggleSearchBar() {
    isExpanded = !isExpanded;
    notifyListeners();
  }

  clearData() {
    taskNameController.clear();
    taskTitleController.clear();
    taskDescriptionController.clear();
    notifyListeners();
  }

  getTaskList() async {
    isLoading = true;
    var response = await taskRepository.getTaskList();

    response.fold((l) => null, (r) {
      taskList.addAll(r);
    });
    isLoading = false;
    notifyListeners();
  }

  saveTask() async {
    isLoading = true;
    var response = await taskRepository.adTask(
        taskNameController.text,
        taskTitleController.text,
        taskDescriptionController.text,
        completeStatus);

    response.fold((l) => null, (r) {
      addTaskResponse = r;
      Navigator.pop(navigatorKey.currentState!.context);
      taskList.add(r);
      clearData();
    });
    isLoading = false;
    notifyListeners();
  }

  updateTask(int id) async {
    isLoading = true;
    var response = await taskRepository.updateTask(
        id,
        taskNameController.text,
        taskTitleController.text,
        taskDescriptionController.text,
        completeStatus);

    response.fold((l) => null, (r) {
      addTaskResponse = r;
      Navigator.pop(navigatorKey.currentState!.context);
      taskList.clear();
      clearData();
      getTaskList();
    });
    isLoading = false;
    notifyListeners();
  }
}

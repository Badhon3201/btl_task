import 'package:flutter/cupertino.dart';
import '../../../core/utils/failure/app_error.dart';
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
  var formKey = GlobalKey<FormState>();
  late AppError _appError;
  bool startAnimation = false;
  bool startAnimationSearch = false;

  bool isExpanded = false;

  var searchController = TextEditingController();

  void toggleSearchBar() {
    isExpanded = !isExpanded;
    searchController.clear();
    getTaskList();
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
    notifyListeners();
    var response = await taskRepository.getTaskList(searchController.text);

    response.fold((l) {
      isLoading = false;
      _appError = l;
      notifyListeners();
    }, (r) {
      taskList.clear();
      taskList.addAll(r);
      isLoading = false;
      notifyListeners();
    });
    notifyListeners();
  }

  saveTask() async {
    isLoading = true;
    var response = await taskRepository.adTask(
        taskNameController.text,
        taskTitleController.text,
        taskDescriptionController.text,
        completeStatus);

    response.fold((l) {
      _appError = l;
      notifyListeners();
    }, (r) {
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

    response.fold((l) {
      _appError = l;
      notifyListeners();
    }, (r) {
      addTaskResponse = r;
      Navigator.pop(navigatorKey.currentState!.context);
      taskList.clear();
      clearData();
      getTaskList();
    });
    isLoading = false;
    notifyListeners();
  }

  deleteTask(int id) async {
    isLoading = true;
    var response = await taskRepository.deleteTask(id);

    response.fold((l) {
      _appError = l;
    }, (r) async {
      taskList.clear();
      await getTaskList();
    });
    isLoading = false;
  }

  void getDataController(addTaskResponse) {
    taskTitleController.text = addTaskResponse?.taskTitle ?? "";
    taskNameController.text = addTaskResponse?.taskName ?? "";
    taskDescriptionController.text = addTaskResponse?.taskDescription ?? "";
    completeStatus = addTaskResponse?.completeStatus ?? false;
  }


  AppError get appError => _appError;
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/core/widgets/common_text_field.dart';

import '../../../core/values/color_manager.dart';
import '../../../core/values/string_resources.dart';
import '../../../main.dart';
import '../models/task_response_model.dart';
import '../view_models/task_view_model.dart';

class AddNewTaskScreen extends StatefulWidget {
   AddNewTaskScreen(
      {super.key, required this.screenNavigator, this.taskItem});

  final String screenNavigator;
  final TaskResponseModel? taskItem;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  var provider = Provider.of<TaskViewModel>(navigatorKey.currentState!.context,
      listen: false);
  final argument =  ModalRoute.of(navigatorKey.currentState!.context)!.settings.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.screenNavigator == "edit" || widget.screenNavigator == "view") {
      provider.taskTitleController.text = widget.taskItem?.taskTitle ?? "";
      provider.taskNameController.text = widget.taskItem?.taskName ?? "";
      provider.taskDescriptionController.text =
          widget.taskItem?.taskDescription ?? "";
      provider.isChecked = widget.taskItem?.completeStatus ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: bodySection(),
    );
  }

  PreferredSizeWidget appbar() {
    return AppBar(
      backgroundColor: ColorManager.whiteColor,
      iconTheme: IconThemeData(color: ColorManager.grayColor),
      elevation: 0,
      title: Text(
        widget.screenNavigator == "Add"
            ? StringResources.addTask
            : widget.screenNavigator == "edit"
                ? StringResources.editTask
                : StringResources.viewTask,
        style: TextStyle(
          color: ColorManager.grayColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget bodySection() {
    var screenWidth = MediaQuery.of(context).size.width;
    var sizedBox = const SizedBox(height: 10);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: provider.formKey,
          child: Column(
            children: [
              CommonTextField(
                hinText: StringResources.taskName,
                controller: provider.taskNameController,
                isLabel: false,
                prefixIcon: Icon(
                  Icons.task,
                  color: ColorManager.grayColor,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringResources.requiredText;
                  }
                  return null;
                },
              ),
              sizedBox,
              CommonTextField(
                controller: provider.taskTitleController,
                hinText: StringResources.taskTitle,
                isLabel: false,
                prefixIcon: Icon(
                  Icons.title,
                  color: ColorManager.grayColor,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringResources.requiredText;
                  }
                  return null;
                },
              ),
              sizedBox,
              CommonTextField(
                hinText: StringResources.taskDescription,
                controller: provider.taskDescriptionController,
                maxLine: 3,
                isLabel: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return StringResources.requiredText;
                  }
                  return null;
                },
              ),
              sizedBox,
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0XFFE2E2E2)),
                    borderRadius: BorderRadius.circular(25)),
                child: CheckboxListTile(
                  title: Text(
                    StringResources.completeStatus,
                    style: TextStyle(
                        color: ColorManager.grayColor,
                        fontWeight: FontWeight.w500),
                  ),
                  checkColor: Colors.white,
                  value: provider.isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      provider.isChecked = value!;
                    });
                  },
                ),
              ),
              sizedBox,
              sizedBox,
              sizedBox,
              ElevatedButton(
                onPressed: () {
                  if (provider.formKey.currentState!.validate()) {
                    widget.screenNavigator == "Add"
                        ? provider.saveTask()
                        : provider.updateTask(int.parse(widget.taskItem!.id!));
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.blueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0))),
                child: SizedBox(
                  height: 50,
                  width: screenWidth,
                  child: Center(
                    child: Text(StringResources.submit,
                        style: TextStyle(
                            color: ColorManager.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:btl_task/core/utils/styles.dart';
import 'package:btl_task/core/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/values/color_manager.dart';
import '../../../core/values/string_resources.dart';
import '../../../core/widgets/common_text_field.dart';
import '../../../main.dart';
import '../models/task_response_model.dart';
import '../view_models/task_view_model.dart';

class AddEditViewTaskScreen extends StatefulWidget {
  const AddEditViewTaskScreen({super.key, this.screenNavigator, this.taskItem});

  final String? screenNavigator;
  final TaskResponseModel? taskItem;

  static const routeName = '/detailsRoutes';

  @override
  State<AddEditViewTaskScreen> createState() => _AddEditViewTaskScreenState();
}

class _AddEditViewTaskScreenState extends State<AddEditViewTaskScreen> {
  var provider = Provider.of<TaskViewModel>(navigatorKey.currentState!.context,
      listen: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.screenNavigator == StringResources.editTask ||
        widget.screenNavigator == StringResources.viewTask) {
      provider.getDataController(widget.taskItem);

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
        widget.screenNavigator == StringResources.addTask
            ? StringResources.addTask
            : widget.screenNavigator == StringResources.editTask
                ? StringResources.editTask
                : StringResources.viewTask,
        style: TextStyles.hintStyle,
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
                readOnly: widget.screenNavigator == StringResources.viewTask
                    ? true
                    : false,
                prefixIcon: Icon(
                  Icons.task,
                  color: ColorManager.grayColor,
                ),
                validator: (value) => Validator.validateEmptyField(value),
              ),
              sizedBox,
              CommonTextField(
                controller: provider.taskTitleController,
                hinText: StringResources.taskTitle,
                readOnly: widget.screenNavigator == StringResources.viewTask
                    ? true
                    : false,
                isLabel: false,
                prefixIcon: Icon(
                  Icons.title,
                  color: ColorManager.grayColor,
                ),
                validator: (value) => Validator.validateEmptyField(value),
              ),
              sizedBox,
              CommonTextField(
                hinText: StringResources.taskDescription,
                controller: provider.taskDescriptionController,
                readOnly: widget.screenNavigator == StringResources.viewTask
                    ? true
                    : false,
                maxLine: 3,
                isLabel: false,
                validator: (value) => Validator.validateEmptyField(value),
              ),
              sizedBox,
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0XFFE2E2E2)),
                    borderRadius: BorderRadius.circular(25)),
                child: CheckboxListTile(
                  title: Text(
                    StringResources.completeStatus,
                    style: TextStyles.hintStyle,
                  ),
                  checkColor: Colors.white,
                  value: provider.completeStatus,
                  onChanged: widget.screenNavigator == StringResources.viewTask
                      ? null
                      : (bool? value) {
                          provider.completeStatus = value!;
                          setState(() {});
                        },
                ),
              ),
              sizedBox,
              sizedBox,
              sizedBox,
              widget.screenNavigator == StringResources.viewTask
                  ? SizedBox()
                  : ElevatedButton(
                      onPressed: () async {
                        if (provider.formKey.currentState!.validate()) {
                          widget.screenNavigator == StringResources.addTask
                              ? await provider.saveTask()
                              : await provider
                                  .updateTask(int.parse(widget.taskItem!.id!));
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
                          child: Text(
                              widget.screenNavigator == StringResources.addTask
                                  ? StringResources.submit
                                  : StringResources.resubmit,
                              style: TextStyles.whiteBoldStyle),
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

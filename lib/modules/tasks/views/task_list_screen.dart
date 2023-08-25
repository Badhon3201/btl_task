import 'package:btl_task/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/values/color_manager.dart';
import '../../../core/values/string_resources.dart';
import '../../../core/widgets/common_text_field.dart';
import '../../../main.dart';
import '../models/task_screen_arg.dart';
import '../view_models/task_view_model.dart';
import 'widgets/user_list_tile.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  var screenHeight =
      MediaQuery.of(navigatorKey.currentState!.context).size.height;
  var screenWidth =
      MediaQuery.of(navigatorKey.currentState!.context).size.width;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var provider = Provider.of<TaskViewModel>(
          navigatorKey.currentState!.context,
          listen: false);
      await provider.getTaskList();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          provider.startAnimation = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskViewModel>(context);
    return Scaffold(
      appBar: appbar(provider),
      body: bodySection(provider),
      floatingActionButton: addNewUserButton(provider),
    );
  }

  Widget bodySection(TaskViewModel provider) {
    return SafeArea(
      child: provider.isLoading==true
          ? const Center(child: CircularProgressIndicator())
          : provider.taskList.isEmpty
              ? Center(
                  child: Text(StringResources.noDatFound),
                )
              : ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: provider.taskList.length,
                  itemBuilder: (context, index) {
                    return item(provider.taskList[index], index, provider);
                  },
                ),
    );
  }

  Widget item(taskItem, int index, TaskViewModel provider) {
    return AnimatedContainer(
      width: screenWidth,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300 + (index * 100)),
      transform: Matrix4.translationValues(
          provider.startAnimation ? 0 : screenWidth, 0, 0),
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth / 40,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: UserListTile(taskItem: taskItem),
    );
  }

  PreferredSizeWidget appbar(TaskViewModel provider) {
    return AppBar(
      backgroundColor: ColorManager.whiteColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: provider.isExpanded
          ? null
          : Text(
              StringResources.task,
              style: TextStyles.grayBoldStyle,
            ),
      actions: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: provider.isExpanded ? screenWidth : 0.0,
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: provider.isExpanded
              ? Container(
                  decoration: BoxDecoration(
                    color:
                        ColorManager.whiteColor, // Set white background color
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: CommonTextField(
                    hinText: StringResources.search,
                    contentPadding: EdgeInsets.zero,
                    controller: provider.searchController,
                    onTap: (){
                      provider.searchController.text.isNotEmpty?provider.getTaskList():null;
                    },
                    onFieldSubmitted:(String v){
                      provider.searchController.text.isNotEmpty?provider.getTaskList():null;
                    },
                    isLabel: false,
                    prefixIcon: Icon(
                      Icons.search,
                      color: ColorManager.grayColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: ColorManager.grayColor,
                      ),
                      onPressed: provider.toggleSearchBar,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
        if (!provider.isExpanded)
          IconButton(
            icon: Icon(
              Icons.search,
              color: ColorManager.grayColor,
            ),
            onPressed: provider.toggleSearchBar,
          ),
      ],
    );
  }

  Widget addNewUserButton(TaskViewModel provider) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        provider.clearData();
        Navigator.pushNamed(context, "/${StringResources.detailsRoutes}",
            arguments:
                TaskScreenArguments(screenNavigator: StringResources.addTask));
      },
      child: Container(
        height: 50,
        width: screenWidth * 0.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorManager.whiteColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: const Offset(-0, 1),
                  color: ColorManager.grayColor.withOpacity(0.2))
            ]),
        child: Center(
            child: Text(
          StringResources.addTask,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        )),
      ),
    );
  }
}

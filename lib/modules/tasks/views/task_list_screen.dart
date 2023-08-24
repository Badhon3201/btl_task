import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/core/values/color_manager.dart';
import 'package:untitled4/modules/tasks/views/widgets/user_list_tile.dart';
import '../../../core/values/string_resources.dart';
import '../../../core/widgets/common_text_field.dart';
import '../../../main.dart';
import '../models/task_response_model.dart';
import '../repositories/task_repository.dart';
import '../view_models/task_view_model.dart';
import 'add_new_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  var providers = Provider.of<TaskViewModel>(navigatorKey.currentState!.context,
      listen: false);
  var screenHeight =
      MediaQuery.of(navigatorKey.currentState!.context).size.height;
  var screenWidth =
      MediaQuery.of(navigatorKey.currentState!.context).size.width;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await providers.getTaskList();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          providers.startAnimation = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: bodySection(),
      floatingActionButton: addNewUserButton(),
    );
  }

  Widget bodySection() {
    var provider = Provider.of<TaskViewModel>(context, listen: true);
    return SafeArea(
      child: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: provider.taskList.length,
                    itemBuilder: (context, index) {
                      return item(provider.taskList[index], index);
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
    );
  }

  Widget item(taskItem, int index) {
    var screenWidth = MediaQuery.of(context).size.width;
    var provider = Provider.of<TaskViewModel>(context, listen: true);
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

  PreferredSizeWidget appbar() {
    var provider = Provider.of<TaskViewModel>(context, listen: true);
    return AppBar(
      backgroundColor: ColorManager.whiteColor,
      elevation: 0,
      title: provider.isExpanded
          ? null
          : Text(
              StringResources.task,
              style: TextStyle(
                color: ColorManager.grayColor,
                fontWeight: FontWeight.bold,
              ),
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

  Widget addNewUserButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        providers.clearData();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>  AddNewTaskScreen(screenNavigator: "Add"),
        ));
        Navigator.pushNamed(context, "routeName", arguments: {"add": "add"});
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

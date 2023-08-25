import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/values/string_resources.dart';
import '../../../../main.dart';
import '../../models/task_response_model.dart';
import '../../models/task_screen_arg.dart';
import '../../view_models/task_view_model.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({super.key, required this.taskItem});

  final TaskResponseModel taskItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(navigatorKey.currentState!.context,
            "/${StringResources.detailsRoutes}", arguments: TaskScreenArguments(screenNavigator: StringResources.viewTask,taskItem: taskItem));
      },
      leading: Image.network(
        "https://cdn-icons-png.flaticon.com/512/2098/2098402.png",
        height: 40,
      ),
      title: Text(
        taskItem.taskName ?? "",
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(taskItem.taskTitle ?? ""),
      trailing: popupMenu(taskItem),
    );
  }

  Widget popupMenu(TaskResponseModel taskItem) {
    String selectedMenu = "";
    return PopupMenuButton<String>(
      initialValue: selectedMenu,
      onSelected: (String item) {
        selectedMenu = item;
        if (selectedMenu == StringResources.edit) {
          Navigator.pushNamed(navigatorKey.currentState!.context,
              "/${StringResources.detailsRoutes}", arguments: TaskScreenArguments(screenNavigator: StringResources.editTask,taskItem: taskItem));
        } else {
          showAlertDialog(int.parse(taskItem.id!));
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: StringResources.edit,
          child: Text(StringResources.edit),
        ),
        PopupMenuItem<String>(
          value: StringResources.delete,
          child: Text(StringResources.delete),
        ),
      ],
    );
  }

  showAlertDialog(int id) {
    AwesomeDialog(
      context: navigatorKey.currentState!.context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Delete?',
      desc: 'Are you sure you want to delete this task?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Provider.of<TaskViewModel>(navigatorKey.currentState!.context,listen: false)
            .deleteTask(id);
      },
    ).show();
  }
}

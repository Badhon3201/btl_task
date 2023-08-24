import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/core/values/string_resources.dart';
import 'package:untitled4/modules/tasks/view_models/task_view_model.dart';

import '../../../../main.dart';
import '../../models/task_response_model.dart';
import '../add_new_task_screen.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({super.key, required this.taskItem});

  final TaskResponseModel taskItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
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
          Navigator.of(navigatorKey.currentState!.context)
              .push(MaterialPageRoute(
            builder: (context) =>
                AddNewTaskScreen(screenNavigator: "edit", taskItem: taskItem),
          ));
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
      desc: 'Are you sure you want to delete this item?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Provider.of<TaskViewModel>(navigatorKey.currentState!.context)
            .updateTask(id);
      },
    ).show();
  }
}

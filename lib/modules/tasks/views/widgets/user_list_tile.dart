import 'package:flutter/material.dart';
import 'package:untitled4/core/values/string_resources.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Image.network(
        "https://cdn-icons-png.flaticon.com/512/2098/2098402.png",
        height: 40,
      ),
      // ing: CircleAvatar(
      //   backgroundColor: Colors.grey.shade300,
      //   foregroundColor: Colors.black,
      //   radius: 30,
      //   child: const CircleAvatar(
      //     radius: 24,
      //     backgroundImage: NetworkImage(
      //         "https://cdn-icons-png.flaticon.com/512/2098/2098402.png"),
      //   ),
      // ),
      title: const Text(
        "Joe Belfire",
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: const Text("Software Engineer"),
      trailing: popupMenu(),
    );
  }

  Widget popupMenu() {
    String selectedMenu = "";
    return PopupMenuButton<String>(
      initialValue: selectedMenu,
      // Callback that sets the selected popup menu item.
      onSelected: (String item) {
        selectedMenu = item;
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
}

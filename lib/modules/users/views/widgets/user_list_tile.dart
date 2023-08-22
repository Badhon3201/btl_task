import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade300,
        foregroundColor: Colors.black,
        radius: 30,
        child: const CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80"),
        ),
      ),
      title: Text(
        "Joe Belfire",
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text("Software Engineer"),
      trailing: IconButton(
        icon: Icon(Icons.more_vert_rounded),
        onPressed: () {},
      ),
    );
  }
}

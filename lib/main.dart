import 'package:flutter/material.dart';

import 'modules/users/views/user_list_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: UserListScreen()));
}

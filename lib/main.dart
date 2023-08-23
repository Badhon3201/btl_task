import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/tasks/view_models/task_view_model.dart';
import 'modules/tasks/views/user_list_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (context) => TaskViewModel(),
    child: const MaterialApp(
        debugShowCheckedModeBanner: false, home: UserListScreen()),
  ));
}

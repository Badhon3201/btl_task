import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/tasks/view_models/task_view_model.dart';
import 'modules/tasks/views/task_list_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      ChangeNotifierProvider(
    create: (context) => TaskViewModel(),
    child:  MaterialApp(
      navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false, home: const TaskListScreen()),
  ));
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
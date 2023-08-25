import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/values/string_resources.dart';
import 'modules/splash/views/splash_screen.dart';
import 'modules/tasks/models/task_screen_arg.dart';
import 'modules/tasks/view_models/task_view_model.dart';
import 'modules/tasks/views/add_edit_view_task_screen.dart';
import 'modules/tasks/views/task_list_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (context) => TaskViewModel(),
    child: MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/${StringResources.taskRoutes}': (context) => const TaskListScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AddEditViewTaskScreen.routeName) {
          final args = settings.arguments as TaskScreenArguments;
          return MaterialPageRoute(
            builder: (context) {
              return AddEditViewTaskScreen(
                screenNavigator: args.screenNavigator,
                taskItem: args.taskItem,
              );
            },
          );
        }
      },
    ),
  ));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

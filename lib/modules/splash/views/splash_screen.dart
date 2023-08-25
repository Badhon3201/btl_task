import 'package:flutter/material.dart';

import '../../../core/values/string_resources.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context,
          "/${StringResources.taskRoutes}",
          ModalRoute.withName('/${StringResources.taskRoutes}'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        "Byte Trek Ltd",
        style: TextStyle(fontSize: 22),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:untitled4/core/values/color_manager.dart';
import 'package:untitled4/modules/tasks/views/widgets/user_list_tile.dart';
import '../../../core/values/string_resources.dart';
import '../../../core/widgets/common_text_field.dart';
import '../repositories.dart';
import 'add_new_user_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  TaskRepository taskRepository = TaskRepository();
  bool isSearch = false;
  double screenHeight = 0;
  double screenWidth = 0;

  bool startAnimation = false;
  bool startAnimationSearch = false;

  bool _isExpanded = false;

  void _toggleSearchBar() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  List<String> texts = [
    "Monetization",
    "Pie Chart",
    "Flag",
    "Notification",
    "Savings",
    "Cloud",
    "Nightlight",
    "Assignment",
    "Location",
    "Settings",
    "Rocket",
    "Backpack",
    "Person",
    "Done All",
    "Search",
    "Extension",
    "Bluetooth",
    "Favorite",
    "Lock",
    "Bookmark",
  ];

  List<IconData> icons = [
    Icons.monetization_on,
    Icons.pie_chart,
    Icons.flag,
    Icons.notifications,
    Icons.savings,
    Icons.cloud,
    Icons.nightlight_round,
    Icons.assignment,
    Icons.location_pin,
    Icons.settings,
    Icons.rocket,
    Icons.backpack,
    Icons.person,
    Icons.done_all,
    Icons.search,
    Icons.extension,
    Icons.bluetooth,
    Icons.favorite,
    Icons.lock,
    Icons.bookmark,
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
    taskRepository.getCompanyFromServer();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appbar(),
      body: bodySection(),
      floatingActionButton: addNewUserButton(),
    );
  }

  Widget bodySection() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: texts.length,
              itemBuilder: (context, index) {
                return item(index);
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

  Widget item(int index) {
    return AnimatedContainer(
      width: screenWidth,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300 + (index * 100)),
      transform:
          Matrix4.translationValues(startAnimation ? 0 : screenWidth, 0, 0),
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth / 40,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: const UserListTile(),
    );
  }

  PreferredSizeWidget appbar() {
    return AppBar(
      backgroundColor: ColorManager.whiteColor,
      elevation: 0,
      title: _isExpanded
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
          width: _isExpanded ? screenWidth : 0.0,
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: _isExpanded
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
                      onPressed: _toggleSearchBar,
                    ),
                  ),
                )
              : const SizedBox(),
        ),
        if (!_isExpanded)
          IconButton(
            icon: Icon(
              Icons.search,
              color: ColorManager.grayColor,
            ),
            onPressed: _toggleSearchBar,
          ),
      ],
    );
  }

  Widget addNewUserButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const AddNewUserScreen(),
        ));
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

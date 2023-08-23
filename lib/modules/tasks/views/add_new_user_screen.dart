import 'package:flutter/material.dart';
import 'package:untitled4/core/widgets/common_text_field.dart';

import '../../../core/values/color_manager.dart';
import '../../../core/values/string_resources.dart';

class AddNewUserScreen extends StatefulWidget {
  const AddNewUserScreen({super.key});

  @override
  State<AddNewUserScreen> createState() => _AddNewUserScreenState();
}

class _AddNewUserScreenState extends State<AddNewUserScreen> {
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: bodySection(),
    );
  }

  PreferredSizeWidget appbar() {
    return AppBar(
      backgroundColor: ColorManager.whiteColor,
      iconTheme: IconThemeData(color: ColorManager.grayColor),
      elevation: 0,
      title: Text(
        StringResources.addTask,
        style: TextStyle(
          color: ColorManager.grayColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget bodySection() {
    var screenWidth = MediaQuery.of(context).size.width;
    var sizedBox = const SizedBox(height: 10);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            CommonTextField(
              hinText: StringResources.taskName,
              isLabel: false,
              prefixIcon: Icon(
                Icons.task,
                color: ColorManager.grayColor,
              ),
            ),
            sizedBox,
            CommonTextField(
              hinText: StringResources.taskTitle,
              isLabel: false,
              prefixIcon: Icon(
                Icons.title,
                color: ColorManager.grayColor,
              ),
            ),
            sizedBox,
            CommonTextField(
              hinText: StringResources.taskDescription,
              maxLine: 3,
              isLabel: false,
            ),
            sizedBox,
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0XFFE2E2E2)),
                  borderRadius: BorderRadius.circular(25)),
              child: CheckboxListTile(
                title: Text(
                  StringResources.completeStatus,
                  style: TextStyle(
                      color: ColorManager.grayColor,
                      fontWeight: FontWeight.w500),
                ),
                checkColor: Colors.white,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
            ),
            sizedBox,
            sizedBox,
            sizedBox,
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.blueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0))),
              child: SizedBox(
                height: 50,
                width: screenWidth,
                child: Center(
                  child: Text(StringResources.submit,
                      style: TextStyle(
                          color: ColorManager.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
